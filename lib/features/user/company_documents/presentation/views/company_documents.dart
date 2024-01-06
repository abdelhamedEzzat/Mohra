// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class CompanyDocuments extends StatelessWidget {
  const CompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Company Documents",
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DetailsPeofileAndCompanyWidget(
                  profile: "Company Details",
                  key1: "Name :",
                  value1: "Company Name",
                  key2: "Address :",
                  value2: "Company Address ",
                  key3: "Type :",
                  value3: "Company Type ",
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.uploadDocuments);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.h)),
                    height: mediaQueryHeight * 0.15,
                    child: Row(
                      children: [
                        Expanded(
                            child: Icon(
                          Icons.edit_document,
                          size: 55.h,
                        )),
                        Expanded(
                            child: Text(
                          "Upload Document",
                          style: Theme.of(context).textTheme.displayLarge,
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Document :",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                DocumentImageAndNumberAfterUpload(
                    color: ColorManger.darkGray,
                    status: "Waiting for the accountant's review"),
                DocumentImageAndNumberAfterUpload(
                    color: ColorManger.acceptedCompanyStatus,
                    status: "accepted"),
              ],
            ),
          ),
        ));
  }
}

class DocumentImageAndNumberAfterUpload extends StatelessWidget {
  const DocumentImageAndNumberAfterUpload({
    Key? key,
    required this.color,
    required this.status,
  }) : super(key: key);
  final Color color;
  final String status;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouterName.detailsDocuments);
      },
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: ColorManger.black,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      status,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(25)),
                              child: Image.asset(
                                ImageManger.decument,
                                fit: BoxFit.fill,
                              ),
                            )),
                        Expanded(
                            child: CircleAvatar(
                          radius: 25,
                          child: Text(
                            "1",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
// / StatusWidget

class AddCompanyLogoWidget extends StatelessWidget {
  const AddCompanyLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        const TitleOfFormCreateCompany(titleText: "Add Logo"),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManger.darkGray),
                borderRadius: BorderRadius.circular(25),
                color: ColorManger.white,
              ),
              margin: EdgeInsets.only(top: 10),
              width: mediaQueryWidth,
              height: mediaQueryHeight * 0.20,
              child: Center(
                  child: Icon(
                Icons.add_photo_alternate_rounded,
                color: ColorManger.darkGray,
                size: 80.h,
              ))),
        ),
      ],
    );
  }
}

class TitleOfFormCreateCompany extends StatelessWidget {
  const TitleOfFormCreateCompany({
    super.key,
    required this.titleText,
  });
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: ColorManger.backGroundColorToSplashScreen),
      ),
    );
  }
}
