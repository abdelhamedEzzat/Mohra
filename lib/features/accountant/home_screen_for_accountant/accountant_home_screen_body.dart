import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AccountantHomeScreenBody extends StatelessWidget {
  const AccountantHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: ColorManger.backGroundColorToSplashScreen,
          height: MediaQuery.of(context).size.height * 0.15,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconsAndTextToCompany(
                    text: "Companies",
                  ),
                  IconsAndTextToDoc(
                    text: "Documents",
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            margin: EdgeInsets.only(top: 20.h),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My available companies :",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                CompanyButton(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouterName.accuntantCompanyDocuments);
                  },
                  withStatus: false,
                  companyName: "Company Name",
                  logoCompany: ImageManger.mohraLogo,
                )
              ],
            )),
          ),
        )
      ],
    );
  }
}
