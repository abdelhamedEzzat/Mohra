// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/lanscape_mode/introScreenWidget.dart';
import 'package:mohra_project/generated/l10n.dart';

class IntroScreenWidget extends StatefulWidget {
  const IntroScreenWidget({super.key});

  @override
  State<IntroScreenWidget> createState() => _IntroScreenForMobileState();
}

PageController pageController = PageController();

class _IntroScreenForMobileState extends State<IntroScreenWidget> {
  @override
  void initState() {
    super.initState();
    // ignore: unused_element
    void dispose() {
      pageController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      //   physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        IntroBuildScreensWidget(
          image: ImageManger.splashScreen1,
          title: S.of(context).titleForFirstIntroScreen,
          subtitle: S.of(context).subtitleForFirstIntroScreen,
          currentPage: 0,
          numberOfPage: 3,
          onTapRightArrow: () {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          colorForScreen: ColorManger.backGroundColorToSplashScreen,
          colorForIntroImage: ColorManger.introScreenBackgroundColor,
        ),
        IntroBuildScreensWidget(
          image: ImageManger.splashScreen2,
          title: S.of(context).titleForSecondIntroScreen,
          subtitle: S.of(context).subtitleForSecondIntroScreen,
          currentPage: 1,
          numberOfPage: 3,
          onTapRightArrow: () {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          colorForScreen: ColorManger.backGroundColorToSplashScreen,
          colorForIntroImage: ColorManger.introScreenBackgroundColor,
        ),
        IntroBuildScreensWidget(
          image: ImageManger.splashScreen3,
          title: S.of(context).titleForThirdIntroScreen,
          subtitle: S.of(context).subtitleForThirdIntroScreen,
          currentPage: 2,
          numberOfPage: 3,
          onTapRightArrow: () {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          colorForScreen: ColorManger.backGroundColorToSplashScreen,
          colorForIntroImage: ColorManger.introScreenBackgroundColor,
        ),
      ],
    );
  }
}
