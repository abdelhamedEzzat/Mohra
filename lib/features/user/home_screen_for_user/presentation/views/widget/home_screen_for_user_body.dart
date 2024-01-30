// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/click_to_create_company.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/number_of_companies_and_documents.dart';

// class Massage {
//   String massage;
//   Massage(
//     this.massage,
//   );
//   factory Massage.fromJson(jsondata) {
//     return Massage(jsondata["companyId"]);
//   }
// }

class HomeScreenForUserBody extends StatelessWidget {
  const HomeScreenForUserBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String searchQuery = "";
    return Column(
      children: [
        const Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              NumberOfCompaniesAndDocuments(),
              ClickToCreateCampany(),
            ]),
        CompaniesListThatUserCreated(searchQuery: searchQuery),
      ],
    );
  }
}

class CompaniesListThatUserCreated extends StatefulWidget {
  const CompaniesListThatUserCreated({
    super.key,
    required String searchQuery,
  });

  @override
  State<CompaniesListThatUserCreated> createState() =>
      _CompaniesListThatUserCreatedState();
}

class _CompaniesListThatUserCreatedState
    extends State<CompaniesListThatUserCreated> {
  @override
  void initState() {
    // BlocProvider.of<FirebaseCreateCompanyCubit>(context).getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> companyCollection = FirebaseFirestore.instance
        .collection("Companys")
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 80.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Company :",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
              builder: (context, state) {
                return StreamBuilder<QuerySnapshot>(
                  stream: companyCollection,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data!.docs[index]["CompanyStatus"] ==
                                  'Waiting for Accepted'
                              ? SingleChildScrollView(
                                  child: CompanyButton(
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
                                )
                              : SingleChildScrollView(
                                  child: CompanyButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouterName.companyDocuments,
                                          arguments: snapshot.data!.docs[index]
                                              ["companyId"]);
                                    },
                                    withStatus: true,
                                    companyName: snapshot.data!.docs[index]
                                        ["company_Name"],
                                    logoCompany: snapshot.data!.docs[index]
                                        ["logo"],
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
                      );
                    } else if (snapshot.connectionState ==
                        snapshot.connectionState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
