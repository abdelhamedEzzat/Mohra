// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/accountant_home_screen_body.dart';

import 'package:mohra_project/features/user/notification/persrntation/views/notification.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class AccountantHomeScreen extends StatefulWidget {
  const AccountantHomeScreen({super.key});

  @override
  State<AccountantHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AccountantHomeScreen> {
  List<Widget> pages = [
    const AccountantHomeScreenBody(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            unselectedIconTheme: IconThemeData(size: 20.h),
            selectedIconTheme: IconThemeData(size: 24.h),
            selectedLabelStyle: TextStyle(
              fontSize: 14.h,
            ),
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            fixedColor: ColorManger.backGroundColorToSplashScreen,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: ColorManger.backGroundColorToSplashScreen,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notification_add,
                  color: ColorManger.backGroundColorToSplashScreen,
                ),
                label: "Notification",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: ColorManger.backGroundColorToSplashScreen,
                ),
                label: "Settings",
              ),
            ]),
        appBar: CustomAppBar(
            title: Text(
          "Hello : Mr Mohmed",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: ColorManger.white),
        )),
        body: pages[currentIndex]);
  }
}
