import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/company_botton.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class AllCampanyWithStatus extends StatelessWidget {
  const AllCampanyWithStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.acceptedCompanyStatus,
                  statusText: "Accepted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.rejectedCompanyStatus,
                  statusText: "Rejcted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: CompanyButton(
                  colorOfStatus: ColorManger.darkGray,
                  statusText: "Wating to Accepted",
                  companyName: "companyName",
                  logoCompany: ImageManger.mohraLogo,
                  withStatus: true,
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanysTabBarScreen extends StatefulWidget {
  const CompanysTabBarScreen({
    super.key,
  });

  @override
  State<CompanysTabBarScreen> createState() => _CompanysTabBarScreenState();
}

class _CompanysTabBarScreenState extends State<CompanysTabBarScreen> {
  List<String> filterCompanyDropDown = [
    "Accepted",
    "Rojected",
    "Waiting",
  ];

  String? selectItem;
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: ColorManger.darkGray.withOpacity(0.5),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 15.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconsAndTextToCompany(
                  text: "Companies",
                  color: Colors.black,
                ),
                IconsAndTextToDoc(
                  color: Colors.black,
                  text: "Documents",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: ColorManger.white,
                borderRadius: BorderRadius.circular(15.h),
                border: Border.all(color: ColorManger.darkGray)),
            child: DropdownButton<String>(
              hint: Text(
                "Choose Filter",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
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
          const AllCampanyWithStatus(),
        ]));
  }
}
