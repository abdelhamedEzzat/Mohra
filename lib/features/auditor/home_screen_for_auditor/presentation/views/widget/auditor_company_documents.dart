import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
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
        title: const Text("Documents"),
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
                            'Add Document Type',
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

                      if (fileExtension == "image") {
                        itemList.add(ImageDocWidget(
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
                              RouterName.auditorDocumentDetails,
                              arguments: {
                                'companydocID': doc["companydocID"],
                                'url': doc["url"],
                                'name': doc["name"],
                                'fileExtention': doc["fileExtention"],
                                'comment': doc['comment']
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
