import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadDocumentsBotton extends StatelessWidget {
  const UploadDocumentsBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.h)),
      height: mediaQueryHeight * 0.15,
      child: Row(
        children: [
          Expanded(
              child: Icon(
            Icons.edit_document,
            size: 55.h,
          )),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              "Upload Document",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )),
        ],
      ),
    );
  }
}
