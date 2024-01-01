import 'package:flutter/material.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/BuIld_botton_for_all_Intro_screens.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/protrate_mode/build_title_and_subtitle_for_intro_screen.dart';

class PortraitModeIntroScreen extends StatelessWidget {
  const PortraitModeIntroScreen(
      {super.key,
      required this.colorForScreen,
      required this.colorForIntroImage,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.currentPage,
      required this.numberOfPage,
      this.onTapRightArrow});
  final Color colorForScreen;
  final Color colorForIntroImage;
  final String image;
  final String title;
  final String subTitle;
  final int currentPage;
  final int numberOfPage;
  final void Function()? onTapRightArrow;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorForScreen,
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildTitleAndSubTitleAndImage(
                colorForIntroImage: colorForIntroImage,
                image: image,
                title: title,
                subTitle: subTitle),
            BuIldBottonforAllIntroScreens(
                currentPage: currentPage,
                numberOfPage: numberOfPage,
                onTapRightArrow: onTapRightArrow)
          ]),
    );
  }
}
