// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

class StaffTabBARScreens extends StatelessWidget {
  const StaffTabBARScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> sttafList = FirebaseFirestore.instance
        .collection("users")
        .where('role.en', whereIn: ['Auditor', 'Accountant']).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: sttafList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Language currentLanguage =
              BlocProvider.of<LanguageCubit>(context).state;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (snapshot.data!.docs[index]["role"]["en"] ==
                          "Accountant" ||
                      snapshot.data!.docs[index]["role"]["ar"] == "محاسب") {
                    Navigator.of(context).pushNamed(
                        RouterName.companyOfAccountatinAdminScreen,
                        arguments: snapshot.data!.docs[index]["userID"]);
                  } else if (snapshot.data!.docs[index]["role"]["en"] ==
                          "Auditor" ||
                      snapshot.data!.docs[index]["role"]["ar"] == 'مراجع') {
                    Navigator.of(context).pushNamed(
                        RouterName.companyOfAuditorinAdminScreen,
                        arguments: snapshot.data!.docs[index]["userID"]);
                  }
                },
                child: StaffShowWidget(
                  staffName: snapshot.data!.docs[index]["first_Name"],
                  staffTitle: currentLanguage == Language.arabic
                      ? snapshot.data!.docs[index]["role"]["ar"]
                      : snapshot.data!.docs[index]["role"]["en"],
                  staffemail: snapshot.data!.docs[index]["email"],
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("You have an error."));
        } else {
          return Center(
            child: Text(S.of(context).Youdidnthaveanydocuments),
          );
        }
      },
    );
  }
}

class StaffShowWidget extends StatelessWidget {
  const StaffShowWidget({
    Key? key,
    required this.staffTitle,
    required this.staffemail,
    required this.staffName,
  }) : super(key: key);
  final String staffTitle;
  final String staffemail;
  final String staffName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
        child: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorManger.introScreenBackgroundColor,
          ),
          height: 120.h,
          width: 50,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: ColorManger.darkGray,
                ),
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                height: 50.h,
                child: Text(
                  staffTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${S.of(context).email}   $staffemail ",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "${S.of(context).UserName} :  $staffName ",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
