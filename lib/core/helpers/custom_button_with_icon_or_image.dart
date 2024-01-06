// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class CustomBottonWithIconOrImage extends StatelessWidget {
  const CustomBottonWithIconOrImage({
    Key? key,
    this.width,
    required this.nameOfButton,
    this.imageIconButton,
    required this.onTap,
    this.icon,
    this.color,
  }) : super(key: key);
  final double? width;
  final String nameOfButton;
  final String? imageIconButton;
  final void Function() onTap;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: color ?? ColorManger.black,
            borderRadius: BorderRadius.circular(15),
            border: Border.all()),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageIconButton != null)
              Image.asset(imageIconButton!,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 25),
            if (icon != null)
              Icon(
                icon!,
              ),
            const SizedBox(
              width: 15,
            ),
            Text(
              nameOfButton,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ColorManger.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
