import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/theme/themeManger.dart';
import 'package:mohra_project/core/helpers/bloc_abserver.dart';
import 'package:mohra_project/core/routes/app_router.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/details_documents/presentation/views/details_documents.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';
import 'package:mohra_project/features/user/upload_document/presentation/manger/upload_documents/upload_documents_cubit.dart';
import 'package:mohra_project/features/user/upload_document/presentation/views/upload_documents.dart';
import 'package:mohra_project/firebase_options.dart';
import 'package:mohra_project/generated/l10n.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
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
              ],
              child: MaterialApp(
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
                //
                // for Routing Screens
                onGenerateRoute: AppRouter.onGenrateRoute,
                initialRoute: RouterName.registerScreen,

                routes: {
                  RouterName.companyDocuments: (context) =>
                      const CompanyDocuments(),
                  RouterName.homeScreenForUser: (context) =>
                      const HomeScreenForUser(),
                  RouterName.uploadDocuments: (context) =>
                      const UploadDocuments(),
                  RouterName.detailsDocuments: (context) =>
                      const DetailsDocuments(),
                },
                // home: test(),
                // ),
              ));
        },
      );
    });
  }
}
