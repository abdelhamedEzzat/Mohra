// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';

class CreateCompany extends StatelessWidget {
  const CreateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          "Create Company",
        ),
      ),
      body: Container(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddImageWidget(
                title: "Add Logo",
                icon: Icons.add_photo_alternate_rounded,
              ),
              SizedBox(
                height: 15.h,
              ),
              const TitleOfFormCreateCompany(
                titleText: "Company Name",
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                  hintText: "Write Your Company Name",
                  prefixIcon: Icon(
                    Icons.post_add_rounded,
                    size: 25.h,
                  )),
              //
              //
              SizedBox(
                height: 10.h,
              ),
              const TitleOfFormCreateCompany(
                titleText: "Company Adrdress",
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                  hintText: "Write  Your Company Address",
                  prefixIcon: Icon(
                    Icons.location_searching,
                    size: 25.h,
                  )),
              //
              //
              SizedBox(
                height: 10.h,
              ),
              const TitleOfFormCreateCompany(
                titleText: " Company Type",
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextFormField(
                  hintText: "Write  Your Company Type",
                  prefixIcon: Icon(
                    Icons.today_rounded,
                    size: 25.h,
                  )),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(nameOfButton: "Submit", onTap: () {}),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
              margin: EdgeInsets.only(top: 10),
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

class TitleOfFormCreateCompany extends StatelessWidget {
  const TitleOfFormCreateCompany({
    super.key,
    required this.titleText,
  });
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: ColorManger.backGroundColorToSplashScreen),
      ),
    );
  }
}
