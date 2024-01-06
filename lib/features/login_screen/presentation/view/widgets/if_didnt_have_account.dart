import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/generated/l10n.dart';

class IfYouDidntHaveAccount extends StatelessWidget {
  const IfYouDidntHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: S.of(context).didntHaveAccount,
            style:
                TextStyle(fontSize: FontSize.s12.h, color: ColorManger.black),
          ),
          registerButtonText(context),
        ])));
  }

  WidgetSpan registerButtonText(BuildContext context) {
    return WidgetSpan(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Text(
        S.of(context).register,
        style: TextStyle(
            fontSize: FontSize.s16,
            color: ColorManger.backGroundColorToSplashScreen),
      ),
    ));
  }
}
