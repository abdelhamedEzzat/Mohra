import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class DataFromAccountant extends StatelessWidget {
  const DataFromAccountant({
    super.key,
    required this.constansType,
    required this.writeForAccountant,
  });

  final String constansType;
  final String writeForAccountant;

  @override
  Widget build(BuildContext context) {
    // final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorManger.darkGray),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.h))),
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w),
      width: mediaQueryWidth,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                constansType,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              Text(
                writeForAccountant,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                constansType,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              Text(
                writeForAccountant,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                constansType,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              Text(
                writeForAccountant,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                constansType,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              Text(
                writeForAccountant,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                constansType,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManger.backGroundColorToSplashScreen),
              ),
              Text(
                writeForAccountant,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
