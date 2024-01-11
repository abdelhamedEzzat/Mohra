// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/add_Image_widget.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Upload Documents",
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: Column(
            children: [
              AddImageWidget(
                height: mediaQueryHeight * 0.30,
                title: "Upload Documents",
                icon: Icons.document_scanner,
              ),
              SizedBox(
                height: 15.h,
              ),
              const TitleOfFormCreateCompany(titleText: "Comments"),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hight: mediaQueryHeight * 0.20,
                  hintText: "Add any Comment Here",
                  prefixIcon: const Icon(Icons.comment),
                ),
              )
            ],
          ),
        ));
  }
}
