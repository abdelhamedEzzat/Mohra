import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

// class AllCampanyWithStatus extends StatelessWidget {
//   const AllCampanyWithStatus({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 15.h),
//               child: CompanyButton(
//                   colorOfStatus: ColorManger.acceptedCompanyStatus,
//                   statusText: "Accepted",
//                   companyName: "companyName",
//                   logoCompany: "ImageManger.mohraLogo",
//                   withStatus: true,
//                   onTap: () {}),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15.h),
//               child: CompanyButton(
//                   colorOfStatus: ColorManger.rejectedCompanyStatus,
//                   statusText: "Rejcted",
//                   companyName: "companyName",
//                   logoCompany: "ImageManger.mohraLogo",
//                   withStatus: true,
//                   onTap: () {}),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15.h),
//               child: CompanyButton(
//                   colorOfStatus: ColorManger.darkGray,
//                   statusText: "Wating to Accepted",
//                   companyName: "companyName",
//                   logoCompany: "ImageManger.mohraLogo",
//                   withStatus: true,
//                   onTap: () {}),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CompanysTabBarScreen extends StatefulWidget {
  const CompanysTabBarScreen({
    super.key,
  });

  @override
  State<CompanysTabBarScreen> createState() => _CompanysTabBarScreenState();
}

class _CompanysTabBarScreenState extends State<CompanysTabBarScreen> {
  List<String> filterCompanyDropDown = [
    "Accepted",
    "Rejected",
    "Waiting for Accepted",
  ];

  String? selectItem;
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> allCompany = FirebaseFirestore.instance
        .collection('Companys')
        .where('CompanyStatus', isEqualTo: selectItem)
        .snapshots();
    return Container(
      //color: ColorManger.darkGray.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 15.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconsAndTextToCompany(
                  text: "Companies",
                  color: Colors.black,
                ),
                IconsAndTextToDoc(
                  color: Colors.black,
                  text: "Documents",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: ColorManger.white,
                borderRadius: BorderRadius.circular(15.h),
                border: Border.all(color: ColorManger.darkGray)),
            child: DropdownButton<String>(
              hint: Text(
                "Choose Filter",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              value: selectItem,
              items: filterCompanyDropDown
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
          ),
          SizedBox(
            height: 10.h,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: allCompany,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else if (snapshot.hasError) {
                print("you have error in company tao ");
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data.docs[index]['CompanyStatus'] ==
                              'Waiting for Accepted'
                          ? SingleChildScrollView(
                              child: Container(
                                  height: 135.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  margin: EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    CompanyButton(
                                      onTap: () {},
                                      withStatus: true,
                                      companyName: snapshot.data!.docs[index]
                                          ["company_Name"],
                                      logoCompany: snapshot.data!.docs[index]
                                          ["logo"],
                                      colorOfStatus: ColorManger.darkGray,
                                      statusText: snapshot.data!.docs[index]
                                          ["CompanyStatus"],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        rejectedCompanyMethod(
                                            context, snapshot, index),
                                        acceptedCompanyMethod(
                                            context, snapshot, index),
                                      ],
                                    )),
                                  ])))
                          : SingleChildScrollView(
                              child: CompanyButton(
                                onTap: () {},
                                withStatus: true,
                                companyName: snapshot.data!.docs[index]
                                    ["company_Name"],
                                logoCompany: snapshot.data!.docs[index]["logo"],
                                colorOfStatus: snapshot.data!.docs[index]
                                            ["CompanyStatus"] ==
                                        'Accepted'
                                    ? Colors.green
                                    : Colors.red,
                                statusText: snapshot.data!.docs[index]
                                    ["CompanyStatus"],
                              ),
                            );
                    },
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }

  Expanded rejectedCompanyMethod(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red,
        ),
        margin: EdgeInsets.only(right: 5.w),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () async {
            String companyIdToSearch = snapshot.data!.docs[index]['companyId'];

            try {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('Companys')
                  .where('companyId', isEqualTo: companyIdToSearch)
                  .get();

              if (querySnapshot.docs.isNotEmpty) {
                // Company with the specified companyId found
                DocumentSnapshot companyDocument = querySnapshot.docs.first;

                // Update the company status to "Rejected"
                await FirebaseFirestore.instance
                    .collection('Companys')
                    .doc(companyDocument.id)
                    .update({'CompanyStatus': 'Rejected'});
              }
            } catch (e) {
              print('Error querying for company: $e');
            }
          },
          child: const Text('Rojected'),
        ),
      ),
    );
  }

  Expanded acceptedCompanyMethod(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.green,
              ),
              margin: EdgeInsets.only(right: 5.w),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () async {
                  String companyIdToSearch =
                      snapshot.data!.docs[index]['companyId'];

                  try {
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection('Companys')
                        .where('companyId', isEqualTo: companyIdToSearch)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      // Company with the specified companyId found
                      DocumentSnapshot companyDocument =
                          querySnapshot.docs.first;

                      // Update the company status to "Rejected"
                      await FirebaseFirestore.instance
                          .collection('Companys')
                          .doc(companyDocument.id)
                          .update({'CompanyStatus': 'Accepted'});
                    }
                  } catch (e) {
                    print('Error querying for company: $e');
                  }
                },
                child: const Text('Accepted'),
              ),
            ),
          ),
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius:
          //           BorderRadius.circular(25),
          //       color: Colors.green,
          //     ),
          //     margin:
          //         EdgeInsets.only(left: 5.w),
          //     alignment: Alignment.center,
          //     height: MediaQuery.of(context)
          //         .size
          //         .height,
          //     width: MediaQuery.of(context)
          //         .size
          //         .width,
          //     child: const Text('Accepted'),
          //   ),
          // )
        ],
      ),
    );
  }
}
