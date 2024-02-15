import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/generated/l10n.dart';

class LoginAccountText extends StatelessWidget {
  const LoginAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        S.of(context).loginAccount,
        style: TextStyle(
            color: ColorManger.backGroundColorToSplashScreen,
            fontSize: FontSize.s20.h,
            fontWeight: FontWeightManager.bold),
      ),
    ]);
  }
}
