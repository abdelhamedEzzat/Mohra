import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';

class NumberOfCompaniesAndDocuments extends StatelessWidget {
  const NumberOfCompaniesAndDocuments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: ColorManger.backGroundColorToSplashScreen,
        height: MediaQuery.of(context).size.height * 0.20,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconsAndTextToCompany(
              text: "Companies",
            ),
            IconsAndTextToDoc(
              text: "Documents",
            ),
          ],
        ),
      ),
    );
  }
}
