import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/widgets/splash_screen_body_widget.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.introScreenBackgroundColor,
      body: const SplashScreenBodyWidget(),
    );
  }
}
