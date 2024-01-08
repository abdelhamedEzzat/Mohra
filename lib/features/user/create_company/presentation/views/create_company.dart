// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/add_Image_widget.dart';

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
