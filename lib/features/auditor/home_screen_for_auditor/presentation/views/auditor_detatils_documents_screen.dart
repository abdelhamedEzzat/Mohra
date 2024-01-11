import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/comment.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/data_from_accountant.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';

class AuditorDocumentDetails extends StatefulWidget {
  const AuditorDocumentDetails({super.key});

  @override
  State<AuditorDocumentDetails> createState() =>
      _AccountantDocumentDetailsState();
}

class _AccountantDocumentDetailsState extends State<AuditorDocumentDetails> {
  List<String> stutsDocumentDropDown = [
    "new",
    "registered",
    "Auditor",
    "ready",
    "re",
    "redundant",
    "Canceled",
  ];

  String? selectItem;

  List<String> typeDocumentDropDown = [];
  String? selectTypeItem;
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Details Documents",
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                const TitleOfFormCreateCompany(
                    titleText: "Upload From User : "),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        ImageManger.decument,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CommentWidget(),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const TitleOfFormCreateCompany(
                    titleText: "Upload From Accountatnt : "),
                SizedBox(
                  height: 10.h,
                ),
                const DataFromAccountant(
                  constansType: "Company name : ",
                  writeForAccountant: "Company Name",
                ),
                SizedBox(
                  height: 15.h,
                ),
                SelectStatusOfDocument(context),
                SizedBox(
                  height: 15.h,
                ),
                const TitleOfFormCreateCompany(titleText: "Comments"),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hight: mediaQueryHeight * 0.10,
                  hintText: "Add any Comment Here",
                  prefixIcon: const Icon(Icons.comment),
                ),
                CustomButton(nameOfButton: "Submitted", onTap: () {}),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ));
  }

  Container SelectStatusOfDocument(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(15.h),
          border: Border.all(color: ColorManger.darkGray)),
      child: DropdownButton<String>(
        hint: Text(
          "Select Status Of Document",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: ColorManger.backGroundColorToSplashScreen),
        ),
        borderRadius: BorderRadius.circular(10),
        isExpanded: true,
        value: selectItem,
        items: stutsDocumentDropDown
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.displayMedium,
                )))
            .toList(),
        onChanged: (item) => setState(() {
          selectItem = item!;
        }),
      ),
    );
  }
}
