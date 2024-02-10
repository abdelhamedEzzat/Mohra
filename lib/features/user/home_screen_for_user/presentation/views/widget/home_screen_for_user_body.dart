// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/click_to_create_company.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/number_of_companies_and_documents.dart';

class HomeScreenForUserBody extends StatelessWidget {
  const HomeScreenForUserBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String searchQuery = "";
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: ColorManger.backGroundColorToSplashScreen,
                  child: const NumberOfCompaniesAndDocuments(),
                )),
            Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(top: 70.h, right: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: CompaniesListThatUserCreated(searchQuery: searchQuery),
                )),
          ],
        ),
        Positioned(
            top: 70.h, right: 0, left: 0, child: const ClickToCreateCampany())
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

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Company :",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
              builder: (context, state) {
                return StreamBuilder<QuerySnapshot>(
                  stream: companyCollection,
                  builder: (context, snapshot) {
                    print('Documents: ${snapshot.data?.docs}');
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
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
                                child: Text(
                                    "You haven't created any companies yet. Click to create one!",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data!.docs[index]
                                        ["CompanyStatus"] ==
                                    'Waiting for Accepted'
                                ? CompanyButton(
                                    onTap: () {},
                                    withStatus: true,
                                    companyName: snapshot.data!.docs[index]
                                        ["company_Name"],
                                    logoCompany: snapshot.data!.docs[index]
                                        ["logo"],
                                    colorOfStatus: ColorManger.darkGray,
                                    statusText: snapshot.data!.docs[index]
                                        ["CompanyStatus"],
                                  )
                                : CompanyButton(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouterName.companyDocuments,
                                        arguments: snapshot.data!.docs[index]
                                            ["companyId"],
                                      );
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
                                  );
                          },
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ],
        ));
  }
}
