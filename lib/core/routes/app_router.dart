import 'package:flutter/material.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/accountant_home_screen.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/accuntant_company_documents.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/documents_detatils_for_accountant.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/admin_home_screen.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/add_new_accountant.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/add_new_auditor.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/widget/manage_assignment.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/auditor_home_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/auditor_detatils_documents_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/auditor_company_documents.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/forget_password.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/create_company.dart';
import 'package:mohra_project/features/intro_screens/presentation/views/first_intro_screen.dart';
import 'package:mohra_project/features/login_screen/presentation/view/login_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/register_screen.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/splash_screen.dart';
import 'package:mohra_project/features/vreify_email/vreify_email.dart';

class AppRouter {
  static Route<dynamic> onGenrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.introScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RouterName.firstSplashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const IntroScreens(),
        );
      //
      //
      case RouterName.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      //
      //
      case RouterName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          // BlocProvider(
          //       create: (context) => AuthCubit(),
          //       child: const LoginScreen(),
          //     )
        );
//
//
      // case RouterName.homeScreenForUser:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreenForUser(),
      //   );
      case RouterName.createCompany:
        return MaterialPageRoute(
          builder: (_) => const CreateCompany(),
        );
      // case RouterName.companyDocuments:
      //   return MaterialPageRoute(
      //     builder: (_) => const CompanyDocuments(),
      //   );
      // case RouterName.uploadDocuments:
      //   return MaterialPageRoute(
      //     builder: (_) => const UploadDocuments(),
      //   );
      // case RouterName.detailsDocuments:
      //   return MaterialPageRoute(
      //     builder: (_) => const DetailsDocuments(),
      //   );
      case RouterName.auditorHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const AuditorHomeScreen(),
        );
      case RouterName.accountantHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const AccountantHomeScreen(),
        );
      case RouterName.adminHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const AdminHomeScreen(),
        );
      case RouterName.accuntantCompanyDocuments:
        return MaterialPageRoute(
          builder: (_) => const AccuntantCompanyDocuments(),
        );
      case RouterName.accountantDocumentDetails:
        return MaterialPageRoute(
          builder: (_) => const AccountantDocumentDetails(),
        );
      case RouterName.auditorDocumentDetails:
        return MaterialPageRoute(
          builder: (_) => const AuditorDocumentDetails(),
        );
      case RouterName.auditorCompanyDocuments:
        return MaterialPageRoute(
          builder: (_) => const AuditorCompanyDocuments(),
        );
      case RouterName.addNewAccountant:
        return MaterialPageRoute(
          builder: (_) => const AddNewAccountant(),
        );
      case RouterName.addNewAuditor:
        return MaterialPageRoute(
          builder: (_) => const AddNewAuditor(),
        );
      case RouterName.manageAssignment:
        return MaterialPageRoute(
          builder: (_) => const ManageAssignment(),
        );
      case RouterName.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );
      case RouterName.vreifyEmail:
        return MaterialPageRoute(
          builder: (_) => const VreifyEmail(),
        );
      // case RouterName.test:
      //   return MaterialPageRoute(
      //     builder: (_) => const test(),
      //   );
      // case RouterName.test2:
      //   return MaterialPageRoute(
      //     builder: (_) => const test2(),
      //   );

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
