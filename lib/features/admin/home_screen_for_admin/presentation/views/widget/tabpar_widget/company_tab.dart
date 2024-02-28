import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/company_bottom_for_admin.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

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
  Map<String, Map<String, String>> filterCompanyDropDown = {
    "Accepted": {
      "en": "Accepted",
      "ar": "تم قبول الشركه",
    },
    "Rejected": {
      "en": "Rejected",
      "ar": "تم رفض الشركه",
    },
    "Waiting for Accepted": {
      "en": "Waiting for Accepted",
      "ar": "في انتظار الموافقه",
    },
  };
 

  String? selectItem;
  @override
  Widget build(BuildContext context) {
    Language currentLanguage = BlocProvider.of<LanguageCubit>(context).state;
    Stream<QuerySnapshot> allCompany = FirebaseFirestore.instance
        .collection('Companys')
        .where(
            currentLanguage == Language.arabic
                ? 'CompanyStatus.ar'
                : 'CompanyStatus.en',
            isEqualTo: selectItem)
        .snapshots();
    return Container(
      //color: ColorManger.darkGray.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 15.h),
            decoration: BoxDecoration(
                color: ColorManger.introScreenBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Companys')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconsAndTextToCompany(
                          color: Colors.black,
                          numberOfCompany: snapshot.data!.docs.length,
                          text: S.of(context).Companies,
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.black,
                        );
                      }
                    }),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Document')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconsAndTextToCompany(
                          color: Colors.black,
                          numberOfCompany: snapshot.data!.docs.length,
                          text: S.of(context).Documents,
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.black,
                        );
                      }
                    }),
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
                S.of(context).ChooseFilter,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              value: selectItem,
              items: currentLanguage == Language.arabic
                  ? filterCompanyDropDown.values
                      .map((value) => DropdownMenuItem(
                          value: value['ar'],
                          child: Text(
                            value['ar']!,
                            style: Theme.of(context).textTheme.displayMedium,
                          )))
                      .toList()
                  : filterCompanyDropDown.values
                      .map((value) => DropdownMenuItem(
                          value: value['en'],
                          child: Text(
                            value['en']!,
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
                Language currentLanguage =
                    BlocProvider.of<LanguageCubit>(context).state;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return (snapshot.data!.docs[index]["CompanyStatus"]
                                      .containsKey('en') &&
                                  snapshot.data!.docs[index]["CompanyStatus"]
                                          ['en'] ==
                                      "Waiting for Accepted") ||
                              (snapshot.data!.docs[index]["CompanyStatus"]
                                      .containsKey('ar') &&
                                  snapshot.data!.docs[index]["CompanyStatus"]
                                          ['ar'] ==
                                      "في انتظار الموافقه")
                          ? SingleChildScrollView(
                              child: Container(
                                height: 135.h,
                                decoration: BoxDecoration(
                                  color: ColorManger.darkGray.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CompanyButton(
                                      onTap: () {},
                                      withStatus: true,
                                      companyName: snapshot.data!.docs[index]
                                          ["company_Name"],
                                      logoCompany: snapshot.data!.docs[index]
                                          ["logo"],
                                      colorOfStatus: ColorManger.darkGray,
                                      statusText:
                                          currentLanguage == Language.arabic
                                              ? snapshot.data!.docs[index]
                                                  ["CompanyStatus"]["ar"]
                                              : snapshot.data!.docs[index]
                                                  ["CompanyStatus"]["en"],
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  CompanyButtonForAdmin(
                                    onTap: () {
                                      if (snapshot.data!
                                              .docs[index]["CompanyStatus"]
                                              .containsKey('en') &&
                                          snapshot.data!
                                              .docs[index]["CompanyStatus"]
                                              .containsKey('ar')) {
                                        if (snapshot.data!.docs[index]
                                                    ["CompanyStatus"]['en'] ==
                                                "Accepted" ||
                                            snapshot.data!.docs[index]
                                                    ["CompanyStatus"]['ar'] ==
                                                "تم قبول الشركه") {
                                          Navigator.of(context).pushNamed(
                                              RouterName.mangeCompanyStaff,
                                              arguments: snapshot.data!
                                                  .docs[index]["companyId"]);
                                        }
                                      }
                                    },
                                    withStatus: true,
                                    companyName: snapshot.data!.docs[index]
                                        ["company_Name"],
                                    logoCompany: snapshot.data!.docs[index]
                                        ["logo"],
                                    colorOfStatus: snapshot.data!.docs[index]
                                                    ["CompanyStatus"]['en'] ==
                                                'Accepted' ||
                                            snapshot.data!.docs[index]
                                                    ["CompanyStatus"]['ar'] ==
                                                "تم قبول الشركه"
                                        ? Colors.black.withOpacity(0.8)
                                        : Colors.red,
                                    statusText:
                                        currentLanguage == Language.arabic
                                            ? snapshot.data!.docs[index]
                                                ["CompanyStatus"]["ar"]
                                            : snapshot.data!.docs[index]
                                                ["CompanyStatus"]["en"],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)),
                                      color: ColorManger
                                          .backGroundColorToSplashScreen
                                          .withOpacity(0.1),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w, bottom: 10.h),
                                    width: MediaQuery.of(context).size.width,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Staff')
                                          .where('CompanyId',
                                              isEqualTo: snapshot.data!
                                                  .docs[index]["companyId"])
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                              left: 12.w,
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      child: Text(snapshot
                                                              .data!.docs[index]
                                                          ['StaffRole']),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    const Text(":"),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Container(
                                                      child: Text(snapshot
                                                              .data!.docs[index]
                                                          ['StaffName']),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Text("you didnt have data");
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
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
                    .update({
                  'CompanyStatus': {"ar": "تم رفض الشركه", "en": "Rejected"}
                });

                await FirebaseFirestore.instance
                    .collection('Notification')
                    .add({
                  'notificationMassage':
                      "${S.of(context).yourCompany} ${companyDocument['company_Name']}${S.of(context).HasbeenRejected}",
                  'role': "admin",
                  'MassgeSendBy': 'Review',
                  'NotificationCompanyID': companyDocument['DocID'],
                  'NotificationUserID': ''
                });
              }
            } catch (e) {
              print('Error querying for company: $e');
            }
          },
          child: Text(S.of(context).Regected),
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
                          .update({
                        'CompanyStatus': {
                          "ar": "تم قبول الشركه",
                          "en": "Accepted"
                        }
                      });

                      await FirebaseFirestore.instance
                          .collection('Notification')
                          .add({
                        'notificationMassage':
                            "${S.of(context).yourCompany} ${companyDocument['company_Name']}${S.of(context).HasbeenAccepted}",
                        'role': "admin",
                        'MassgeSendBy': 'adminstration',
                        'NotificationCompanyID': companyDocument['DocID'],
                        'NotificationUserID': ''
                      });
                    }
                  } catch (e) {
                    print('Error querying for company: $e');
                  }
                },
                child: Text(S.of(context).Accepted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
