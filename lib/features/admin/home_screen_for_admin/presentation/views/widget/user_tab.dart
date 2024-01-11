import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTabBarScreens extends StatelessWidget {
  const UsersTabBarScreens({
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
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            margin: EdgeInsets.only(top: 15.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            padding: EdgeInsets.all(8),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("email : "),
                  ],
                ),
                Row(
                  children: [
                    Text("UserName : "),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.h),
                    bottomRight: Radius.circular(10.h))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text("Accepted"),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text("Rejected"),
                    ),
                  ),
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
