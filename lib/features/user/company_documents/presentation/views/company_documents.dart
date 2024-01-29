// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/upload_documents.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';

class CompanyDocuments extends StatefulWidget {
  const CompanyDocuments({super.key});

  @override
  State<CompanyDocuments> createState() => _CompanyDocumentsState();
}

class _CompanyDocumentsState extends State<CompanyDocuments> {
  @override
  @override
  Widget build(BuildContext context) {
    var companyId = ModalRoute.of(context)?.settings.arguments;

    final Stream<QuerySnapshot> companyInFormation = FirebaseFirestore.instance
        .collection("Companys")
        .where('companyId', isEqualTo: companyId)
        .snapshots();

    final Stream<QuerySnapshot> compnyDocument = FirebaseFirestore.instance
        .collection("Document")
        .where('companydocID', isEqualTo: companyId)
        .snapshots();

    int selectedIndex = 0;

    // final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);

    return Scaffold(
        appBar: const CustomAppBar(
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
                StreamBuilder<QuerySnapshot>(
                    stream: companyInFormation,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return DetailsPeofileAndCompanyWidget(
                            profile: "Company Details",
                            key1: "Name : ",
                            value1: snapshot.data!.docs[selectedIndex]
                                ["company_Name"],
                            key2: "Address :",
                            value2: snapshot.data!.docs[selectedIndex]
                                ["Company_Address"],
                            key3: "Type :",
                            value3: snapshot.data!.docs[selectedIndex]
                                ["Company_type"],
                          );
                        } else {
                          return const Center(
                              child: Text('No company data available.'));
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              "We will add information to your company soon"),
                        );
                      } else if (snapshot.connectionState ==
                          snapshot.connectionState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      }
                      return Container();
                    }),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.uploadDocuments,
                        arguments: companyId.toString());
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
                              RouterName.detailsDocuments,
                              arguments: doc["name"],
                            );
                          },
                          typeOfDocument: "1",
                          color: ColorManger.darkGray,
                          status: "doc[status]",
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
        ));
  }
}
