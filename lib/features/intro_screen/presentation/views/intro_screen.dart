import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/intro_screen/presentation/views/widgets/intro_screen_body.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.introScreenBackgroundColor,
      body: const IntroScreenBodyWidget(),
    );
  }
}
