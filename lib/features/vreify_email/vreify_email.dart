import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/glass_screen_for_login_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/gradiant_list.dart';
import 'package:mohra_project/generated/l10n.dart';

class VreifyEmail extends StatelessWidget {
  const VreifyEmail({super.key});

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
                Positioned(child: VreifyEmailBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VreifyEmailBody extends StatelessWidget {
  const VreifyEmailBody({super.key});

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
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              verifyEmailText(context),
                              subTitleOfVerify(context),
                              CustomButton(
                                  nameOfButton:
                                      S.of(context).ContinueAfterSendVerify,
                                  onTap: () async {
                                    await FirebaseAuth.instance.currentUser
                                        ?.reload();
                                    if (FirebaseAuth
                                        .instance.currentUser!.emailVerified) {
                                      Constanscollection.userCollection.update({
                                        'status': '1',
                                      });
                                      // ignore: use_build_context_synchronously
                                      await Navigator.of(context)
                                          .pushReplacementNamed(
                                        RouterName.registerScreen,
                                      );
                                    }
                                  }),
                              const GoToLoginTextBotton()
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

  Text subTitleOfVerify(BuildContext context) {
    return Text(
      S.of(context).SubTitleVerify,
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }

  Text verifyEmailText(BuildContext context) {
    return Text(
      S.of(context).Verifyyouremailaddress,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class GoToLoginTextBotton extends StatelessWidget {
  const GoToLoginTextBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(RouterName.registerScreen);
      },
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: "Go to Back",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: ColorManger.backGroundColorToSplashScreen)),
        WidgetSpan(
            child: Icon(Icons.arrow_right_alt,
                color: ColorManger.backGroundColorToSplashScreen)),
      ])),
    );
  }
}
