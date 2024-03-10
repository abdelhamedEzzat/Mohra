// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/upload_documents.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';
import 'package:mohra_project/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CompanyDocuments extends StatefulWidget {
  const CompanyDocuments({Key? key}) : super(key: key);

  @override
  State<CompanyDocuments> createState() => _CompanyDocumentsState();
}

class _CompanyDocumentsState extends State<CompanyDocuments> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> companyData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final Stream<QuerySnapshot> compnyDocument = FirebaseFirestore.instance
        .collection("Document")
        .where('companydocID', isEqualTo: companyData["companyId"])
        .snapshots();

    return Scaffold(
      appBar: CustomAppBarForUsers(
        leading: const BackButton(color: Colors.white),
        title: Text(S.of(context).CompanyDocuments),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsPeofileAndCompanyWidget(
                profile: S.of(context).CompanyDetails,
                key1: S.of(context).Name,
                value1: companyData["companyName"],
                key2: S.of(context).Address,
                value2: companyData["CompanyAddress"],
                key3: S.of(context).Type,
                value3: companyData["Companytype"],
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    RouterName.uploadDocuments,
                    arguments: {
                      'companyId': companyData["companyId"].toString(),
                      'companyName': companyData["companyName"],
                    },
                  );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).MyDocument,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: compnyDocument,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Language currentLanguage =
                        BlocProvider.of<LanguageCubit>(context).state;
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
                      print("======================= $fileExtension");

                      if (fileExtension == "image" ||
                          fileExtension == "jpg" ||
                          fileExtension == "PNG" ||
                          fileExtension == "JPEG" ||
                          fileExtension == "jpeg") {
                        String imageUrl = doc["url"];
                        DefaultCacheManager().getSingleFile(imageUrl);
                        itemList.add(ImageDocWidget(
                          ontapForNavToDetailsScreen: () {
                            Navigator.of(context).pushNamed(
                              RouterName.detailsDocuments,
                              arguments: {
                                'url': doc["url"],
                                'fileExtention': doc["fileExtention"],
                                'comment': doc['comment'],
                              },
                            );
                          },
                          docImage: doc["url"],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                List imageUrls = allDocs
                                    .where((doc) =>
                                        doc['fileExtention'] == "image" ||
                                        doc['fileExtention'] == "jpg" ||
                                        doc['fileExtention'] == "PNG" ||
                                        doc['fileExtention'] == "JPEG" ||
                                        doc['fileExtention'] == "jpeg")
                                    .map((doc) => doc["url"])
                                    .toList();

                                int initialIndex =
                                    imageUrls.indexOf(doc["url"]);

                                return PhotoViewGallery.builder(
                                  itemCount: imageUrls.length,
                                  builder: (context, index) {
                                    return PhotoViewGalleryPageOptions(
                                      imageProvider:
                                          NetworkImage(imageUrls[index]),
                                      minScale:
                                          PhotoViewComputedScale.contained,
                                      maxScale:
                                          PhotoViewComputedScale.covered * 2,
                                    );
                                  },
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  pageController:
                                      PageController(initialPage: initialIndex),
                                );
                              },
                            ));
                          },
                          typeOfDocument: doc["docNumer"].toString(),
                          color: doc['status']['en'] == "Canceled" ||
                                  doc['status']['en'] == "amendment"
                              ? ColorManger.backGroundColorToSplashScreen
                              : doc['status']['en'] == "accepted" ||
                                      doc['status']['en'] == "Finished"
                                  ? ColorManger.introScreenBackgroundColor

                                  // Adjust color as desired
                                  : ColorManger.darkGray,
                          status: currentLanguage == Language.arabic
                              ? doc['status']["ar"]
                              : doc['status']["en"],
                        ));
                      } else {
                        String fileExtension =
                            doc["fileExtention"].toLowerCase() ?? "";
                        if (fileExtension == 'pdf' ||
                            fileExtension == 'docx' ||
                            fileExtension == 'xlsx') {
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
                            color: doc['status']['en'] == "Canceled" ||
                                    doc['status']['en'] == "amendment"
                                ? ColorManger.backGroundColorToSplashScreen
                                : doc['status']['en'] == "accepted" ||
                                        doc['status']['en'] == "Finished"
                                    ? ColorManger
                                        .introScreenBackgroundColor // Adjust color as desired
                                    : ColorManger.darkGray,
                            status: currentLanguage == Language.arabic
                                ? doc['status']["ar"]
                                : doc['status']["en"],
                            typeOfDocument: doc["docNumer"].toString(),
                          ));
                        }
                        // else {
                        //   itemList.add(Container(
                        //     child: Text(
                        //       'Unsupported File Type: ${doc["fileExtension"]}',
                        //       style: TextStyle(color: Colors.red),
                        //     ),
                        //   ));
                        // }
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
                              S.of(context).DidntHaveDocument,
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
                    return const Text("No Data");
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
                    return Center(
                      child: Text(
                        S.of(context).DidntHaveDocument,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
