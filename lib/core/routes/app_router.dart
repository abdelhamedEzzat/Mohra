import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/intro_screen/presentation/views/intro_screen.dart';
import 'package:mohra_project/features/splash_screen/presentation/views/first_splash_screen.dart';

class AppRouter {
  static Route onGenrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.introScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
        );
      case RouterName.firstSplashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const FirstSplashScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("error"),
              ),
            ),
        settings: const RouteSettings(name: "/error"));
  }
}
