// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/admin_home_screen_body.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';
import 'package:mohra_project/features/user/notification/notification.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AdminHomeScreen> {
  List<Widget> pages = [
    const AdminHomeScreenBody(),
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
          "Hello \\  Abdelhameed Ezzat",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: ColorManger.white),
        )),
        body: pages[currentIndex]);
  }
}
