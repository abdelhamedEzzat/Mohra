import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width,
    required this.nameOfButton,
    required this.onTap,
  }) : super(key: key);
  final double? width;
  final String nameOfButton;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
          child: Container(
        margin: EdgeInsets.only(
          top: 4.h,
        ),
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: ColorManger.backGroundColorToSplashScreen,
            borderRadius: BorderRadius.circular(15),
            border: Border.all()),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Text(
          nameOfButton,
          style: TextStyle(color: Colors.white, fontSize: FontSize.s16.h),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
