import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/create_company.dart';
import 'package:mohra_project/features/user/details_documents/presentation/views/details_documents.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';
import 'package:mohra_project/features/intro_screens/presentation/views/first_intro_screen.dart';
import 'package:mohra_project/features/login_screen/presentation/view/login_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/register_screen.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/splash_screen.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';
import 'package:mohra_project/features/user/upload_document/presentation/views/upload_documents.dart';

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
      case RouterName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RouterName.homeScreenForUser:
        return MaterialPageRoute(
          builder: (_) => const HomeScreenForUser(),
        );
      case RouterName.createCompany:
        return MaterialPageRoute(
          builder: (_) => const CreateCompany(),
        );
      case RouterName.companyDocuments:
        return MaterialPageRoute(
          builder: (_) => const CompanyDocuments(),
        );
      case RouterName.uploadDocuments:
        return MaterialPageRoute(
          builder: (_) => const UploadDocuments(),
        );
      case RouterName.detailsDocuments:
        return MaterialPageRoute(
          builder: (_) => const DetailsDocuments(),
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
