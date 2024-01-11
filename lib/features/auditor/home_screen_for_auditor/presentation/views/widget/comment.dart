import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: ColorManger.darkGray),
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Text(
          "Comment : ",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text("Comment", style: Theme.of(context).textTheme.displayMedium)
      ]),
    );
  }
}
