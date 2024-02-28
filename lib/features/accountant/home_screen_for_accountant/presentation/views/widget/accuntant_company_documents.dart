import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
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
                              RouterName.accountantDocumentDetails,
                              arguments: {
                                'url': doc["url"],
                                'fileExtention': doc["fileExtention"],
                                'comment': doc['comment'],
                                'DocID': doc["DocID"],
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
                                  : ColorManger.darkGray,
                          status: currentLanguage == Language.arabic
                              ? doc['status']['ar']
                              : doc['status']['en'],
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
                                RouterName.accountantDocumentDetails,
                                arguments: {
                                  'name': doc["name"],
                                  'DocID': doc["DocID"],
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
                                    ? ColorManger.introScreenBackgroundColor
                                    : ColorManger.darkGray,
                            status: currentLanguage == Language.arabic
                                ? doc['status']['ar']
                                : doc['status']['en'],
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
