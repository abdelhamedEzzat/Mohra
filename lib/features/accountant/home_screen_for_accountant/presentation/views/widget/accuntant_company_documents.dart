import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AccuntantCompanyDocuments extends StatelessWidget {
  const AccuntantCompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    var companyId = ModalRoute.of(context)?.settings.arguments;
    final Stream<QuerySnapshot> DocumentCompany = FirebaseFirestore.instance
        .collection('Document')
        .where("companydocID", isEqualTo: companyId)
        .snapshots();

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
        },
        title: Text(S.of(context).Documents),
        leading: BackButton(
          color: ColorManger.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: DocumentCompany,
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

                    allDocs.forEach((doc) {
                      String fileExtension =
                          doc["fileExtention"].toLowerCase() ?? "";

                      if (fileExtension == "image") {
                        itemList.add(ImageDocWidget(
                          ontapForNavToDetailsScreen: () {
                            Navigator.of(context).pushNamed(
                              RouterName.detailsDocuments,
                              arguments: {
                                'urlImage': doc["urlImage"],
                                'comment': doc['comment'],
                              },
                            );
                          },
                          docImage: doc["urlImage"],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
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
                          color: ColorManger.darkGray,
                          status: doc['status'],
                        ));
                      } else {
                        itemList.add(FilesDocWidget(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RouterName.accountantDocumentDetails,
                              arguments: {
                                'companydocID': doc["companydocID"],
                                'url': doc["url"],
                                'comment': doc['comment'],
                                'fileExtention': doc['fileExtention'],
                                'name': doc['name']
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

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemList[index];
                      },
                    );
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
                      child: Text(S.of(context).Youdidnthaveanydocuments),
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
