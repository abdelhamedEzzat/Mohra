import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AuditorHomeScreenBody extends StatefulWidget {
  const AuditorHomeScreenBody({Key? key}) : super(key: key);

  @override
  _AuditorHomeScreenBodyState createState() => _AuditorHomeScreenBodyState();
}

class _AuditorHomeScreenBodyState extends State<AuditorHomeScreenBody> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> staffStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Auditor')
            .where('Staffid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots();

    return Column(
      children: [
        Container(
          color: ColorManger.backGroundColorToSplashScreen,
          height: MediaQuery.of(context).size.height * 0.15,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconsAndTextToCompany(
                    text: "Companies",
                  ),
                  IconsAndTextToDoc(
                    text: "Documents",
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            margin: EdgeInsets.only(top: 20.h),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: companyCollection,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        staffSnapshot) {
                  if (staffSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (staffSnapshot.hasError) {
                    return Text('Error: ${staffSnapshot.error}');
                  }

                  if (!staffSnapshot.hasData) {
                    return Text('No matching documents found for staff.');
                  }

                  return Container(
                    width: 300,
                    height: 300,
                    child: ListView.builder(
                      itemCount: staffSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Object?> staffDocument =
                            staffSnapshot.data!.docs[index];
                        var staffCompanyId = staffDocument['CompanyId'];

                        var companyCollection = FirebaseFirestore.instance
                            .collection('Companys')
                            .where("companyId", isEqualTo: staffCompanyId)
                            .snapshots();

                        return StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          stream: companyCollection,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  companySnapshot) {
                            if (companySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (companySnapshot.hasError) {
                              return Text('Error: ${companySnapshot.error}');
                            }

                            if (!companySnapshot.hasData ||
                                companySnapshot.data!.docs.isEmpty) {
                              return const Text(
                                  'No matching documents found for company.');
                            }

                            if (index < companySnapshot.data!.docs.length) {
                              var companyData =
                                  companySnapshot.data!.docs[index].data();

                              // Check if 'company_Name' exists in the company document
                              if (companyData.containsKey('company_Name')) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My available companies :",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                    CompanyButton(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouterName.auditorCompanyDocuments,
                                            arguments: {
                                              companySnapshot.data!.docs[index]
                                                  ['companyId'],
                                              companySnapshot.data!.docs[index]
                                                  ['company_Name']
                                            });
                                      },
                                      withStatus: false,
                                      companyName: companyData['company_Name'],
                                      logoCompany: companySnapshot
                                          .data!.docs[index]['logo'],
                                    )
                                  ],
                                );
                              } else {
                                return Text('Missing data: company_Name');
                              }
                            } else {
                              return Text('Invalid index: $index');
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
















 
// Future<void> compareData() async {
//   var addUserInformation = FirebaseFirestore.instance.collection('users');

//   var addUserInformationdata =
//       await addUserInformation.where('role', isNotEqualTo: "User").get();
//   var staffInformation = addUserInformationdata.docs[0];
//   var staffUserID = staffInformation["userID"];

//   bool isEqual = false;

//   var companyData = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("Companys")
//       .get()
//       .then((QuerySnapshot<Map<String, dynamic>> value) async {
//     for (var element in value.docs) {
//       var data = element.data();
//       var staffData = data[FirebaseFirestore.instance
//           .collection('users')
//           .where('role', isEqualTo: "Auditor")
//           .get()];

//       if (staffData != null) {
//         var staffEmail = staffData['StaffEmail'];

//         // Now, let's compare 'staffEmail' with 'userID' in the 'users' collection
//         var userSnapshot = await FirebaseFirestore.instance
//             .collection('users')
//             .where('userID', isEqualTo: staffEmail)
//             .get();

//         if (userSnapshot.docs.isNotEmpty) {
//           // Match found
//           print(
//               'Match found. StaffEmail: $staffEmail, UserID: ${userSnapshot.docs[0]['userID']}');
//           return false; // or whatever you need to do when there is a match
//         } else {
//           // No match found
//           print('No match found. StaffEmail: $staffEmail');
//           return true; // or whatever you need to do when there is no match
//         }
//       }
//     }

//     // No 'staffEmail' found in the 'Companys' collection
//     return true; // or handle this case as needed
//   });

// // 'companyData' now contains the result of the comparison
//   print(companyData);
// }
// //     // Get data from the second table
// //     var table2Snapshot = await FirebaseFirestore.instance
// //         .collection('users')
// //         .doc(FirebaseAuth.instance.currentUser!.uid)
// //         .collection("Companys")
// //         .get();

// //     if (table1Snapshot.docs.isNotEmpty && table2Snapshot.docs.isNotEmpty) {
// //       var dataFromTable1 = table1Snapshot.docs[0].data();

// //       // Assuming "userID" is the key you're interested in
// //       var userIDFromTable1 = dataFromTable1['userID'];

// //       // Iterate through the documents in the second table
// //       for (var element in table2Snapshot.docs) {
// //         var data = element.data();
// //         var staffEmail = data[FirebaseAuth.instance.currentUser!.uid];

// //         if (staffEmail != null) {
// //           var staffRole = data['StaffRole'];
// //           var staffName = data['StaffName'];

// //           print("StaffEmail: $staffEmail");
// //           print("StaffRole: $staffRole");
// //           print("StaffName: $staffName");

// //           // Compare staff email with user ID
// //           if (staffEmail == userIDFromTable1) {
// //             print('تم العثور على تطابق!');
// //           } else {
// //             print('لا يوجد تطابق.');
// //           }
// //         }
// //       }
// //     } else {
// //       print('لم يتم العثور على بيانات.');
// //     }
//   // } 
 
// // }






//     var addUserInformation = FirebaseFirestore.instance
//         .collection('users')
//         .doc()
//         .collection("Companys")
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         var data = element.data();
// //
//         // Assuming "1" is the key you're interested in
//         var staffData = data["StaffEmail"];

//         if (staffData != null) {
//           var staffEmail = staffData['StaffEmail'];
//           var staffRole = staffData['StaffRole'];
//           var staffName = staffData['StaffName'];

//           print("StaffEmail: $staffEmail");
//           print("StaffRole: $staffRole");
//           print("StaffName: $staffName");
//         } else {}
//       });
//     });

    // var addUserInformationdata = await addUserInformation.
    //     .where('role', isNotEqualTo: "Company_type")
    //     .get();