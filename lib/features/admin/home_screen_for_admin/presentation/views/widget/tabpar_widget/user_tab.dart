// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/generated/l10n.dart';

class UsersTabBarScreens extends StatelessWidget {
  const UsersTabBarScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersList = FirebaseFirestore.instance
        .collection("users")
        .where('Email_status', isEqualTo: "disabled")
        .snapshots();

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        margin: EdgeInsets.only(top: 15.h),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return AcceptedUsersWifget(
                      email: snapshot.data!.docs[index]['email'],
                      userName: snapshot.data!.docs[index]["first_Name"],
                      acceptedOnTap: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(snapshot.data!.docs[index].id)
                            .update({'Email_status': 'enabled'});
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(snapshot.data!.docs[index].id)
                            .update({'status': '2'});
                      },
                      rejectedOnTap: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                        await FirebaseAuth.instance.currentUser!.delete();

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(snapshot.data!.docs[index].id)
                            .update({'status': '0'});
                      });
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
        ));
  }
}

class AcceptedUsersWifget extends StatelessWidget {
  const AcceptedUsersWifget({
    Key? key,
    required this.email,
    required this.userName,
    required this.acceptedOnTap,
    required this.rejectedOnTap,
  }) : super(key: key);
  final String email;
  final String userName;
  final void Function()? acceptedOnTap;
  final void Function()? rejectedOnTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.h),
                  topRight: Radius.circular(10.h))),
          margin: EdgeInsets.only(top: 15.h),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.10,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text("${S.of(context).email} :$email"),
                ],
              ),
              Row(
                children: [
                  Text("${S.of(context).UserName}:$userName "),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorManger.introScreenBackgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.h),
                  bottomRight: Radius.circular(10.h))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: acceptedOnTap,
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(S.of(context).Accepted),
                  ),
                ),
              )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: rejectedOnTap,
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(S.of(context).Rejected),
                  ),
                ),
              ))
            ],
          ),
        )
      ]),
    );
  }
}
