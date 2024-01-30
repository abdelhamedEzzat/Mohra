import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/comment.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/data_from_accountant.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';

class AuditorDocumentDetails extends StatefulWidget {
  const AuditorDocumentDetails({super.key});

  @override
  State<AuditorDocumentDetails> createState() =>
      _AccountantDocumentDetailsState();
}

class _AccountantDocumentDetailsState extends State<AuditorDocumentDetails> {
  List<String> stutsDocumentDropDown = [
    "amendment",
    "Finished",
    "Canceled",
    "acceptable",
  ];
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? selectItem;

  List<String> typeDocumentDropDown = [];
  String? selectTypeItem;
  String comment = "";
  @override
  Widget build(BuildContext context) {
    bool isBord = true;

    Map<String, dynamic> docDitails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Stream<QuerySnapshot> documentCompany = FirebaseFirestore.instance
        .collection('Companys')
        .where("companyId", isEqualTo: docDitails['companydocID'])
        .snapshots();

    final Stream<QuerySnapshot> documentDetatils = FirebaseFirestore.instance
        .collection('Document')
        .where("companydocID", isEqualTo: docDitails['companydocID'])
        .snapshots();

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Details Documents",
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
                const TitleOfFormCreateCompany(
                    titleText: "Upload From User : "),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        docDitails['urlImage'],
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Text(
                      "Comment : ",
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
                const TitleOfFormCreateCompany(titleText: "Review : "),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: documentDetatils,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                      var document = snapshot.data.docs[0].data();
                      var accountantReview = document?['AccountantReview'];

                      var accountantReviews =
                          (document?['AccountantReview'] as List<dynamic>)
                              .where((review) =>
                                  review['staffTypeReview'] == 'Accountant')
                              .toList();

                      var auditorReviews =
                          (document?['AuditorReview'] as List<dynamic>)
                              .where((review) =>
                                  review['staffTypeReview'] == 'Auditor')
                              .toList();

                      List<Widget> accountantContainers =
                          _buildAccountantReviewContainers(
                              accountantReviews, "Accountant Reviews");
                      List<Widget> auditorContainers =
                          _buildAuditorReviewContainers(
                              auditorReviews, "Auditor Reviews");

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
                            auditorData(
                                context, mediaQueryHeight, docDitails, comment),
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
                    return auditorData(
                        context, mediaQueryHeight, docDitails, comment);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Container SelectStatusOfDocument(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(color: ColorManger.darkGray)),
      child: DropdownButton<String>(
        hint: Text(
          "Select Status Of Document",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: ColorManger.backGroundColorToSplashScreen),
        ),
        borderRadius: BorderRadius.circular(10),
        isExpanded: true,
        value: selectItem,
        items: stutsDocumentDropDown
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.displayMedium,
                )))
            .toList(),
        onChanged: (item) => setState(() {
          selectItem = item!;
        }),
      ),
    );
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
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      data(review, context,
                          "Company Name: ${review['companyName']}"),
                      data(review, context,
                          "invoice Date: ${review['invoiceDate']}"),
                      data(review, context,
                          "invoice Number: ${review['invoiceNumber']}"),
                      data(review, context,
                          "select Item: ${review['selectItem']}"),
                      data(review, context,
                          "select Type Item: ${review['selectTypeItem']}"),
                      data(review, context,
                          "amount Of The Invoice: ${review['amountOfTheInvoice']}"),
                      data(review, context, "comment: ${review['comment']}"),
                      // Add more UI elements for each review
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
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      data(review, context,
                          "Staff Type Review: ${review['staffTypeReview']}"),
                      data(review, context, "Comment: ${review['comment']}"),
                      data(review, context,
                          "Document Status: ${review['statusDoc']}"),

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
  ) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          SelectStatusOfDocument(context),
          SizedBox(
            height: 15.h,
          ),
          const TitleOfFormCreateCompany(
            titleText: "Comments",
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please write a comment";
              }
              return null;
            },
            onChanged: (value) {
              print("Comment Updated: $value");

              comment = value;
            },
            hight: mediaQueryHeight * 0.10,
            hintText: "Add any Comment Here",
            prefixIcon: const Icon(Icons.comment),
          ),
          CustomButton(
              nameOfButton: "Submitted",
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
                          'staffTypeReview': 'Auditor',
                        }
                      ]),
                      "statusDoc": selectItem,
                      'isAccountantReview': false,
                      //  'accountant by':"email"
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('Notification')
                          .add({
                        'notificationMassage':
                            "Auditor Review Document in ${docDitails['company_Name']} with $selectItem ",
                        'role': "Auditor",
                        'MassgeSendBy': 'AuditorReview',
                        'NotificationCompanyID': docDitails['DocID'],
                        'NotificationUserID':
                            FirebaseAuth.instance.currentUser!.uid
                      });
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
                    content: const Text("You Must add Status Of Document"),
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
