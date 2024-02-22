import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/features/user/create_company/data/add_company_hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
part 'create_company_state.dart';

class FirebaseCreateCompanyCubit extends Cubit<FirebaseCreateCompanyState> {
  FirebaseCreateCompanyCubit() : super(FirestoreStorageInitial());
  String userId = FirebaseAuth.instance.currentUser!.uid;

  String companyName = "";
  String companyAddress = "";
  String companyType = "";
  File? file;
  File filebase = File('assets/images/company-no_logo.png');
  String? url = "";
  bool isIcon = false;
  String? compnydocID;
  List additionalInformation = [];
  List<QueryDocumentSnapshot> companyInformation = [];

  Future<void> addCompany({
    required String companyName,
    required String companyAddress,
    required String companyType,
    required File? file,
    required String compnyCollectionID,
  }) async {
    try {
      emit(FirestoreStorageLoading());

      String? url;

      if (file != null) {
        var imageName = basename(file.path);
        final storage = FirebaseStorage.instanceFor(
            bucket: "gs://mohra-project.appspot.com");
        var companyImageRef = storage.ref("company images/$imageName");

        await companyImageRef.putFile(file);
        url = await companyImageRef.getDownloadURL();
        print("url:$url");
      } else {
        // Set url to the default image URL
        url =
            "https://st3.depositphotos.com/23594922/31822/v/450/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"; // Replace this with your actual default image URL
        print("url:$url");
      }
      // Use the default image path if file is null
      // final storage = FirebaseStorage.instanceFor(
      //     bucket: "gs://mohra-project.appspot.com");
      // var companyImageRef =
      //     storage.ref("company images/default_company_image.png");

      // var defaultImageBytes =
      //     await rootBundle.load('assets/images/company-no_logo.png');
      // var defaultImageFile =
      //     File('${(await getTemporaryDirectory()).path}/company-no_logo.png');
      // await defaultImageFile
      //     .writeAsBytes(defaultImageBytes.buffer.asUint8List());

      // await companyImageRef.putFile(defaultImageFile);
      // url = await companyImageRef.getDownloadURL();
      compnydocID = Constanscollection.companyCollection.id;
      await Constanscollection.companyCollection.add(
        {
          'logo': url,
          'company_Name': companyName,
          'Company_Address': companyAddress,
          'Company_type': companyType,
          'companyId': compnyCollectionID,
          'companyDocId': compnydocID,
          'userID': FirebaseAuth.instance.currentUser!.uid,
          'additionalInformation': additionalInformation,
          'CompanyStatus': "Waiting for Accepted",
          'timesTamp': formattedStamp(timestamp),
        },
      );

      emit(FirestoreStorageSuccess());
    } catch (e) {
      emit(FirestoreStoragefaild(
          error: "Failed to add company:${e.toString()}"));
    }
  }

  // Future<void> addCompanyToHive({
  //   String? logo,
  //   required String companyName,
  //   required String companyAddress,
  //   required String companyType,
  //   String? compnyCollectionID,
  //   File? file,
  // }) async {
  //   try {
  //     emit(FirestoreStorageLoading());
  //     final box = Hive.box<AddCompanyToHive>('companyBox');
  //     final newCompany = AddCompanyToHive(
  //       logo: url.toString(),
  //       companyName: companyName,
  //       companyAddress: companyAddress,
  //       companyType: companyType,
  //       companyDocId: compnydocID.toString(),
  //       companyStatus: "Waiting for Accepted",
  //       timesTamp: formattedStamp(timestamp),
  //       additionalInformation: additionalInformation,
  //       userID: FirebaseAuth.instance.currentUser!.uid,
  //       companyId: compnyCollectionID.toString(),
  //     );
  //     await box.add(newCompany);

  //     emit(FirestoreStorageSuccess());
  //   } catch (e) {
  //     emit(FirestoreStoragefaild(
  //         error: "Failed to add company to hive :${e.toString()}"));
  //   }
  // }

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

    emit(clearDataStorage());
  }
}
