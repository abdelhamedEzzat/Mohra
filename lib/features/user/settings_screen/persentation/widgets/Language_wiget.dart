import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/generated/l10n.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        S.of(context).Language,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      backgroundColor: Colors.white,
      iconColor: ColorManger.black,
      leading: Icon(
        Icons.language,
        size: 24.h,
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomButton(
                        onTap: () {},
                        nameOfButton: S.of(context).Arabic,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: CustomButton(
                          onTap: () {},
                          nameOfButton: S.of(context).English,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
