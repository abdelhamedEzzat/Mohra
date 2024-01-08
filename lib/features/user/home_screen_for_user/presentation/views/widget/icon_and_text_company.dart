import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class IconsAndTextToCompany extends StatelessWidget {
  const IconsAndTextToCompany({
    Key? key,
    required this.text,
    this.numberOfCompany,
    this.color,
  }) : super(key: key);
  final int? numberOfCompany;
  final Color? color;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Text(
            "${numberOfCompany ?? 0}",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: color ?? ColorManger.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: color ?? ColorManger.white)),
        ],
      ),
    );
  }
}

class IconsAndTextToDoc extends StatelessWidget {
  const IconsAndTextToDoc({
    Key? key,
    required this.text,
    this.numberOfDoc,
    this.color,
  }) : super(key: key);
  final int? numberOfDoc;
  final Color? color;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Text(
            "${numberOfDoc ?? 0}",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: color ?? ColorManger.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: color ?? ColorManger.white)),
        ],
      ),
    );
  }
}
