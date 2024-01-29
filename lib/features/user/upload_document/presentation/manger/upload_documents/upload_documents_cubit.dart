import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:path/path.dart';

part 'upload_documents_state.dart';

class UploadDocumentsCubit extends Cubit<UploadDocumentsState> {
  UploadDocumentsCubit() : super(UploadDocumentsInitial());

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
      emit(UploadDocumentfaild(error: "Failed to add file:${e.toString()}"));
    }
  }

  Future pickFile({
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
        await Constanscollection.compnyDocument.add(
          {
            "name": fileName,
            "url": url,
            "comment": comment,
            "userid": userId,
            "companydocID": companydocID,
            "fileExtention": filePlatforme!.extension,
            'DocID': docID,
            "status": "Wating for the accssept ",
            'companyName': "",
            'invoiceDate': "",
            'invoiceNumber': "",
            'amountOfTheInvoice': "",
            'selectItem': "",
            'selectTypeItem': "",
            'commentForAccountatnt': "",
          },
        );
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
      emit(
          UploadDocumentfaild(error: "Failed to open camera: ${e.toString()}"));
    }
  }

// Function to upload image to Firebase Storage and add information to Firestore
  Future<void> uploadImageAndAddInfoToFirestore({
    required String comment,
    required String companydocID,
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
        await Constanscollection.compnyDocument.add(
          {
            "urlImage": imageurl,
            "comment": comment,
            "userid": userId,
            "companydocID": companydocID,
            "fileExtention": "image",
            "DocID": docID,
            //"numberOfDocument": currentCounter + 1,
            'companyName': "",
            'invoiceDate': "",
            'invoiceNumber': "",
            'amountOfTheInvoice': "",
            'selectItem': "",
            'selectTypeItem': "",
            'commentForAccountatnt': "",
          },
        );

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
