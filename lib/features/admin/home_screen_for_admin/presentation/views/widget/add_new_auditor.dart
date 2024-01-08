import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/generated/l10n.dart';

import '../../../../../../core/helpers/custom_app_bar.dart';

class AddNewAuditor extends StatelessWidget {
  const AddNewAuditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: Text("New Auditor"),
          leading: BackButton(
            color: Colors.white,
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        margin: EdgeInsets.only(top: 31.h),
        child: Column(children: [
          CustomTextFormField(
              labelText: S.of(context).emailLabelTextInRegisterScreen,
              hintText: S.of(context).emailHintTextInRegisterScreen,
              prefixIcon: const Icon(Icons.email)),
          CustomTextFormField(
              labelText: S.of(context).passwordLabelTextInRegisterScreen,
              hintText: S.of(context).passwordHintTextInRegisterScreen,
              prefixIcon: const Icon(Icons.lock)),
          CustomTextFormField(
              labelText: S.of(context).nameLabelTextInRegisterScreen,
              hintText: S.of(context).nameHintTextInRegisterScreen,
              prefixIcon: const Icon(Icons.person)),
          CustomButton(nameOfButton: "Create Account", onTap: () {})
        ]),
      ),
    );
  }
}
