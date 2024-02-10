import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/add_new_auditor.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';
import 'package:mohra_project/features/user/details_documents/presentation/views/details_documents.dart';

class AccountantDocumentDetails extends StatefulWidget {
  const AccountantDocumentDetails({super.key});

  @override
  State<AccountantDocumentDetails> createState() =>
      _AccountantDocumentDetailsState();
}

class _AccountantDocumentDetailsState extends State<AccountantDocumentDetails> {
  List<String> stutsDocumentDropDown = [
    "new Document",
    "registered",
    "Auditor",
    "ready",
    "redundant",
    "Canceled",
  ];

  String? companyName;
  String? invoiceDate;
  String? invoiceNumber;
  String? amountOfTheInvoice;
  String? comment = "";
  String? selectItem = "new Document";
  bool isAccountantReviewDoc = false;
  bool accountantReview = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  List<String> typeDocumentDropDown = [];
  String? selectTypeItem;
  @override
  Widget build(BuildContext context) {
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
        appBar: CustomAppBar(
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
          },
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
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.h),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        color: ColorManger.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: docDitails['urlImage'] == null
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
                                          backgroundColor: ColorManger.white
                                              .withOpacity(0.5),
                                          radius: 30.h,
                                          child: Text(
                                              docDitails['fileExtention']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      color: Colors.black)),
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
                                    context, docDitails['urlImage'].toString()),
                                child: Image.network(
                                  docDitails['urlImage'].toString(),
                                  fit: BoxFit.fill,
                                ),
                              )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  //
                  //
                  //
                  ///

                  // if (isAccountantReviewDoc)
                  StreamBuilder<QuerySnapshot>(
                    stream: documentDetatils,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                        var document = snapshot.data.docs[0].data();
                        var accountantReview = document?['AccountantReview'];

                        var accountantReviews =
                            (document?['AccountantReview'] as List<dynamic>?) ??
                                [];
                        var auditorReviews =
                            (document?['AuditorReview'] as List<dynamic>?) ??
                                [];
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
                        print("Status Doc Value: ${document['statusDoc']}");
                        if (document['isAccountantReview'] == true) {
                          return Column(
                            children: [
                              if (accountantContainers.isNotEmpty)
                                ...accountantContainers,
                              if (auditorContainers.isNotEmpty)
                                ...auditorContainers,
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          );
                        } else if (document['statusDoc'] == 'amendment' &&
                            document['isAccountantReview'] == false) {
                          return Column(
                            children: [
                              if (accountantContainers.isNotEmpty)
                                ...accountantContainers,
                              if (auditorContainers.isNotEmpty)
                                ...auditorContainers,
                              SizedBox(
                                height: 10.h,
                              ),
                              accountantData(documentCompany, context,
                                  mediaQueryHeight, docDitails),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          );
                        } else if (document['statusDoc'] == 'Finished' ||
                            document['statusDoc'] == 'Canceled' ||
                            document['statusDoc'] == 'acceptable' ||
                            document['isAccountantReview'] == false) {
                          return Column(
                            children: [
                              if (accountantContainers.isNotEmpty)
                                ...accountantContainers,
                              if (auditorContainers.isNotEmpty)
                                ...auditorContainers,
                              SizedBox(
                                height: 10.h,
                              )
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
                      return accountantData(documentCompany, context,
                          mediaQueryHeight, docDitails);
                    },
                  ),

                  // else
                ],
              ),
            ),
          ),
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
                      data(review, context, "comment: ${review['comment']}"),
                      data(review, context,
                          "staff Type Review: ${review['staffTypeReview']}"),
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

  Column accountantData(
      Stream<QuerySnapshot<Object?>> documentCompany,
      BuildContext context,
      double mediaQueryHeight,
      Map<String, dynamic> docDitails) {
    return Column(
      children: [
        CustomTextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "* this Company Name is required You must enter data";
            }
          },
          onChanged: (value) {
            setState(() {
              companyName = value;
            });
          },
          fontStyle: FontStyle.normal,
          hintText: "Write Company name",
          labelText: "Company name",
          prefixIcon: Icon(Icons.home_work),
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFormField(
          fontStyle: FontStyle.normal,
          labelText: "Invoice date",
          hintText: "Type Invoice date",
          prefixIcon: Icon(Icons.date_range),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "* this Invoice data is required You must enter data";
            }
          },
          onChanged: (value) {
            setState(() {
              invoiceDate = value;
            });
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFormField(
          fontStyle: FontStyle.normal,
          labelText: "invoice number",
          hintText: "Type invoice number",
          prefixIcon: Icon(Icons.numbers),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "* this Invoice Number is required You must enter data";
            }
          },
          onChanged: (value) {
            setState(() {
              invoiceNumber = value;
            });
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFormField(
          fontStyle: FontStyle.normal,
          labelText: "Amount of the invoice",
          hintText: "Type Amount of the invoice",
          prefixIcon: Icon(Icons.price_check),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "* this Amount of Invoice data is required You must enter data";
            }
          },
          onChanged: (value) {
            setState(() {
              amountOfTheInvoice = value;
            });
          },
        ),
        SizedBox(
          height: 10.h,
        ),

        //
        //
        //
        //
        StreamBuilder<QuerySnapshot>(
          stream: documentCompany,
          builder: (context, snapshot) {
            List<String> dropdownItems = [
              'Select'
            ]; // Initialize with a default value
            if (snapshot.hasData) {
              // Use a set to ensure unique values and generate unique keys
              Set<String> uniqueItems = Set();

              snapshot.data!.docs.forEach((DocumentSnapshot<Object?> item) {
                var additionalInformation = item['additionalInformation'];
                if (additionalInformation != null) {
                  if (additionalInformation is List) {
                    uniqueItems.addAll(
                        additionalInformation.map((item) => item.toString()));
                  } else {
                    uniqueItems.add(additionalInformation.toString());
                  }
                }
              });

              dropdownItems.addAll(uniqueItems.toList());

              // Initialize selectTypeItem with the first item if the list is not empty
              selectTypeItem ??= dropdownItems.first;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManger.white,
                  borderRadius: BorderRadius.circular(15.w),
                  border: Border.all(color: ColorManger.darkGray),
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    "Select Type Of Document",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: ColorManger.backGroundColorToSplashScreen),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  value: selectTypeItem!.isNotEmpty
                      ? selectTypeItem
                      : "No items Selected",
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      key: UniqueKey(), // Use UniqueKey for each item
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selectTypeItem = item;
                    });
                  },
                ),
              );
            } else if (snapshot.hasError) {
              print("Error fetching type of document data: ${snapshot.error}");
            } else if (ConnectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: ColorManger.white,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(color: ColorManger.darkGray),
          ),
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
                      ),
                    ))
                .toList(),
            onChanged: (item) => setState(() {
              selectItem = item!;
            }),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        const TitleOfFormCreateCompany(titleText: "Comments"),
        SizedBox(
          height: 10.h,
        ),
        CustomTextFormField(
          hight: mediaQueryHeight * 0.10,
          hintText: "Add any Comment Here",
          prefixIcon: const Icon(Icons.comment),
          onChanged: (value) {
            comment = value;
          },
        ),
        CustomButton(
            nameOfButton: "Submitted",
            onTap: () async {
              // if (selectItem == 'new Document' || selectItem == 'registered'||selectItem == 'ready'||selectItem == 'redundant'){
              //   return
              // }
              print(docDitails['companydocID'].toString());
              if (globalKey.currentState!.validate() &&
                  selectItem != null &&
                  selectTypeItem != null) {
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
                    'AccountantReview': FieldValue.arrayUnion([
                      {
                        'companyName': companyName,
                        'invoiceDate': invoiceDate,
                        'invoiceNumber': invoiceNumber,
                        'amountOfTheInvoice': amountOfTheInvoice,
                        'selectItem': selectItem,
                        'selectTypeItem': selectTypeItem,
                        "statusDoc": 'success',
                        'comment': comment,
                        'staffTypeReview': 'Accountant',
                      }
                    ]),
                    'isAccountantReview': true
                    //  'accountant by':"email"
                  }).then((value) {
                    FirebaseFirestore.instance.collection('Notification').add({
                      'notificationMassage':
                          "Accountant added Document in $companyName with $selectTypeItem to review",
                      'role': 'Accountant',
                      'MassgeSendBy': 'AccountantReview',
                      'NotificationCompanyID': docDitails['DocID'],
                      'NotificationUserID':
                          FirebaseAuth.instance.currentUser!.uid
                    });
                  });

                  setState(() {
                    isAccountantReviewDoc = true;
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
              } else if (selectTypeItem == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("You Must add Type Of Document")));
              }
            }),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
