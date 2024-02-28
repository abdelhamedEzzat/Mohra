import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/glass_screen_for_login_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/gradiant_list.dart';
import 'package:mohra_project/generated/l10n.dart';

class AdminstrationAccepted extends StatelessWidget {
  const AdminstrationAccepted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradiantList,
        )),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(child: GlassScreenForLoginScreen()),
                Positioned(child: AdminstrationAcceptedBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminstrationAcceptedBody extends StatefulWidget {
  const AdminstrationAcceptedBody({super.key});

  @override
  State<AdminstrationAcceptedBody> createState() =>
      _AdminstrationAcceptedState();
}

bool isdesapled = false;
Timer _timer = Timer(Duration.zero, () {});

class _AdminstrationAcceptedState extends State<AdminstrationAcceptedBody> {
  void initState() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.reload();
        if (user.emailVerified) {
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            checkEmail(); // قم بتنفيذ الوظيفة التي تريدها هنا
          });
          WidgetsBinding.instance
              .addPostFrameCallback((_) => showEmailVerifiedSnackBar(context));
        }
        // else {
        //   showWelcomeSnackBar(context);
        // }
      }
    } catch (e) {
      print("Error in initState: $e");
    }
    super.initState();
  }

  void dispose() {
    _timer.cancel(); // للتأكد من إلغاء الـ Timer عند إغلاق الصفحة
    super.dispose();
  }

  void showEmailVerifiedSnackBar(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(user.uid)
          .get();

      String emailStatus = userData["Email_status"];
      if (emailStatus == "disabled") {
        isdesapled = true;
        // ignore: use_build_context_synchronously
        return showSnackBar(
          context,
          S.of(context).snackParInAdminstrationPage,
          backgroundcolor: ColorManger.backGroundColorToSplashScreen,
          duration: const Duration(seconds: 4),
        );
      } else {
        return;
      }
    }
  }

  void showWelcomeSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
        context, S.of(context).snackParInAdminstrationPage,
        backgroundcolor: ColorManger.backGroundColorToSplashScreen,
        duration: const Duration(seconds: 5)));
  }

  Future<void> checkEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get();

        String emailStatus = userData["Email_status"] ?? "";
        String status = userData["status"] ?? "";
        if (emailStatus.toLowerCase() == "disabled") {
          setState(() {
            isdesapled == true;
          });
        } else if (emailStatus.toLowerCase() == "enabled" && status == "2") {
          print(status);
          Navigator.of(context)
              .pushReplacementNamed(RouterName.homeScreenForUser);
          setState(() {
            isdesapled == false;
          });
          print(emailStatus);
        }
      }
    } catch (e) {
      print("Error checking email status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Center(
          child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   ImageManger.mohraLogo,
            // ),
            SizedBox(
              height: 20.h,
            ),
            ClassMorphismInsideScreen(
              blur: 20,
              opacity: 0.5,
              child: Container(
                  alignment: Alignment.center,
                  height: 300.h,
                  margin: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                  ),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, right: 10, left: 10),
                  child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.check_circle, size: 60.h),
                              subTitleOfVerify(context),
                            ]),
                      )
                    ],
                  )),
            ),
          ],
        ),
      )),
    );
  }

  Widget subTitleOfVerify(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).adminstrationTitleMassage,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
//  verifyEmailText(context),
  // Text verifyEmailText(BuildContext context) {
  //   return Text(
  //     S.of(context).Verifyyouremailaddress,
  //     style: Theme.of(context).textTheme.displayLarge,
  //   );
  // }
}
