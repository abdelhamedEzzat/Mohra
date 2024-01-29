import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/theme/themeManger.dart';
import 'package:mohra_project/core/helpers/bloc_abserver.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/app_router.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/accountant_home_screen.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/accuntant_company_documents.dart';
import 'package:mohra_project/features/accountant/home_screen_for_accountant/presentation/views/widget/documents_detatils_for_accountant.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/auditor_detatils_documents_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/auditor_home_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/add_type_of_document_screen.dart';
import 'package:mohra_project/features/auditor/home_screen_for_auditor/presentation/views/widget/auditor_company_documents.dart';
import 'package:mohra_project/features/register_screen/data/user_auth.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/protrait/accepted_massage_screen.dart';
import 'package:mohra_project/features/search_screen/search_screen.dart';
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

  await Hive.initFlutter();
  // Hive.registerAdapter<UserStatusModel>(UserStatusModelAdapter());
  // await Hive.openBox<UserStatusModel>('userStatusBox');
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
              // BlocProvider(
              //   create: (context) => MannageAssignmentCubit(),
              // ),
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
                RouterName.acceptedMassageScreen: (context) =>
                    const AcceptedMassageScreen(),
                RouterName.addDocumetType: (context) => const AddDocumentType(),
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
                RouterName.searchScreen: (context) => const SearchScreen()
              },
              // home: const test(),
            ),
          );
        },
      );
    });
  }
}
