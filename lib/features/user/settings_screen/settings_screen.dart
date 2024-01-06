import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DetailsPeofileAndCompanyWidget(
            profile: "Profile",
            key1: "Name :",
            value1: "Abdelhameed Ezzat ",
            key2: "Email :",
            value2: "amAbdo@gmail.com ",
          ),
          // SizedBox(
          //   height: 10,
          // ),
          ExpansionTile(
            title: Text(
              "Language",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            backgroundColor: Colors.white,
            iconColor: ColorManger.black,
            leading: Icon(
              Icons.language,
              size: 24.h,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomButton(
                              onTap: () {},
                              nameOfButton: "Arabic",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: CustomButton(
                                onTap: () {},
                                nameOfButton: "English",
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              child: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: ListTile(
              leading: Icon(Icons.logout, size: 24.h),
              title: Text(
                "LogOut",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ))
        ]),
      ),
    );
  }
}

class DetailsPeofileAndCompanyWidget extends StatelessWidget {
  const DetailsPeofileAndCompanyWidget({
    super.key,
    required this.key1,
    required this.value1,
    required this.key2,
    required this.value2,
    this.key3,
    this.value3,
    required this.profile,
  });
  final String profile;
  final String key1;
  final String value1;
  final String key2;
  final String value2;
  final String? key3;
  final String? value3;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        profile,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      backgroundColor: Colors.white,
      iconColor: ColorManger.black,
      leading: Icon(
        Icons.person,
        size: 24.h,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    key1,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value1,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    key2,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value2,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    key3 ?? "",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value3 ?? "",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
