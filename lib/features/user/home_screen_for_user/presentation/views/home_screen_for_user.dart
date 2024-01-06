// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/home_screen_for_user_body.dart';
import 'package:mohra_project/features/user/notification/notification.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class HomeScreenForUser extends StatefulWidget {
  const HomeScreenForUser({super.key});

  @override
  State<HomeScreenForUser> createState() => _HomeScreenForUserState();
}

class _HomeScreenForUserState extends State<HomeScreenForUser> {
  List<Widget> pages = [
    const HomeScreenForUserBody(),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
  });
  final Widget title;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 70.h,
        surfaceTintColor: ColorManger.backGroundColorToSplashScreen,
        title: title,
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white),
        leading: leading,
        iconTheme: IconThemeData(size: 18.h),
        elevation: 0,
        backgroundColor: ColorManger.appbarColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: ColorManger.white,
                ),
                onPressed: () {}),
          ),
        ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
