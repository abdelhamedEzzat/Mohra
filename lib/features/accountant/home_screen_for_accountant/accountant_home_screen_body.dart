import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AccountantHomeScreenBody extends StatelessWidget {
  const AccountantHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Accountant')
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
