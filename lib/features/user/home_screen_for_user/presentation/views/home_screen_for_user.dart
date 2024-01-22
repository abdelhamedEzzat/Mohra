// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/home_screen_for_user_body.dart';
import 'package:mohra_project/features/user/notification/persrntation/views/notification.dart';
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
    // String firstName = BlocProvider.of<SignupCubit>(context).getFirstName();

    return Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        appBar: CustomAppBar(title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final firstName = BlocProvider.of<AuthCubit>(context)
                .personalUserInformation
                .map((e) => e.get("first_Name"))
                .join(' , ');

            return Text(
              " Hello : $firstName ",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ColorManger.white),
            );
          },
        )),
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
