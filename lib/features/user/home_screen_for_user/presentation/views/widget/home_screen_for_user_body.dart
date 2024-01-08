// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/click_to_create_company.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/number_of_companies_and_documents.dart';

class HomeScreenForUserBody extends StatelessWidget {
  const HomeScreenForUserBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          NumberOfCompaniesAndDocuments(),
          ClickToCreateCampany(),
        ]),
        CompaniesListThatUserCreated(),
      ],
    );
  }
}

class CompaniesListThatUserCreated extends StatelessWidget {
  const CompaniesListThatUserCreated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 80.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Company :",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 10.h,
            ),
            CompanyButton(
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.companyDocuments);
              },
              withStatus: true,
              companyName: "CompanyName",
              logoCompany: ImageManger.mohraLogo,
              colorOfStatus: ColorManger.darkGray,
              statusText: "Waiting for Accepted",
            ),
            CompanyButton(
              onTap: () {},
              withStatus: true,
              companyName: "CompanyName",
              logoCompany: ImageManger.mohraLogo,
              colorOfStatus: ColorManger.acceptedCompanyStatus,
              statusText: " Accepted",
            ),
            CompanyButton(
              onTap: () {},
              companyName: "CompanyName",
              logoCompany: ImageManger.mohraLogo,
              colorOfStatus: ColorManger.rejectedCompanyStatus,
              statusText: "rejected",
              withStatus: true,
            ),
          ],
        ),
      ),
    ));
  }
}
