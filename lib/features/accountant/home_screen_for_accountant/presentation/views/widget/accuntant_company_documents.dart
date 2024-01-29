import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';

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
        title: const Text("Documents"),
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

                    List<DocumentSnapshot> imageDocs = [];
                    List<DocumentSnapshot> fileDocs = [];

                    snapshot.data!.docs.forEach((doc) {
                      String fileExtension =
                          doc["fileExtention"].toLowerCase() ?? "";

                      if (fileExtension == "image") {
                        return imageDocs.add(doc);
                      } else {
                        return fileDocs.add(doc);
                      }
                    });

                    // print(
                    //     "==============================${imageDocs.length}");
                    // print("==============================${fileDocs.length}");
                    // Add ImageDocWidget for image documents
                    imageDocs.forEach((doc) {
                      itemList.add(ImageDocWidget(
                        docImage: doc["urlImage"],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouterName.accountantDocumentDetails,
                            arguments: {
                              'urlImage': doc["urlImage"],
                              'comment': doc["comment"],
                              'companydocID': doc['companydocID'],
                              'DocID': doc['DocID']
                            },
                          );
                        },
                        typeOfDocument: "1",
                        color: ColorManger.darkGray,
                        status: doc['comment'],
                      ));
                    });

                    // Add FilesDocWidget for file documents
                    fileDocs.forEach((doc) {
                      itemList.add(FilesDocWidget(
                        pdfFileExtention: doc["fileExtention"],
                        pdfFileName: doc["name"],
                        color: ColorManger.darkGray,
                        status: "doc[status]",
                        typeOfDocument: "1",
                      ));
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
