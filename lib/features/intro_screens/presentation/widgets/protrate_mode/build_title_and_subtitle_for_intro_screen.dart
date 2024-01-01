import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

class BuildTitleAndSubTitleAndImage extends StatelessWidget {
  const BuildTitleAndSubTitleAndImage({
    super.key,
    required this.colorForIntroImage,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final Color colorForIntroImage;
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Container(
          decoration: BoxDecoration(
              color: colorForIntroImage,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              )),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 24.w,
                          fontWeight: FontWeightManager.black,
                          color: ColorManger.black),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                          fontSize: FontSize.s16.h,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManger.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

createSolidIconAndEmbtyIcon(bool isActiveScreen) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: isActiveScreen ? 15.w : 10.w,
      height: isActiveScreen ? 15.w : 10.w,
      decoration: BoxDecoration(
          color: isActiveScreen ? Colors.white : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    ),
  );
}
