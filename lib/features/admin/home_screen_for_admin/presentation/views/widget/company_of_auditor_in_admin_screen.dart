import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/generated/l10n.dart';

class CompanyOfAuditorinAdminScreen extends StatelessWidget {
  const CompanyOfAuditorinAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments;
    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Auditor')
            .where('userid', isEqualTo: userID)
            .snapshots();
    return Scaffold(
        appBar: CustomAppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text(S.of(context).AuditorCompany),
          onPressed: () {},
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                margin: EdgeInsets.only(top: 20.h),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: companyCollection,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).auditorCompany,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap:
                                  true, // Allow the outer ListView to take its natural size
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                String companyId =
                                    snapshot.data.docs[index]['CompanyId'];
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Companys')
                                      .where('companyId', isEqualTo: companyId)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot companySnapshot) {
                                    if (companySnapshot.hasData &&
                                        companySnapshot.data.docs.isNotEmpty) {
                                      return ListView.builder(
                                        shrinkWrap:
                                            true, // Allow the inner ListView to take its natural size
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            companySnapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CompanyButton(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                RouterName
                                                    .auditorCompanyDocuments,
                                                arguments: companySnapshot.data!
                                                    .docs[index]['companyId']
                                                    .toString(),
                                              );
                                            },
                                            withStatus: false,
                                            companyName: companySnapshot.data!
                                                .docs[index]['company_Name'],
                                            logoCompany: companySnapshot
                                                .data!.docs[index]['logo'],
                                          );
                                        },
                                      );
                                    } else {
                                      // Handle the case when there is no data
                                      return Text(
                                          S.of(context).NoAvailableCompanies);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              Icon(
                                Icons.business_sharp,
                                color: Colors.black87,
                                size: 45.h,
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Center(
                                child: Text(S.of(context).NoAvailableCompanies,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
