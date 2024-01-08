import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class DetailsPeofileAndCompanyWidget extends StatelessWidget {
  const DetailsPeofileAndCompanyWidget({
    super.key,
    required this.key1,
    required this.value1,
    required this.key2,
    required this.value2,
    this.key3,
    this.value3,
    required this.profile,
  });
  final String profile;
  final String key1;
  final String value1;
  final String key2;
  final String value2;
  final String? key3;
  final String? value3;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        profile,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      backgroundColor: Colors.white,
      iconColor: ColorManger.black,
      leading: Icon(
        Icons.person,
        size: 24.h,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    key1,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value1,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    key2,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value2,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    key3 ?? "",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    value3 ?? "",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
