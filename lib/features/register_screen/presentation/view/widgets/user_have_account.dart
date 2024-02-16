import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

class UserIfAlreadyHaveAccount extends StatelessWidget {
  const UserIfAlreadyHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).AlreadyHaveAccount,
              style:
                  TextStyle(fontSize: FontSize.s12.w, color: ColorManger.black),
            ),
            SizedBox(
              width: 3.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RouterName.loginScreen);
              },
              child: Text(
                S.of(context).Login,
                style: TextStyle(
                    fontSize: FontSize.s14.h,
                    color: ColorManger.backGroundColorToSplashScreen),
              ),
            )
          ],
        ));
  }
}
