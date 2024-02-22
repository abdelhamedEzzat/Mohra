import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

class MangeCompanyStaff extends StatelessWidget {
  const MangeCompanyStaff({super.key});

  @override
  Widget build(BuildContext context) {
    var compantId = ModalRoute.of(context)!.settings.arguments;
    Stream<QuerySnapshot> allDocument = FirebaseFirestore.instance
        .collection('Document')
        .where('companydocID', isEqualTo: compantId)
        .snapshots();

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(S.of(context).SeeDocumentCompany),
        onPressed: () {},
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            // Row(
            //   children: [
            // Text(
            //   S.of(context).Documents,
            //   style: Theme.of(context).textTheme.displayMedium,
            // ),
            // Text(
            //   " : ",
            //   style: Theme.of(context).textTheme.displayMedium,
            // ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                    ColorManger.backGroundColorToSplashScreen.withOpacity(0.9),
              ),
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 8.h, bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).Numberofcompanydocuments,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    " : ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: allDocument,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "${snapshot.data.docs.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return Text("data");
                      },
                    ),
                  ),
                ],
              ),
            ),
            //   ],
            // ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    RouterName.accuntantCompanyDocuments,
                    arguments: compantId);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ColorManger.backGroundColorToSplashScreen
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15)),
                height: 150.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 45.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                        child: Text(
                      S.of(context).Displaydatathroughtheaccountantscreen,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    RouterName.auditorCompanyDocuments,
                    arguments: compantId);
              },
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                    color: ColorManger.backGroundColorToSplashScreen
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 45.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                        child: Text(
                      S.of(context).DisplaydatathroughtheAuditorscreen,
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
