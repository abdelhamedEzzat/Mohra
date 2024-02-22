import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AuditorCompanyDocuments extends StatelessWidget {
  const AuditorCompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    var companyDocId = ModalRoute.of(context)?.settings.arguments;
    final Stream<QuerySnapshot> documentCompany = FirebaseFirestore.instance
        .collection('Document')
        .where("companydocID", isEqualTo: companyDocId)
        .snapshots();

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(S.of(context).CompanyDocuments),
        leading: BackButton(
          color: ColorManger.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
        },
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouterName.addDocumetType,
                      arguments: companyDocId);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Icon(
                          Icons.add_box_rounded,
                          size: 55.h,
                        )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            S.of(context).AddDocumentType,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ]),
                ),
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: documentCompany,
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
                              RouterName.auditorDocumentDetails,
                              arguments: {
                                'url': doc["url"],
                                'DocID': doc["DocID"],
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
                          color: ColorManger.darkGray,
                          status: doc['status'],
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
                                RouterName.auditorDocumentDetails,
                                arguments: {
                                  'name': doc["name"],
                                  'url': doc["url"],
                                  'DocID': doc["DocID"],
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
                    return const Center(
                      child: Text("You didn't have any documents."),
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
