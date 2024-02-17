import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/widgets/widget_build_splash_screen.dart';

class SplashScreenBodyWidget extends StatefulWidget {
  const SplashScreenBodyWidget({super.key});

  @override
  State<SplashScreenBodyWidget> createState() => _IntroScreenBodyWidgetState();
}

class _IntroScreenBodyWidgetState extends State<SplashScreenBodyWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

//
//initial State For animation and duration
//
  @override
  void initState() {
    super.initState();

    initSlidingAnimation();

    durationToNavigatorToIntroScreen();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetBuildSplashScreen(
      slidingAnimation: slidingAnimation,
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  Future<Null> durationToNavigatorToIntroScreen() {
    return Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacementNamed(RouterName.firstSplashScreenRoute);
    });
  }
}
