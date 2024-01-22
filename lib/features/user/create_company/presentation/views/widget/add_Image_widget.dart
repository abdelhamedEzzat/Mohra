import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    Key? key,
    this.height,
    this.ontap,
    required this.image,
  }) : super(key: key);

  final double? height;
  final void Function()? ontap;
  final Widget image;
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
            onTap: ontap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManger.darkGray),
                borderRadius: BorderRadius.circular(25),
                color: ColorManger.white,
              ),
              margin: const EdgeInsets.only(top: 10),
              width: mediaQueryWidth,
              height: height ?? mediaQueryHeight * 0.20,
              child: image,
            ))
      ],
    );
  }
}

// class TitleOfFormCreateCompany extends StatelessWidget {
//   const TitleOfFormCreateCompany({
//     super.key,
//     required this.titleText,
//   });
//   final String titleText;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         titleText,
//         style: Theme.of(context)
//             .textTheme
//             .displayLarge!
//             .copyWith(color: ColorManger.backGroundColorToSplashScreen),
//       ),
//     );
//   }
// }
