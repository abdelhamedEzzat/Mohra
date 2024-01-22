// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          NumberOfCompaniesAndDocuments(),
          ClickToCreateCampany(),
        ]),
        CompaniesListThatUserCreated(),
      ],
    );
  }
}

class CompaniesListThatUserCreated extends StatefulWidget {
  const CompaniesListThatUserCreated({
    super.key,
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
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Companys")
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
                      // List<Massage> massageList = [];
                      // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      //   massageList
                      //       .add(Massage.fromJson(snapshot.data!.docs[i]));
                      // }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
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
                              logoCompany: snapshot.data!.docs[index]["logo"],
                              colorOfStatus: ColorManger.darkGray,
                              statusText: "Waiting for Accepted",
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
