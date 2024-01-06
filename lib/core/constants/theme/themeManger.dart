import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: "Kanit",
      textTheme: TextTheme(
          //
          // for bold Title in our app
          //
          displayLarge: TextStyle(
            fontWeight: FontWeightManager.semibold,
            fontSize: FontSize.s17.h,
          ),
          //
          // for bold regular title and subtitle in our app
          //
          displayMedium: TextStyle(
            fontSize: FontSize.s15.h,
            fontWeight: FontWeightManager.regular,
          ),
          //
          //for small text
          //
          displaySmall: TextStyle(
            fontSize: FontSize.s14.h,
            fontWeight: FontWeightManager.regular,
          ),
          bodySmall: TextStyle(
            fontSize: FontSize.s12.h,
            fontWeight: FontWeightManager.regular,
          ),
          headlineMedium: const TextStyle(
            fontWeight: FontWeightManager.semibold,
          )),
      scaffoldBackgroundColor: ColorManger.introScreenBackgroundColor);
}
