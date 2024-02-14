import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

class ClickToCreateCampany extends StatelessWidget {
  const ClickToCreateCampany({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        color: ColorManger.introScreenBackgroundColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      height: 120.h,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          S.of(context).CreateCompanyToStart,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        CustomBottonWithIconOrImage(
          color: ColorManger.backGroundColorToSplashScreen,
          onTap: () {
            print("pla pla pla");

            Navigator.of(context).pushNamed(RouterName.createCompany);
          },
          nameOfButton: S.of(context).CreateCompany,
          width: MediaQuery.of(context).size.width * 0.75,
        )
      ]),
    );
  }
}
