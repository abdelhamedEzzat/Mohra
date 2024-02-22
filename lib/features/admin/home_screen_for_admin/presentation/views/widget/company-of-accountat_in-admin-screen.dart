import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/generated/l10n.dart';

class CompanyOfAccountatinAdminScreen extends StatelessWidget {
  const CompanyOfAccountatinAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments;

    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Accountant')
            .where('userid', isEqualTo: userID)
            .snapshots();
    return Scaffold(
      appBar: CustomAppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(S.of(context).accountantCompany),
        onPressed: () {},
      ),
      body: Column(
        children: [
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
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
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
                                return Text(
                                    S.of(context).Nodocumentsfoundforyou);
                              }

                              if (index < companySnapshot.data!.docs.length) {
                                var companyData =
                                    companySnapshot.data!.docs[index].data();

                                if (companyData.containsKey('company_Name')) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).accountantCompany,
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
                                        companyName:
                                            companyData['company_Name'],
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
      ),
    );
  }
}
