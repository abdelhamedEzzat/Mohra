import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';
import 'package:mohra_project/generated/l10n.dart';

class AccountantHomeScreenBody extends StatelessWidget {
  const AccountantHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Accountant')
            .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots();

    return Column(
      children: [
        Container(
          color: ColorManger.backGroundColorToSplashScreen,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Companys')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // List<String> companyId =
                          //     snapshot.data?.docs.map((doc) {
                          //           return doc['companyId'] as String;
                          //         }).toList() ??
                          //         [];
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Staff')
                                .where('userid',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                // .where('CompanyId', isEqualTo: companyId)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return IconsAndTextToCompany(
                                  numberOfCompany:
                                      snapshot.data!.docs.length ?? 0,
                                  text: S.of(context).Companies,
                                );
                              } else {
                                print('no Company Found');
                                return IconsAndTextToCompany(
                                  numberOfCompany: 0,
                                  text: S.of(context).Companies,
                                );
                              }
                            },
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.black,
                          );
                        }
                      }),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Staff')
                        .where('userid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(color: Colors.black);
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      List<String> companyId = snapshot.data?.docs.map((doc) {
                            return doc['CompanyId'] as String;
                          }).toList() ??
                          [];
                      print(companyId);

                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Document')
                              .where('companydocID', whereIn: companyId)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot docSnapshot) {
                            if (docSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(
                                  color: Colors.black);
                            }

                            if (docSnapshot.hasError) {
                              return Text('Error: ${docSnapshot.error}');
                            }
                            print(
                              docSnapshot.data!.docs.length,
                            );

                            return IconsAndTextToCompany(
                              numberOfCompany:
                                  docSnapshot.data!.docs.length ?? 0,
                              text: S.of(context).Documents,
                            );
                          },
                        );
                      } else {
                        return IconsAndTextToCompany(
                          //numberOfCompany: 1,
                          text: S.of(context).Documents,
                        );
                      }
                    },
                  )
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
                    return Text(S.of(context).Nodocumentsfoundforyou);
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
                              return Text(S.of(context).Nodocumentsfoundforyou);
                            }

                            if (index < companySnapshot.data!.docs.length) {
                              var companyData =
                                  companySnapshot.data!.docs[index].data();

                              if (companyData.containsKey('company_Name')) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).MyAvailableCompanies,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                    CompanyButton(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouterName
                                                .accuntantCompanyDocuments,
                                            arguments: companySnapshot.data!
                                                .docs[index]['companyId']);
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
