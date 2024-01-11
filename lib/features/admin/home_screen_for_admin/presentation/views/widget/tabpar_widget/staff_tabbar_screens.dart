import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffTabBARScreens extends StatelessWidget {
  const StaffTabBARScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      margin: EdgeInsets.only(top: 31.h),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            //  padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.h),
                            topRight: Radius.circular(10.h))),
                    child: Center(
                      child: Text(
                        "Accountant",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.h),
                    bottomRight: Radius.circular(10.h))),
            // margin: EdgeInsets.only(top: 15.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.10,
            padding: const EdgeInsets.all(8),
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
        ]),
      ),
    );
  }
}
