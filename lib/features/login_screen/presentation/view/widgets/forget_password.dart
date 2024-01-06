import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/generated/l10n.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 10, bottom: 8),
        alignment: Alignment.centerRight,
        child: Text.rich(WidgetSpan(
            child: GestureDetector(
          child: Text(
            S.of(context).forgetPassword,
            style: TextStyle(
                fontSize: FontSize.s12.h,
                color: ColorManger.backGroundColorToSplashScreen),
          ),
        ))));
  }
}
