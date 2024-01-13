import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hight,
    this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.fontStyle,
    this.onChanged,
    this.controller,
    this.validator,
  });
  final double? hight;
  final String? labelText;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType? keyboardType;
  final FontStyle? fontStyle;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.w, bottom: 8.w),
      child: SizedBox(
        // height: hight?.h ?? 52.h,
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            cursorColor: ColorManger.backGroundColorToSplashScreen,
            decoration: InputDecoration(
                errorMaxLines: 2,
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: ColorManger.backGroundColorToSplashScreen)),
                labelText: labelText,
                hintText: hintText,
                prefixIcon: prefixIcon,
                hintStyle: TextStyle(
                    color: ColorManger.darkGray, fontSize: FontSize.s14.h),
                labelStyle: TextStyle(
                    fontStyle: fontStyle ?? FontStyle.italic,
                    fontSize: FontSize.s15.w,
                    color: ColorManger.backGroundColorToSplashScreen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: ColorManger.darkGray)))),
      ),
    );
  }
}
