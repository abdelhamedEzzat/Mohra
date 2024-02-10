// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/upload_documents.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';

class CompanyDocuments extends StatelessWidget {
  const CompanyDocuments({super.key});

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
    var comment = ModalRoute.of(context)?.settings.arguments;
    int selectedIndex = 0;

    // final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);

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
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, RouterName.uploadDocuments,
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
                              Navigator.of(context).pushNamed(
                                RouterName.detailsDocuments,
                                arguments: {
                                  'urlImage': doc["urlImage"],
                                  'comment': doc['comment']
                                },
                              );
                            },
                            typeOfDocument: doc["docNumer"].toString(),
                            color: ColorManger.darkGray,
                            status: doc['status'],
                          ));
                        } else {
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
                      Text("sdadasdasdasd");
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
