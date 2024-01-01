import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/intro_screens/presentation/views/first_intro_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/register_screen.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/splash_screen.dart';

class AppRouter {
  static Route onGenrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.introScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RouterName.firstSplashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const IntroScreens(),
        );
      case RouterName.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
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
