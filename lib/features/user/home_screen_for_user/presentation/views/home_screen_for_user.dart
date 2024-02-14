// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/user_name.dart';
import 'package:mohra_project/features/notification/notification_for_admin.dart';
import 'package:mohra_project/features/notification/notification_for_user.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/home_screen_for_user_body.dart';
import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';
import 'package:mohra_project/generated/l10n.dart';

class HomeScreenForUser extends StatefulWidget {
  const HomeScreenForUser({super.key});

  @override
  State<HomeScreenForUser> createState() => _HomeScreenForUserState();
}

class _HomeScreenForUserState extends State<HomeScreenForUser> {
  List<Widget> pages = [
    const HomeScreenForUserBody(),
    const NotificationScreenForUser(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // String firstName = BlocProvider.of<SignupCubit>(context).getFirstName();

    return Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        appBar: CustomAppBarForUsers(title: GetNameForUser()),
        body: pages[currentIndex]);
  }

  BottomNavigationBar bottomNavigationBar() {
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
            label: S.of(context).Home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_add,
              color: ColorManger.backGroundColorToSplashScreen,
            ),
            label: S.of(context).Notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: ColorManger.backGroundColorToSplashScreen,
            ),
            label: S.of(context).Settings,
          ),
        ]);
  }
}
