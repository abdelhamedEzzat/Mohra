import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.height,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        TitleOfFormCreateCompany(titleText: title),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManger.darkGray),
                borderRadius: BorderRadius.circular(25),
                color: ColorManger.white,
              ),
              margin: const EdgeInsets.only(top: 10),
              width: mediaQueryWidth,
              height: height ?? mediaQueryHeight * 0.20,
              child: Center(
                  child: Icon(
                icon,
                color: ColorManger.darkGray,
                size: 80.h,
              ))),
        ),
      ],
    );
  }
}
