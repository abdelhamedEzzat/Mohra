// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/upload_documents.dart';
import 'package:mohra_project/features/user/create_company/data/add_company_hive.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';
import 'package:mohra_project/features/user/upload_document/data/company_document_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CompanyDocuments extends StatefulWidget {
  const CompanyDocuments({super.key});

  @override
  State<CompanyDocuments> createState() => _CompanyDocumentsState();
}

class _CompanyDocumentsState extends State<CompanyDocuments> {
  @override
  Widget build(BuildContext context) {
    var companyData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final Stream<QuerySnapshot> compnyDocument = FirebaseFirestore.instance
        .collection("Document")
        .where('companydocID', isEqualTo: companyData["companyId"])
        .snapshots();
    var comment = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: const CustomAppBarForUsers(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Company Documents",
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailsPeofileAndCompanyWidget(
                  profile: "Company Details",
                  key1: "Name : ",
                  value1: companyData["companyName"],
                  key2: "Address :",
                  value2: companyData["companyAddress"],
                  key3: "Type :",
                  value3: companyData["companyType"],
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, RouterName.uploadDocuments,
                        arguments: companyData["companyId"].toString());
                  },
                  child: const UploadDocumentsBotton(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Document :",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: compnyDocument,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> itemList = [];
                      List<DocumentSnapshot> allDocs = [];

                      snapshot.data!.docs.forEach((doc) {
                        allDocs.add(doc);
                      });

                      Comparator<DocumentSnapshot> compareByDocNumer =
                          (doc1, doc2) =>
                              doc2["docNumer"].compareTo(doc1["docNumer"]);

                      allDocs.sort(compareByDocNumer);

                      allDocs.forEach((doc) async {
                        String fileExtension =
                            doc["fileExtention"].toLowerCase() ?? "";

                        if (fileExtension == "image") {
                          String imageUrl = doc["urlImage"];
                          DefaultCacheManager().getSingleFile(imageUrl);
                          if (imageUrl.isEmpty) {
                            itemList.add(ImageDocWidget(
                              docImage: doc["urlImage"],
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    // Retrieve all image URLs
                                    List imageUrls = allDocs
                                        .where((doc) =>
                                            doc["fileExtention"] == "image")
                                        .map((doc) => doc["urlImage"])
                                        .toList();

                                    // Get the index of the selected image
                                    int initialIndex =
                                        imageUrls.indexOf(doc["urlImage"]);

                                    return PhotoViewGallery.builder(
                                      itemCount: imageUrls.length,
                                      builder: (context, index) {
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider:
                                              NetworkImage(imageUrls[index]),
                                          minScale:
                                              PhotoViewComputedScale.contained,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        );
                                      },
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      pageController: PageController(
                                          initialPage: initialIndex),
                                    );
                                  },
                                ));
                              },
                              typeOfDocument: doc["docNumer"].toString(),
                              color: ColorManger.darkGray,
                              status: doc['status'],
                            ));
                          } else {
                            itemList.add(ImageDocWidget(
                              docImage: imageUrl,
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    // Retrieve all image URLs
                                    List imageUrls = allDocs
                                        .where((doc) =>
                                            doc["fileExtention"] == "image")
                                        .map((doc) => imageUrl)
                                        .toList();

                                    // Get the index of the selected image
                                    int initialIndex =
                                        imageUrls.indexOf(imageUrl);

                                    return PhotoViewGallery.builder(
                                      itemCount: imageUrls.length,
                                      builder: (context, index) {
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider:
                                              NetworkImage(imageUrls[index]),
                                          minScale:
                                              PhotoViewComputedScale.contained,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        );
                                      },
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      backgroundDecoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      pageController: PageController(
                                          initialPage: initialIndex),
                                    );
                                  },
                                ));
                              },
                              typeOfDocument: doc["docNumer"].toString(),
                              color: ColorManger.darkGray,
                              status: doc['status'],
                            ));
                          }
                        } else {
                          String fileUrl = doc["url"];
                          DefaultCacheManager()
                              .getSingleFile(fileUrl)
                              .then((File file) {
                            print(fileUrl);
                          });
                          itemList.add(FilesDocWidget(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                RouterName.detailsDocuments,
                                arguments: {
                                  'name': doc["name"],
                                  'url': doc["url"],
                                  'comment': doc['comment'],
                                  'fileExtention': doc['fileExtention']
                                },
                              );
                            },
                            pdfFileExtention: doc["fileExtention"],
                            pdfFileName: doc["name"],
                            color: ColorManger.darkGray,
                            status: doc['status'],
                            typeOfDocument: doc["docNumer"].toString(),
                          ));
                        }
                      });

                      if (itemList.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(height: 50.h),
                            Center(
                              child: Icon(
                                Icons.document_scanner,
                                size: 60.h,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Center(
                              child: Text(
                                "You didn't have any documents.",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemList[index];
                        },
                      );
                    } else if (snapshot.data == null) {
                      return Text("No Data");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("You have an error."));
                    } else {
                      return const Center(
                        child: Text("You didn't have any documents."),
                      );
                    }

                    return Container();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
