import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/const_images/const_images.dart';
import 'package:mohra_project/core/constants/const_words/const_words.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';

class WidgetBuildIntroScreen extends StatefulWidget {
  const WidgetBuildIntroScreen({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  State<WidgetBuildIntroScreen> createState() => _IntroScreenForMobileState();
}

class _IntroScreenForMobileState extends State<WidgetBuildIntroScreen>
    with TickerProviderStateMixin {
  late Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [buildLogoImage(context), buildSlidingAnimation()],
    );
  }

  Center buildLogoImage(BuildContext context) {
    return Center(
      child: Image.asset(
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
        ConstImages.mohraLogo,
      ),
    );
  }

  AnimatedBuilder buildSlidingAnimation() {
    return AnimatedBuilder(
        animation: widget.slidingAnimation,
        builder: (BuildContext context, Widget? child) {
          return SlideTransition(
              position: widget.slidingAnimation,
              child: Center(
                child: Text(
                  ConstWord.slogenApp,
                  style: TextStyle(
                      color: ColorManger.slogenColor,
                      fontWeight: FontWeightManager.bold,
                      fontSize: 12.w),
                ),
              ));
        });
  }
}
