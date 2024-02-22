import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/tabpar_widget/company_tab.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/status_company.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key,
    this.colorOfStatus,
    this.statusText,
    required this.companyName,
    this.logoCompany,
    required this.withStatus,
    required this.onTap,
    //  required this.onTap,
  });
  final Color? colorOfStatus;
  final String? statusText;
  final String companyName;
  final String? logoCompany;
  final bool withStatus;
  final void Function()? onTap;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // Stream<QuerySnapshot> allCompany = FirebaseFirestore.instance
    //     .collection('Companys')
    //     // .where('CompanyStatus', isEqualTo: selectItem)
    //     .snapshots();
    return GestureDetector(
      onTap: onTap,
      child: withStatus == true
          ?

          //
          //   this for company name and button in user home screen
          //    this container with Status
          //

          BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    StatusWidget(
                        colorOfStatus: colorOfStatus,
                        statusText: statusText ?? ""),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorManger.backGroundColorToSplashScreen
                                .withOpacity(0.1),
                          ),
                          height: MediaQuery.of(context).size.height * 0.13,
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 10.h),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Text(
                                    companyName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(right: 12.w, top: 6.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: CircleAvatar(
                                      maxRadius: 25.h,
                                      minRadius: 21.h,
                                      child: Image.network(
                                        logoCompany ?? "No Image",
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // StreamBuilder<QuerySnapshot>(
                        //   stream: allCompany,
                        //   builder:
                        //       (BuildContext context, AsyncSnapshot snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Center(
                        //         child: CircularProgressIndicator(
                        //             color: Colors.black),
                        //       );
                        //     } else if (snapshot.hasError) {
                        //       print("you have error in company tao ");
                        //     } else if (snapshot.hasData) {
                        //       return ListView.separated(
                        //         shrinkWrap: true,
                        //         physics: NeverScrollableScrollPhysics(),
                        //         itemCount: snapshot.data!.docs.length,
                        //         separatorBuilder:
                        //             (BuildContext context, int index) {
                        //           return Divider(); // Add a divider between companies
                        //         },
                        //         itemBuilder: (BuildContext context, int index) {
                        //           final companyData =
                        //               snapshot.data!.docs[index];
                        //           return Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 companyData[
                        //                     "company_Name"], // Display company name
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               StreamBuilder(
                        //                 stream: FirebaseFirestore.instance
                        //                     .collection('Staff')
                        //                     .where('CompanyId',
                        //                         isEqualTo:
                        //                             companyData["companyId"])
                        //                     .snapshots(),
                        //                 builder: (BuildContext context,
                        //                     AsyncSnapshot staffSnapshot) {
                        //                   if (staffSnapshot.hasData) {
                        //                     return ListView.builder(
                        //                       shrinkWrap: true,
                        //                       physics:
                        //                           const NeverScrollableScrollPhysics(),
                        //                       itemCount: staffSnapshot
                        //                           .data.docs.length,
                        //                       itemBuilder:
                        //                           (BuildContext context,
                        //                               int index) {
                        //                         final staffData = staffSnapshot
                        //                             .data.docs[index];
                        //                         return Row(
                        //                           children: [
                        //                             Text(
                        //                                 staffData['StaffRole']),
                        //                             SizedBox(width: 5),
                        //                             Text(":"),
                        //                             SizedBox(width: 5),
                        //                             Text(
                        //                                 staffData['StaffName']),
                        //                           ],
                        //                         );
                        //                       },
                        //                     );
                        //                   } else {
                        //                     return Text("you didnt have data");
                        //                   }
                        //                 },
                        //               ),
                        //             ],
                        //           );
                        //         },
                        //       );
                        //     }
                        //     return Container();
                        //   },
                        // ),
                      ],
                    ),
                    // ),
                  ],
                );
              },
            )
          :
          //
          //   this for company name and button in user home screen
          //    this container with Status
          //

          Container(
              margin: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                    ColorManger.backGroundColorToSplashScreen.withOpacity(0.1),
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    companyName,
                    style: Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(75.h),
                    child: CircleAvatar(
                      maxRadius: 28.h,
                      minRadius: 22.h,
                      child: Image.network(
                        logoCompany ?? "",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
