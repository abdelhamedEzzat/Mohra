import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    this.colorOfStatus,
    required this.statusText,
    this.borderRadius,
  }) : super(key: key);

  final Color? colorOfStatus;
  final String statusText;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      height: 20.h,
      decoration: BoxDecoration(
          color: colorOfStatus,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          statusText,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: ColorManger.white),
        ),
      ]),
    );
  }
}
