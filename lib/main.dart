import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/constants/theme/themeManger.dart';
import 'package:mohra_project/core/helpers/bloc_abserver.dart';
import 'package:mohra_project/core/routes/app_router.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/accountant_home_screen.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/accuntant_company_documents.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/documents_detatils_for_accountant.dart';
import 'package:mohra_project/features/admin/home_screen_for_admin/presentation/views/admin_home_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/auditor_detatils_documents_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/auditor_home_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/add_type_of_document_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/auditor_company_documents.dart';
import 'package:mohra_project/features/login_screen/presentation/view/login_screen.dart';
import 'package:mohra_project/features/register_screen/data/user_auth.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/register_screen.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_admin.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/splash_screens/presentation/views/splash_screen.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';
import 'package:mohra_project/features/user/create_company/data/add_company_hive.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/details_documents/presentation/views/details_documents.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/manger/language/language_cubit.dart';
import 'package:mohra_project/features/user/upload_document/data/company_document_model.dart';
import 'package:mohra_project/features/user/upload_document/presentation/manger/upload_documents/upload_documents_cubit.dart';
import 'package:mohra_project/features/user/upload_document/presentation/views/upload_documents.dart';
import 'package:mohra_project/features/vreify_email/vreify_email.dart';
import 'package:mohra_project/firebase_options.dart';
import 'package:mohra_project/generated/l10n.dart';
import 'package:mohra_project/search.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  //
  //
  Hive.registerAdapter(UserStatusModelAdapter());
  await Hive.openBox<UserStatusModel>('userStatusBox');
  //
  //
  Hive.registerAdapter(AddCompanyToHiveAdapter());
  await Hive.openBox<AddCompanyToHive>('companyBox');

  Hive.registerAdapter(CompanyDocumentAdapter());
  await Hive.openBox<CompanyDocument>('company_documents');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>

          //  MultiBlocProvider(
          // providers: [
          //   RepositoryProvider<AuthRepostory>(
          //       create: (_) => AuthRepostory()),
          //   RepositoryProvider<LoginAuthProvider>(
          //       create: (_) => LoginAuthProvider()),
          // ],
          const MyApp(),
      // )
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      constraints.maxHeight;
      constraints.maxWidth;
      print("hight   ${constraints.maxHeight.toInt()}");
      print("Width   ${constraints.maxWidth.toInt()}");

      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => FirebaseCreateCompanyCubit(),
              ),
              BlocProvider(
                create: (context) => UploadDocumentsCubit(),
              ),
              BlocProvider(
                create: (context) => LanguageCubit(),
              ),
              // BlocProvider(
              //   create: (context) => MannageAssignmentCubit(),
              // ),
            ],
            child: BlocBuilder<LanguageCubit, Language>(
                builder: (context, languageState) {
              TextDirection textDirection = languageState == Language.arabic
                  ? TextDirection.rtl
                  : TextDirection.ltr;
              return Directionality(
                textDirection: textDirection,
                child: MaterialApp(
                  locale: (languageState == Language.arabic)
                      ? Locale('ar', '')
                      : Locale('en', ''),
                  //locale: Locale("ar"),

                  theme: theme(),
                  debugShowCheckedModeBanner: false,
                  // for Responcive Screens
                  builder: DevicePreview.appBuilder,
                  //
                  // For Localization Screens
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,

                  // for Routing Screens
                  onGenerateRoute: AppRouter.onGenrateRoute,
                  // initialRoute: RouterName.loginScreen,

                  routes: {
                    RouterName.companyDocuments: (context) =>
                        const CompanyDocuments(),
                    RouterName.homeScreenForUser: (context) =>
                        const HomeScreenForUser(),
                    RouterName.uploadDocuments: (context) =>
                        const UploadDocuments(),
                    RouterName.detailsDocuments: (context) =>
                        const DetailsDocuments(),
                    RouterName.addDocumetType: (context) => AddDocumentType(),
                    RouterName.auditorCompanyDocuments: (context) =>
                        const AuditorCompanyDocuments(),
                    RouterName.auditorHomeScreen: (context) =>
                        const AuditorHomeScreen(),
                    RouterName.accountantHomeScreen: (context) =>
                        const AccountantHomeScreen(),
                    RouterName.accountantDocumentDetails: (context) =>
                        const AccountantDocumentDetails(),
                    RouterName.accuntantCompanyDocuments: (context) =>
                        const AccuntantCompanyDocuments(),
                    RouterName.auditorDocumentDetails: (context) =>
                        const AuditorDocumentDetails(),
                    RouterName.searchScreenForAdmin: (context) =>
                        const SearchScreenForAdmin(),
                    RouterName.searchScreenForUser: (context) => searchuser()
                  },

                  home:
                      //MyAppppp()
                      // MyApppp()
                      // AddDocumentType(),

                      const AuthUsers(),
                ),
              );
            }),
          );
        },
      );
    });
  }
}

class AuthUsers extends StatelessWidget {
  const AuthUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        User? user = snapshot.data;
        var status = Constanscollection.getUserStatus();
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (user != null) {
          print("==================================User sign in ");
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                // Loading user data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (userSnapshot.hasData) {
                // User data is available, check role
                var userData = userSnapshot.data!.data();

                if (userData != null && userData is Map<String, dynamic>) {
                  String userRole = userData['role'] ?? '';
                  String userStatus =
                      userData.containsKey('status') ? userData['status'] : '';

                  // Now you can use the userRole to decide where to navigate
                  if (userRole == 'admin') {
                    return const AdminHomeScreen();
                  } else if (userRole == 'User') {
                    if (userStatus == '0') {
                      return const RegisterScreen();
                    } else if (userStatus == '1') {
                      return const RegisterScreen();
                    } else if (userStatus == '2') {
                      if (FirebaseAuth.instance.currentUser!.emailVerified) {
                        return const HomeScreenForUser();
                      } else if (!FirebaseAuth
                          .instance.currentUser!.emailVerified) {
                        return const VreifyEmail();
                      }
                      return const HomeScreenForUser();
                    }
                  } else if (userRole == "Accountant") {
                    return AccountantHomeScreen();
                  } else if (userRole == "Auditor") {
                    return AuditorHomeScreen();
                    // Add logic for userRole == "Auditor"
                  }
                } else {
                  print(
                      "User data is null or not of type Map<String, dynamic>");
                }
              } else if (userSnapshot.data == null) {
                return const RegisterScreen();
              }

              return const SplashScreen();
            },
          );
        } else {
          print("==================================User sign out ");
          // هنا يمكنك إجراء الإجراءات المناسبة عند تسجيل الخروج
          return status == 0 ? SplashScreen() : LoginScreen();
        }
      },
    );
  }
}
   // if (user != null) {
            //   // المستخدم قام بتسجيل الدخول
            //   print("User signed in");
            //   // handleUserSignIn(user);
            // } else {
            //   // المستخدم قام بتسجيل الخروج أو غير مسجل
            //   print("User signed out or not signed in");
            //   // handleUserSignOut();
            // }