// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/routes/name_router.dart';

class HomeScreenForUserBody extends StatelessWidget {
  const HomeScreenForUserBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          Positioned(
            child: Container(
              color: ColorManger.backGroundColorToSplashScreen,
              height: MediaQuery.of(context).size.height * 0.20,
              child: const Row(
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
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Create Company To Start",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    CustomBottonWithIconOrImage(
                      onTap: () {
                        print("pla pla pla");

                        Navigator.of(context)
                            .pushNamed(RouterName.createCompany);
                      },
                      //  color: ColorManger.backGroundColorToSplashScreen,
                      nameOfButton: "Click to Create your Company",
                      width: MediaQuery.of(context).size.width * 0.75,
                    )
                  ]),
            ),
          ),
        ]),
        Expanded(
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
                    Navigator.of(context)
                        .pushNamed(RouterName.companyDocuments);
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
        )),
      ],
    );
  }
}

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key,
    this.colorOfStatus,
    this.statusText,
    required this.companyName,
    required this.logoCompany,
    required this.withStatus,
    required this.onTap,
    //  required this.onTap,
  });
  final Color? colorOfStatus;
  final String? statusText;
  final String companyName;
  final String logoCompany;
  final bool withStatus;
  final void Function()? onTap;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: withStatus == true
          ? Stack(
              children: [
                StatusWidget(
                    colorOfStatus: colorOfStatus, statusText: statusText ?? ""),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black12,
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        companyName,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: 30.h,
                      child: Image.asset(logoCompany),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              margin: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black12,
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    companyName,
                    style: Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: CircleAvatar(
                    radius: 30.h,
                    child: Image.asset(logoCompany),
                  ),
                ),
              ),
            ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    this.colorOfStatus,
    required this.statusText,
    this.borderRadius,
  }) : super(key: key);

  final Color? colorOfStatus;
  final String statusText;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 20.h,
      decoration: BoxDecoration(
          color: colorOfStatus,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(25),
              )),
      child: Center(
          child: Text(
        statusText,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: ColorManger.white),
      )),
    );
  }
}

class IconsAndTextToCompany extends StatelessWidget {
  const IconsAndTextToCompany({
    Key? key,
    required this.text,
    this.numberOfCompany,
  }) : super(key: key);
  final int? numberOfCompany;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Text(
            "${numberOfCompany ?? 0}",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: ColorManger.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ColorManger.white)),
        ],
      ),
    );
  }
}

class IconsAndTextToDoc extends StatelessWidget {
  const IconsAndTextToDoc({
    Key? key,
    required this.text,
    this.numberOfDoc,
  }) : super(key: key);
  final int? numberOfDoc;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          Text(
            "${numberOfDoc ?? 0}",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: ColorManger.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ColorManger.white)),
        ],
      ),
    );
  }
}
