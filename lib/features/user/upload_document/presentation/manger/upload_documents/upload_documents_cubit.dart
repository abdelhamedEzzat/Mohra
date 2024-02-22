import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/features/user/upload_document/data/company_document_model.dart';
import 'package:path/path.dart';

part 'upload_documents_state.dart';

class UploadDocumentsCubit extends Cubit<UploadDocumentsState> {
  UploadDocumentsCubit() : super(UploadDocumentsInitial());

  // final Box<CompanyDocument> _uploadedDocumentsBox =
  //     Hive.box<CompanyDocument>('uploaded_documents');

  String url = "";
  String imageurl = "";
  String comment = "";
  PlatformFile? filePlatforme;
  String fileName = "";
  FilePickerResult? result;
  File? files;
  XFile? photo;
  File? imagefile;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  PlatformFile? fileExtention;
  String? nameOfImage;
  int docNumber = 1;

  Future uploadFile() async {
    emit(UploadDocumentLoading());

    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'docx', 'xlsx', 'JPEG', 'PNG'],
      );

      if (result != null && result!.files.single.path != null) {
        filePlatforme = result!.files.first;
        files = File(result!.files[0].path!);
      }

      emit(UploadDocumentSuccess());
    } catch (e) {
      emit(UploadDocumentfaild(error: "You Didnt Upload Any Files "));
    }
  }

  Future<int> getNextDocumentNumber(String companyId) async {
    QuerySnapshot documentsSnapshot = await Constanscollection.compnyDocument
        .where('companydocID', isEqualTo: companyId)
        .get();

    // If there are previous documents, get the maximum document number
    if (documentsSnapshot.docs.isNotEmpty) {
      int maxDocumentNumber = documentsSnapshot.docs
          .map<int>((doc) => doc['docNumer'] as int)
          .reduce((value, element) => value > element ? value : element);

      return maxDocumentNumber + 1;
    } else {
      // If no previous documents, start from 1
      return 1;
    }
  }

  Future pickFile({
    required int docNumber,
    required String filename,
    required File file,
    required String comment,
    required String companydocID,
  }) async {
    emit(UploadDocumentLoading());

    try {
      if (result != null && result!.files.isNotEmpty) {
        fileName = filename;
        fileName = result!.files[0].name;

        final refrance =
            FirebaseStorage.instance.ref("Document Company").child(fileName);

        final uploadTask = refrance.putFile(file);

        await uploadTask.whenComplete(() {});
        url = await refrance.getDownloadURL();
        final docID =
            FirebaseFirestore.instance.collection('Document').doc().id;

        int nextDocumentNumber = await getNextDocumentNumber(companydocID);
        await Constanscollection.compnyDocument.add(
          {
            "name": fileName,
            "url": url,
            "comment": comment,
            "userid": userId,
            "companydocID": companydocID,
            "fileExtention": filePlatforme!.extension,
            'DocID': docID,
            "status": "Wating for Review",
            'companyName': "",
            'invoiceDate': "",
            'invoiceNumber': "",
            'amountOfTheInvoice': "",
            'selectItem': "",
            'selectTypeItem': "",
            'commentForAccountatnt': "",
            'docNumer': nextDocumentNumber,
          },
        );

        // final uploadedDocument = CompanyDocument(
        //   name: filename,
        //   url: url,
        //   comment: comment,
        //   userId: userId,
        //   companyDocId: companydocID,
        //   fileExtension: filePlatforme!.extension,
        //   docId: docID,
        //   status: "Wating for Review",
        //   companyName: "",
        //   invoiceDate: "",
        //   invoiceNumber: "",
        //   amountOfTheInvoice: "",
        //   selectItem: "",
        //   selectTypeItem: "",
        //   commentForAccountant: "",
        //   docNumber: nextDocumentNumber,
        // );
        // _uploadedDocumentsBox.add(uploadedDocument);
      }

      emit(UploadDocumentSuccess());
    } catch (e) {
      emit(UploadDocumentfaild(
          error: "Failed to add DocumentCompany:${e.toString()}"));
    }
  }

  Future<void> openCameraAndShowImage() async {
    emit(UploadDocumentLoading());

    try {
      final ImagePicker picker = ImagePicker();
      photo = await picker.pickImage(source: ImageSource.camera);
      imagefile = File(photo!.path);

      // You can display the image on the screen without uploading
      // For example, you can set it to an Image widget in your UI
      // imageWidget = Image.file(imagefile!);

      emit(UploadDocumentSuccess());
    } catch (e) {
      emit(const UploadDocumentfaild(error: "You Didnt Upload Any Document "));
    }
  }

// Function to upload image to Firebase Storage and add information to Firestore

  Future<void> uploadImageAndAddInfoToFirestore({
    required String comment,
    required String companydocID,
    required int docNumber,
  }) async {
    emit(UploadDocumentLoading());

    try {
      if (imagefile != null) {
        var imageName = basename(imagefile!.path);
        final storage = FirebaseStorage.instance;
        var companyImageRef =
            storage.ref("Image Document Company").child(imageName);

        // Upload the image to Firebase Storage
        await companyImageRef.putFile(imagefile!);

        // Get the download URL
        imageurl = await companyImageRef.getDownloadURL();

        // Get the current counter value

        // Add information to Firestore
        final docID =
            FirebaseFirestore.instance.collection('Document').doc().id;
        int nextDocumentNumber = await getNextDocumentNumber(companydocID);
        await Constanscollection.compnyDocument.add(
          {
            "url": imageurl,
            "comment": comment,
            "userid": userId,
            "companydocID": companydocID,
            "fileExtention": "image",
            "DocID": docID,
            "status": "Wating for Review ",
            'companyName': "",
            'invoiceDate': "",
            'invoiceNumber': "",
            'amountOfTheInvoice': "",
            'selectItem': "",
            'selectTypeItem': "",
            'commentForAccountatnt': "",
            'docNumer': nextDocumentNumber,
          },
        );
        // final uploadedDocument = CompanyDocument(
        //   urlImage: imageurl,
        //   comment: comment,
        //   userId: userId,
        //   companyDocId: companydocID,
        //   fileExtension: "image",
        //   docId: docID,
        //   status: "Wating for Review",
        //   companyName: "",
        //   invoiceDate: "",
        //   invoiceNumber: "",
        //   amountOfTheInvoice: "",
        //   selectItem: "",
        //   selectTypeItem: "",
        //   commentForAccountant: "",
        //   docNumber: nextDocumentNumber,
        // );
        // _uploadedDocumentsBox.add(uploadedDocument);

        emit(UploadDocumentSuccess());
      } else {
        print("Image file is null.");
      }
    } catch (e) {
      emit(UploadDocumentfaild(
          error: "Failed to upload image: ${e.toString()}"));
    }
  }

  void clearData() {
    filePlatforme = null;

    imagefile = null;

    emit(ClearFileWhenChangeFromCameraToGallery());
  }
}
