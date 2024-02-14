// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/data/add_company_hive.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/click_to_create_company.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/number_of_companies_and_documents.dart';
import 'package:mohra_project/generated/l10n.dart';

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
    required this.searchQuery,
  });

  final String searchQuery;

  @override
  State<CompaniesListThatUserCreated> createState() =>
      _CompaniesListThatUserCreatedState();
}

class _CompaniesListThatUserCreatedState
    extends State<CompaniesListThatUserCreated> {
  late Future<Box<AddCompanyToHive>> _companyBoxFuture;

  @override
  void initState() {
    super.initState();
    _companyBoxFuture = _openBox();
  }

  Future<Box<AddCompanyToHive>> _openBox() async {
    final boxExists = await Hive.boxExists('companyBox');
    if (boxExists) {
      final box = await Hive.openBox<AddCompanyToHive>('companyBox');
      if (box.isNotEmpty) {
        print('box is not empty');
        return box;
      }
    }
    final box = await Hive.openBox<AddCompanyToHive>('companyBox');
    final companies = await _getCompaniesFromFirebase();
    box.addAll(companies);
    print('box is  empty');
    return box;
  }

  Future<List<AddCompanyToHive>> _getCompaniesFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Companys")
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    final companies =
        snapshot.docs.map((doc) => AddCompanyToHive.fromSnapshot(doc)).toList();

    return companies;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).Companies,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 20),
          FutureBuilder<Box<AddCompanyToHive>>(
            future: _companyBoxFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final _companyBox = snapshot.data!;
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Companys")
                      .where('userID',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      final documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 25.h),
                              const Icon(
                                Icons.business_sharp,
                                color: Colors.black87,
                                size: 45,
                              ),
                              SizedBox(height: 25.h),
                              Center(
                                child: Text(
                                  S.of(context).NoCompanyMassage,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final companies = documents
                            .map((doc) => AddCompanyToHive.fromSnapshot(doc))
                            .toList();
                        _companyBox.addAll(companies);
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: companies.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10.h);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final company = companies[index];
                            print(
                                "======================${company.companyName}");
                            return CompanyButton(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouterName.companyDocuments,
                                  arguments: {
                                    'companyId': company.companyId,
                                    'companyAddress': company.companyAddress,
                                    'companyName': company.companyName,
                                    'companyType': company.companyType
                                  },
                                );
                              },
                              withStatus: true,
                              companyName: company.companyName,
                              logoCompany: company.logo,
                              colorOfStatus: company.companyStatus == 'Accepted'
                                  ? Colors.green
                                  : Colors.red,
                              statusText: company.companyStatus,
                            );
                          },
                        );
                      }
                    }
                    return Container();
                  },
                );
              } else {
                return const Center(
                  child: Text('Failed to open the Hive box'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
