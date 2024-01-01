import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

class BuildTitleAndSubTitleAndImageLandScape extends StatelessWidget {
  const BuildTitleAndSubTitleAndImageLandScape({
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
        flex: 5,
        child: Container(
          decoration: BoxDecoration(
              color: colorForIntroImage,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              )),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 22.h,
                            fontWeight: FontWeightManager.black,
                            color: ColorManger.black),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: FontSize.s18.h,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManger.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
