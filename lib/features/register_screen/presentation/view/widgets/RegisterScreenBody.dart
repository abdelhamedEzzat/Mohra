// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:mohra_project/core/device_type_and_orientation/orientation_widget.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/glass_screen_for_register_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/gradiant_list.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/landscape/landscape_logo_and_text_field_and_botton.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/protrait/protrat_logo_and_text_field_and_botton.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({
    super.key,
  });

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) {
          return Oriantation(
            portrait: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradiantList,
              )),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GlassScreenForRegisterScreen(),
                      LogoAndTextFieldAndbuttonProtrait(),
                    ],
                  ),
                ),
              ),
            ),
            landscape: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradiantList,
              )),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GlassScreenForRegisterScreen(),
                      LogoAndTextFieldAndbuttonlandscape(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
