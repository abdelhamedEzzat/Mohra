import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:path/path.dart';
part 'create_company_state.dart';

class FirebaseCreateCompanyCubit extends Cubit<FirebaseCreateCompanyState> {
  FirebaseCreateCompanyCubit() : super(FirestoreStorageInitial());
  String userId = FirebaseAuth.instance.currentUser!.uid;

  String companyName = "";
  String companyAddress = "";
  String companyType = "";
  File? file;
  String? url = "";
  bool isIcon = false;
  List<QueryDocumentSnapshot> companyInformation = [];

  Future<void> addCompany(
      {required String companyName,
      required String companyAddress,
      required String companyType,
      required File? file,
      required String docid,
      required String compnyCollectionID}) async {
    try {
      emit(FirestoreStorageLoading());

      if (file != null) {
        var imageName = basename(file.path);
        final storage = FirebaseStorage.instanceFor(
            bucket: "gs://mohra-project.appspot.com");
        var companyImageRef = storage.ref("company images/$imageName");

        await companyImageRef.putFile(file);
        url = await companyImageRef.getDownloadURL();
        print("url:$url");
        var compnydocID = Constanscollection.companyCollection.id;
        await Constanscollection.companyCollection.add(
          {
            'logo': url,
            'company_Name': companyName,
            'Company_Address': companyAddress,
            'Company_type': companyType,
            'companyId': compnyCollectionID,
            'companyDocId': compnydocID,
            'userID': FirebaseAuth.instance.currentUser!.uid,
            'additionalInformation': "",
            'CompanyStatus': "Waiting for Accepted"
          },
        );
      }

      emit(FirestoreStorageSuccess());
    } catch (e) {
      emit(FirestoreStoragefaild(
          error: "Failed to add company:${e.toString()}"));
    }
  }

  getFilesFromCamera() async {
    final ImagePicker picker = ImagePicker();

    try {
      emit(FirestoreStorageLoading());
      // if (photo != null) {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        file = File(photo.path);

        var imageName = basename(file!.path);
        final storage = FirebaseStorage.instanceFor(
            bucket: "gs://mohra-project.appspot.com");
        var companyImageRef = storage.ref("company images").child(imageName);

        url = await companyImageRef.getDownloadURL();

        emit(FirestoreStorageSuccess());
      }

      // }
    } catch (e) {
      emit(FirestoreStoragefaild(
          error: "Failed to add image From camera:${e.toString()}"));
    }
  }

  getimagefromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      emit(FirestoreStorageLoading());
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      file = File(photo!.path);

      emit(FirestoreStorageSuccess());
      // }
    } catch (e) {
      emit(FirestoreStoragefaild(
          error: "Failed to add image From camera:${e.toString()}"));
    }
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getCompanies() async {
    try {
      emit(FirestoreStorageLoading());
      QuerySnapshot<Map<String, dynamic>> companyCollections =
          await Constanscollection.companyCollection.get();

      companyInformation = companyCollections.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) =>
              document.data()!)
          .cast<QueryDocumentSnapshot<Object?>>()
          .toList();
      emit(FirestoreStorageSuccess());
    } catch (e) {
      // Handle error if necessary
      emit(FirestoreStoragefaild(
          error: "Failed to get image From camera:${e.toString()}"));
    }

    return companyInformation;
  }

  void clearData() {
    companyName = "";
    companyAddress = "";
    companyType = "";
    file = null;
    url = "";
    isIcon = false;
    userId = uuid.v4();
    emit(clearDataStorage());
  }
}
