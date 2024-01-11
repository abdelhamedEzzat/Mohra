import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';

class AccountantDocumentDetails extends StatefulWidget {
  const AccountantDocumentDetails({super.key});

  @override
  State<AccountantDocumentDetails> createState() =>
      _AccountantDocumentDetailsState();
}

class _AccountantDocumentDetailsState extends State<AccountantDocumentDetails> {
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
                Container(
                  padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Text(
                      "Comment : ",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text("Comment",
                        style: Theme.of(context).textTheme.displayMedium)
                  ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CustomTextFormField(
                  fontStyle: FontStyle.normal,
                  hintText: "Write Company name",
                  labelText: "Company name",
                  prefixIcon: Icon(Icons.home_work),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CustomTextFormField(
                  fontStyle: FontStyle.normal,
                  labelText: "Invoice date",
                  hintText: "Type Invoice date",
                  prefixIcon: Icon(Icons.date_range),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CustomTextFormField(
                  fontStyle: FontStyle.normal,
                  labelText: "invoice number",
                  hintText: "Type invoice number",
                  prefixIcon: Icon(Icons.numbers),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const CustomTextFormField(
                  fontStyle: FontStyle.normal,
                  labelText: "Amount of the invoice",
                  hintText: "Type Amount of the invoice",
                  prefixIcon: Icon(Icons.price_check),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: ColorManger.white,
                      borderRadius: BorderRadius.circular(15.w),
                      border: Border.all(color: ColorManger.darkGray)),
                  child: DropdownButton<String>(
                    hint: Text(
                      "Select Type Of Document",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: ColorManger.backGroundColorToSplashScreen),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    value: selectTypeItem,
                    items: typeDocumentDropDown
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.displayMedium,
                            )))
                        .toList(),
                    onChanged: (item) => setState(() {
                      selectTypeItem = item!;
                    }),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
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
                          .copyWith(
                              color: ColorManger.backGroundColorToSplashScreen),
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
                ),
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
}
