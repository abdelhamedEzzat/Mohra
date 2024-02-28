import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';
import 'package:mohra_project/features/user/details_documents/presentation/views/details_documents.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

class AuditorDocumentDetails extends StatefulWidget {
  const AuditorDocumentDetails({super.key});

  @override
  State<AuditorDocumentDetails> createState() =>
      _AccountantDocumentDetailsState();
}

class _AccountantDocumentDetailsState extends State<AuditorDocumentDetails> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool snackBarShown = false;

  String? selectItem = "Select Type";

  List<String> typeDocumentDropDown = [];
  String? selectTypeItem;
  String comment = "";
  List<String> stutsDocumentDropDownEnglish = [
    "amendment",
    "Finished",
    "Canceled",
    "acceptable",
  ];

  List<String> stutsDocumentDropDownArabic = [
    "مكرر",
    "تم الانتهاء من المستند",
    "المستند ملغي",
    "تم قبول المستند"
  ];
  @override
  Widget build(BuildContext context) {
    // bool isBord = true;
    Language currentLanguage = BlocProvider.of<LanguageCubit>(context).state;
    Map<String, dynamic> docDitails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final Stream<QuerySnapshot> documentCompany = FirebaseFirestore.instance
    //     .collection('Companys')
    //     .where("companyId", isEqualTo: docDitails['companydocID'])
    //     .snapshots();

    final Stream<QuerySnapshot> documentDetatils = FirebaseFirestore.instance
        .collection('Document')
        .where("DocID", isEqualTo: docDitails['DocID'])
        .snapshots();

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
          },
          leading: BackButton(color: Colors.white),
          title: Text(
            S.of(context).DetailsDocuments,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                TitleOfFormCreateCompany(
                    titleText: S.of(context).UploadFromUser),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: docDitails['fileExtention'] == 'pdf' ||
                              docDitails['fileExtention'] == 'docx' ||
                              docDitails['fileExtention'] == 'xlsx'
                          ? GestureDetector(
                              onTap: () => openFile(
                                      url: docDitails['url'],
                                      fileName: docDitails['name'])
                                  .toString(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: mediaQueryHeight,
                                color: Colors.grey.withOpacity(0.3),
                                child: Center(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            ColorManger.white.withOpacity(0.5),
                                        radius: 30.h,
                                        child: Text(
                                            docDitails['fileExtention']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(color: Colors.black)),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            docDitails['name'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => navigateToFullScreenImage(
                                  context, docDitails['url'].toString()),
                              child: Image.network(
                                docDitails['url'].toString(),
                                fit: BoxFit.fill,
                              ),
                            )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Text(
                      S.of(context).Comments,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(docDitails['comment'],
                        style: Theme.of(context).textTheme.displayMedium)
                  ]),
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                TitleOfFormCreateCompany(titleText: S.of(context).Review),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: documentDetatils,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                      var document = snapshot.data.docs[0].data();
                      var accountantReview = document?['AccountantReview'];

                      var accountantReviews = (accountantReview != null &&
                              accountantReview is List<dynamic>)
                          ? accountantReview
                              .where((review) =>
                                  review['staffTypeReview'] == 'Accountant')
                              .toList()
                          : [];

                      var auditorReview = document?['AuditorReview'];
                      var auditorReviews = (auditorReview != null &&
                              auditorReview is List<dynamic>)
                          ? auditorReview
                              .where((review) =>
                                  review['staffTypeReview'] == 'Auditor')
                              .toList()
                          : [];

                      List<Widget> accountantContainers =
                          _buildAccountantReviewContainers(accountantReviews,
                              S.of(context).AccountantReviews);
                      List<Widget> auditorContainers =
                          _buildAuditorReviewContainers(auditorReviews,
                              S.of(context).AuditorReviews, context);

//
//
//
//
                      //todo
                      if (document['isAccountantReview'] == true) {
                        return Column(
                          children: [
                            if (accountantContainers.isNotEmpty)
                              ...accountantContainers,
                            if (auditorContainers.isNotEmpty)
                              ...auditorContainers,
                            SizedBox(
                              height: 10.h,
                            ),
                            auditorData(context, mediaQueryHeight, docDitails,
                                comment, currentLanguage),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        );
                      } else if (document['isAccountantReview'] == false) {
                        return Column(
                          children: [
                            if (accountantContainers.isNotEmpty)
                              ...accountantContainers,
                            if (auditorContainers.isNotEmpty)
                              ...auditorContainers,
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      // Handle error UI
                      return Container(
                        child: Text("Error loading data."),
                      );
                    } else {
                      // Render UI when there is no data
                      return Container(
                        child: Text("No data available."),
                      );
                    }
                    return auditorData(context, mediaQueryHeight, docDitails,
                        comment, currentLanguage);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget SelectStatusOfDocument(
      BuildContext context, Language currentLanguage) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(color: ColorManger.darkGray),
        ),
        child: DropdownButton<String>(
          hint: Text(
            S.of(context).SelectStatusOfDocument,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: ColorManger.backGroundColorToSplashScreen),
          ),
          borderRadius: BorderRadius.circular(10),
          isExpanded: true,
          value: selectItem,
          items: [
            // Add a DropdownMenuItem with the initial value
            DropdownMenuItem(
              value: "Select Type",
              child: Text(
                currentLanguage == Language.english
                    ? "Select Type"
                    : "حدد حاله المستند ",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            // Add other DropdownMenuItem instances from your stutsDocumentDropDown list
            ...(currentLanguage == Language.arabic
                    ? stutsDocumentDropDownArabic
                    : stutsDocumentDropDownEnglish)
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ))
                .toList(),
            // DropdownMenuItem(
            //   value: "Select Type",
            //   child: Text(
            //     "Select Type",
            //     style: Theme.of(context).textTheme.displayMedium,
            //   ),
            // ),
            // // Add other DropdownMenuItem instances from your stutsDocumentDropDown list
            // ...stutsDocumentDropDownEnglish
            //     .map((item) => DropdownMenuItem(
            //           value: item,
            //           child: Text(
            //             item,
            //             style: Theme.of(context).textTheme.displayMedium,
            //           ),
            //         ))
            //     .toList(),
          ],
          onChanged: (item) => setState(() {
            selectItem = item!;
          }),
        ));
  }

  List<Widget> _buildAccountantReviewContainers(
      List<dynamic> reviews, String title) {
    List<Widget> containers = [];

    if (reviews.isNotEmpty) {
      reviews.forEach((review) {
        containers.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Add more UI elements for each review
                      if (review['companyName'] != null &&
                          review['companyName'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).CompanyName} ${review['companyName']}"),
                      if (review['invoiceDate'] != null &&
                          review['invoiceDate'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).invoiceDate} ${review['invoiceDate']}"),
                      if (review['invoiceNumber'] != null &&
                          review['invoiceNumber'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).invoiceNumber} ${review['invoiceNumber']}"),
                      if (review['selectItem'] != null &&
                          review['selectItem'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).selectItem} ${review['selectItem']}"),
                      if (review['selectTypeItem'] != null &&
                          review['selectTypeItem'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).selectTypeItem} ${review['selectTypeItem']}"),
                      if (review['amountOfTheInvoice'] != null &&
                          review['amountOfTheInvoice'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).amountOfTheInvoice}: ${review['amountOfTheInvoice']}"),
                      if (review['comment'] != null &&
                          review['comment'].isNotEmpty)
                        data(review, context,
                            "${S.of(context).Comments} ${review['comment']}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    return containers;
  }

  List<Widget> _buildAuditorReviewContainers(
      List<dynamic> reviews, String title, BuildContext context) {
    List<Widget> containers = [];

    if (reviews.isNotEmpty) {
      reviews.forEach((review) {
        containers.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      data(review, context,
                          "${S.of(context).Comments} ${review['comment']}"),
                      data(review, context,
                          "${S.of(context).StaffTypeReview} ${review['staffTypeReview']}"),
                      data(review, context,
                          "${S.of(context).DocumentStatus} ${review['statusDoc'] != null ? review['statusDoc'] : 'No status'}"),
                      // Add more UI elements for auditors
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    return containers;
  }

  Widget auditorData(
      BuildContext context,
      double mediaQueryHeight,
      Map<String, dynamic> docDitails,
      String? comment,
      Language currentLanguage) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          SelectStatusOfDocument(context, currentLanguage),
          SizedBox(
            height: 15.h,
          ),
          TitleOfFormCreateCompany(
            titleText: S.of(context).Comments,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).PleaseWriteaComment;
              }
              return null;
            },
            onChanged: (value) {
              print("Comment Updated: $value");

              comment = value;
            },
            height: mediaQueryHeight * 0.10,
            hintText: S.of(context).hintComments,
            prefixIcon: const Icon(Icons.comment),
          ),
          CustomButton(
              nameOfButton: S.of(context).Submit,
              onTap: () async {
                if (globalKey.currentState!.validate() && selectItem != null) {
                  globalKey.currentState!.save();
                  Query<Map<String, dynamic>> query = FirebaseFirestore.instance
                      .collection('Document')
                      .where("DocID", isEqualTo: docDitails['DocID']);

                  QuerySnapshot<Map<String, dynamic>> querySnapshot =
                      await query.get(); // Execute the query to get documents

                  for (QueryDocumentSnapshot<
                          Map<String, dynamic>> documentSnapshot
                      in querySnapshot.docs) {
                    // Update each document individually
                    await documentSnapshot.reference.update({
                      'AuditorReview': FieldValue.arrayUnion([
                        {
                          'comment': comment,
                          // ignore: use_build_context_synchronously
                          'staffTypeReview': "Auditor", "statusDoc": selectItem,
                        }
                      ]),
                      "statusDoc": selectItem,
                      'isAccountantReview': false,

                      //  'accountant by':"email"
                    }).then((value) {
                      try {
                        FirebaseFirestore.instance
                            .collection('Document')
                            .where("DocID", isEqualTo: docDitails["DocID"])
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            // Check if the document exists
                            if (doc.exists) {
                              if (selectItem == "amendment" ||
                                  selectItem == "مكرر") {
                                doc.reference
                                    .update({
                                      "status": {
                                        'en': "amendment",
                                        'ar': "مكرر",
                                      }
                                    })
                                    .then((_) =>
                                        print("Document updated successfully"))
                                    .catchError((error) => print(
                                        "Failed to update document: $error"));
                              } else if (selectItem == "Finished" ||
                                  selectItem == "تم الانتهاء من المستند") {
                                doc.reference
                                    .update({
                                      "status": {
                                        'en': "Finished",
                                        'ar': "تم الانتهاء من المستند"
                                      }
                                    })
                                    .then((_) =>
                                        print("Document updated successfully"))
                                    .catchError((error) => print(
                                        "Failed to update document: $error"));
                              } else if (selectItem == "Canceled" ||
                                  selectItem == "المستند ملغي") {
                                doc.reference
                                    .update({
                                      "status": {
                                        'en': "Canceled",
                                        'ar': "المستند ملغي",
                                      }
                                    })
                                    .then((_) =>
                                        print("Document updated successfully"))
                                    .catchError((error) => print(
                                        "Failed to update document: $error"));
                              } else if (selectItem == "Finished" ||
                                  selectItem == "تم قبول المستند") {
                                doc.reference
                                    .update({
                                      "status": {
                                        'en': "acceptable",
                                        'ar': "تم قبول المستند",
                                      }
                                    })
                                    .then((_) =>
                                        print("Document updated successfully"))
                                    .catchError((error) => print(
                                        "Failed to update document: $error"));
                              }
                            } else {
                              print("Document does not exist");
                            }
                          });
                        }).catchError((error) {
                          print("Error getting documents: $error");
                        });
                      } catch (e) {
                        print(e.toString());
                        e.toString();
                      }
                    }).then((value) {
                      if (selectItem == 'Canceled' ||
                          selectItem == 'Finished') {
                        FirebaseFirestore.instance
                            .collection('Notification')
                            .add({
                          'notificationMassage':
                              "${S.of(context).AuditorReviewyourDocumentin} ${docDitails['company_Name']} ${S.of(context).witha} $selectItem ",
                          'role': "forUser",
                          'MassgeSendBy': 'AuditorReview',
                          'NotificationCompanyID': docDitails['DocID'],
                          'NotificationUserID':
                              FirebaseAuth.instance.currentUser!.uid
                        });
                      } else {
                        FirebaseFirestore.instance
                            .collection('Notification')
                            .add({
                          'notificationMassage':
                              "${S.of(context).AuditorReviewyourDocumentin} ${docDitails['company_Name']} ${S.of(context).witha} $selectItem ",
                          'role': "Auditor",
                          'MassgeSendBy': 'AuditorReview',
                          'NotificationCompanyID': docDitails['DocID'],
                          'NotificationUserID':
                              FirebaseAuth.instance.currentUser!.uid
                        });
                      }
                    });

                    ;

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Successfull"),
                        backgroundColor:
                            ColorManger.backGroundColorToSplashScreen,
                      ));
                    });
                  }
                } else if (selectItem == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).YouMustaddStatusOfDocument),
                    backgroundColor: ColorManger.backGroundColorToSplashScreen,
                  ));
                }
              }),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Container data(review, BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),

          // Add other fields as needed
        ],
      ),
    );
  }
}
