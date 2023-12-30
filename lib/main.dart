import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/routes/app_router.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
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
          return MaterialApp(
            theme: ThemeData(fontFamily: "Kanit"),
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
            initialRoute: RouterName.introScreenRoute,
          );
        },
      );
    });
  }
}
