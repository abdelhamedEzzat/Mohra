// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/user_name.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/admin_home_screen_body.dart';
import 'package:mohra_project/features/notification/notification_for_admin.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AdminHomeScreen> {
  List<Widget> pages = [
    const AdminHomeScreenBody(),
    const NotificationScreenForAdminAndUser(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            bottomNavigationBar: bottomNavigationForAdmin(),
            appBar: CustomAppBar(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouterName.searchScreenForAdmin);
                },
                title: const GetNameForUser()),
            body: pages[currentIndex]));
  }

  BottomNavigationBar bottomNavigationForAdmin() {
    return BottomNavigationBar(
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
        ]);
  }
}
