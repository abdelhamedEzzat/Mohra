import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AuditorHomeScreenBody extends StatefulWidget {
  const AuditorHomeScreenBody({Key? key}) : super(key: key);

  @override
  _AuditorHomeScreenBodyState createState() => _AuditorHomeScreenBodyState();
}

class _AuditorHomeScreenBodyState extends State<AuditorHomeScreenBody> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> staffStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> companyCollection =
        FirebaseFirestore.instance
            .collection("Staff")
            .where('StaffRole', isEqualTo: 'Auditor')
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
                          List<String> companyId =
                              snapshot.data?.docs.map((doc) {
                                    return doc['companyId'] as String;
                                  }).toList() ??
                                  [];
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
                                  text: "Companies",
                                );
                              } else {
                                print('no Company Found');
                                return const IconsAndTextToCompany(
                                  numberOfCompany: 0,
                                  text: "Companies",
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
                              text: "Documents",
                            );
                          },
                        );
                      } else {
                        return const IconsAndTextToCompany(
                          //numberOfCompany: 1,
                          text: "Documents",
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
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            margin: EdgeInsets.only(top: 20.h),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: companyCollection,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "My available companies :",
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
                                    itemCount: companySnapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CompanyButton(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            RouterName.auditorCompanyDocuments,
                                            arguments: companySnapshot
                                                .data!.docs[index]['companyId']
                                                .toString(),
                                          );
                                        },
                                        withStatus: false,
                                        companyName: companySnapshot
                                            .data!.docs[index]['company_Name'],
                                        logoCompany: companySnapshot
                                            .data!.docs[index]['logo'],
                                      );
                                    },
                                  );
                                } else {
                                  // Handle the case when there is no data
                                  return Text('No available companies.');
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
                            child: Text(
                                "You haven't created any companies yet. Click to create one!",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
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
    );
  }
}
