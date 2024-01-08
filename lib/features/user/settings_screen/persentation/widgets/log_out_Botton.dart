import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogOutBotton extends StatelessWidget {
  const LogOutBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: ListTile(
        leading: Icon(Icons.logout, size: 24.h),
        title: Text(
          "LogOut",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    ));
  }
}
