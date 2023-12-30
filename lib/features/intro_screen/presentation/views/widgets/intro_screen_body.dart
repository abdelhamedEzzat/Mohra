import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/intro_screen/presentation/views/widgets/widget_build_intro_screen.dart';

class IntroScreenBodyWidget extends StatefulWidget {
  const IntroScreenBodyWidget({super.key});

  @override
  State<IntroScreenBodyWidget> createState() => _IntroScreenBodyWidgetState();
}

class _IntroScreenBodyWidgetState extends State<IntroScreenBodyWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();

    initSlidingAnimation();

    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context)
          .pushReplacementNamed(RouterName.firstSplashScreenRoute);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetBuildIntroScreen(
      slidingAnimation: slidingAnimation,
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }
}
