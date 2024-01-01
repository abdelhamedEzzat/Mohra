import 'package:flutter/material.dart';
import 'package:mohra_project/core/device_type_and_orientation/orientation_widget.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/lanscape_mode/landscape_mode_Intro_screen.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/protrate_mode/portrait_mode_Intro_screen.dart';

class IntroBuildScreensWidget extends StatelessWidget {
  const IntroBuildScreensWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    // required this.onTapLeftArrow,
    required this.onTapRightArrow,
    required this.numberOfPage,
    required this.currentPage,
    required this.colorForScreen,
    required this.colorForIntroImage,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  // final void Function() onTapLeftArrow;
  final void Function() onTapRightArrow;
  final int numberOfPage;
  final int currentPage;
  final Color colorForScreen;
  final Color colorForIntroImage;
  @override
  Widget build(BuildContext context) {
    return Oriantation(
      portrait: PortraitModeIntroScreen(
          colorForIntroImage: colorForIntroImage,
          colorForScreen: colorForScreen,
          currentPage: currentPage,
          image: image,
          numberOfPage: numberOfPage,
          subTitle: subtitle,
          title: title,
          onTapRightArrow: onTapRightArrow),
      landscape: LandscapeModeIntroScreen(
          colorForIntroImage: colorForIntroImage,
          colorForScreen: colorForScreen,
          currentPage: currentPage,
          image: image,
          numberOfPage: numberOfPage,
          subTitle: subtitle,
          title: title,
          onTapRightArrow: onTapRightArrow),
    );
  }
}
