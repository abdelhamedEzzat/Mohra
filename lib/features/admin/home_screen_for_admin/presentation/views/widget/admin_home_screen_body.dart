import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/tabpar_widget/company_tab.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/tabpar_widget/contraller_tab.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/tabpar_widget/staff_tabbar_screens.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/tabpar_widget/user_tab.dart';
import 'package:mohra_project/generated/l10n.dart';

class AdminHomeScreenBody extends StatelessWidget {
  const AdminHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                labelColor: ColorManger.backGroundColorToSplashScreen,
                indicatorColor: ColorManger.black,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.pest_control_outlined,
                    ),
                    child: Text(S.of(context).Controller,
                        style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.add_business),
                    child: Text(S.of(context).Companys,
                        style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.person),
                    child: Text(S.of(context).Users,
                        style: TextStyle(fontSize: 12.h)),
                  ),
                  Tab(
                    icon: const Icon(Icons.person_2_sharp),
                    child: Text(S.of(context).Staff,
                        style: TextStyle(fontSize: 12.h)),
                  ),
                ]),
          ],
        ),
        const Expanded(
          child: TabBarView(children: [
            ContrallerTabBarScreen(),
            CompanysTabBarScreen(),
            UsersTabBarScreens(),
            StaffTabBARScreens(),
          ]),
        )
      ],
    );
  }
}





///

