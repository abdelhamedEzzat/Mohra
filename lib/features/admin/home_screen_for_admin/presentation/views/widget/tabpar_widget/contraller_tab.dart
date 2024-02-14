import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

class ContrallerTabBarScreen extends StatelessWidget {
  const ContrallerTabBarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(top: 15.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer: ColorManger.darkGray.withOpacity(0.9),
              buttonTitle: S.of(context).AddNewAccountatnt,
              icon1: Icons.person,
              icon2: Icons.money,
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.addNewAccountant);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer: ColorManger.bottonColor.withOpacity(0.6),
              buttonTitle: S.of(context).AddNewAuditor,
              icon1: Icons.person,
              icon2: Icons.search,
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.addNewAuditor);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            ContrallBottonInAdminHomeScreen(
              colorToButtonContainer:
                  ColorManger.rejectedCompanyStatus.withOpacity(0.7),
              buttonTitle: S.of(context).ManageAssignment,
              icon1: Icons.person,
              icon2: Icons.assignment_add,
              onTap: () {
                Navigator.of(context).pushNamed(RouterName.manageAssignment);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}

//
//
class ContrallBottonInAdminHomeScreen extends StatelessWidget {
  const ContrallBottonInAdminHomeScreen({
    super.key,
    required this.buttonTitle,
    this.onTap,
    this.icon1,
    this.icon2,
    required this.colorToButtonContainer,
  });
  final String buttonTitle;
  final void Function()? onTap;
  final IconData? icon1;
  final IconData? icon2;
  final Color colorToButtonContainer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5.w),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
            color: colorToButtonContainer,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon1,
                  size: 45,
                  // color: ColorManger.white,
                ),
                Icon(
                  icon2,
                  size: 45,
                  //color: ColorManger.white,
                ),
              ],
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                flex: 2,
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ColorManger.black,
                      ),
                )),
          ],
        ),
      ),
    );
  }
}
