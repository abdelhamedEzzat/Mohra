// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';

class DetailsDocuments extends StatelessWidget {
  const DetailsDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    var documentUploaded = ModalRoute.of(context)?.settings.arguments;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBarForUsers(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Details Documents",
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.h),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                    color: ColorManger.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$documentUploaded"),
                      )),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManger.darkGray),
                    color: ColorManger.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(children: [Text("Comment : "), Text("Comment")]),
              )
            ],
          ),
        ));
  }
}
