import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';

class ManageAssignment extends StatefulWidget {
  const ManageAssignment({super.key});

  @override
  State<ManageAssignment> createState() => _ManageAssignmentState();
}

class _ManageAssignmentState extends State<ManageAssignment> {
  List<String> filterCompanyDropDown = [
    "Accountant",
    "Auditor",
  ];

  String? selectItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          "Assignment",
        ),
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        margin: EdgeInsets.only(top: 15.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              decoration: BoxDecoration(
                  color: ColorManger.white,
                  borderRadius: BorderRadius.circular(15.h),
                  border: Border.all(color: ColorManger.darkGray)),
              child: DropdownButton<String>(
                hint: Text(
                  "Select Type",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorManger.backGroundColorToSplashScreen),
                ),
                borderRadius: BorderRadius.circular(10),
                isExpanded: true,
                value: selectItem,
                items: filterCompanyDropDown
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
              height: 10.h,
            ),
            const CustomTextFormField(
              hintText: "Write Email",
              prefixIcon: Icon(Icons.email),
              labelText: "email",
            ),
            SizedBox(
              height: 5.h,
            ),
            const CustomTextFormField(
              hintText: "Company Name",
              prefixIcon: Icon(Icons.add_business),
              labelText: "Search For Company",
            ),
            SizedBox(
              height: 10.h,
            ),
            CompanyButton(
                colorOfStatus: ColorManger.acceptedCompanyStatus,
                statusText: "Accepted",
                companyName: "companyName",
                logoCompany: ImageManger.mohraLogo,
                withStatus: false,
                onTap: () {}),
            CompanyButton(
                colorOfStatus: ColorManger.acceptedCompanyStatus,
                statusText: "Accepted",
                companyName: "companyName",
                logoCompany: ImageManger.mohraLogo,
                withStatus: false,
                onTap: () {}),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(nameOfButton: "submitted", onTap: () {})
          ],
        ),
      ),
    );
  }
}
