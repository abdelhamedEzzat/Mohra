// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/user_name.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/auditor_home_screen_body.dart';
import 'package:mohra_project/features/notification/notification_for_auditor.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

import 'package:mohra_project/features/user/settings_screen/settings_screen.dart';

class AuditorHomeScreen extends StatefulWidget {
  const AuditorHomeScreen({super.key});

  @override
  State<AuditorHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AuditorHomeScreen> {
  List<Widget> pages = [
    const AuditorHomeScreenBody(),
    const NotificationScreenFromAccountant(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final firstName = BlocProvider.of<AuthCubit>(context)
        .personalUserInformation
        .map((e) => e.get("first_Name"))
        .join(' , ');
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
          title: GetNameForUser(),
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
          },
          //leading: BackButton(color: Colors.white),
        ),
        body: pages[currentIndex]);
  }
}
