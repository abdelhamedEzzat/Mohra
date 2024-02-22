import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/intro_screens/presentation/widgets/protrate_mode/build_title_and_subtitle_for_intro_screen.dart';
import 'package:mohra_project/generated/l10n.dart';

class BuIldBottonforAllIntroScreens extends StatelessWidget {
  const BuIldBottonforAllIntroScreens({
    super.key,
    required this.currentPage,
    required this.numberOfPage,
    required this.onTapRightArrow,
  });

  final int currentPage;
  final int numberOfPage;
  final void Function()? onTapRightArrow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: currentPage != 2
            ? buildSecundAndFirstIntroIconButton(context)
            : buIldThirdIntroScreenButton(context));
  }

//
//botton For first and secound intro screens
//
  Widget buildSecundAndFirstIntroIconButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int index = 0; index < numberOfPage - 1; index++)
            createSolidIconAndEmbtyIcon((index == currentPage) ? true : false),
          const Spacer(),
          MaterialButton(
              onPressed: onTapRightArrow,
              child: currentPage == 2
                  ? null
                  : Container(
                      decoration: BoxDecoration(
                          color: ColorManger.introScreenBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 100.w,
                      height: 40.h,
                      child: Center(
                          child: Text(
                        S.of(context).buttonNameFirstAndSecoundIntroScreen,
                        style: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s16.h,
                            fontWeight: FontWeightManager.bold),
                      )),
                    )),
        ],
      ),
    );
  }

//
//botton For first and secound intro screens
//
  GestureDetector buIldThirdIntroScreenButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(RouterName.registerScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          color: ColorManger.introScreenBackgroundColor,
        ),
        margin: const EdgeInsets.only(
          top: 15,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            S.of(context).buttonNameThirdIntroScreen,
            style: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16.h,
                fontWeight: FontWeightManager.bold),
          ),
        ),
      ),
    );
  }
}
