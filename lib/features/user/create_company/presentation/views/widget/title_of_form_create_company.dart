import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';

class TitleOfFormCreateCompany extends StatelessWidget {
  const TitleOfFormCreateCompany({
    super.key,
    required this.titleText,
  });
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: ColorManger.black.withOpacity(0.66)),
        ),
      ],
    );
  }
}
