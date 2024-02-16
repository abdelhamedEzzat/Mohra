import 'package:flutter/material.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/glass_screen_for_login_screen.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/protrait/login_logo_and_textform_button.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/gradiant_list.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          //  Oriantation(
          //   portrait:
          Container(
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                GlassScreenForLoginScreen(),
                LoginLogoAndTextFieldAndbuttonProtrait(),
              ],
            ),
          ),
        ),
      ),
      //   landscape: Container(
      //     height: double.infinity,
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: gradiantList,
      //     )),
      //     child: NotificationListener<OverscrollIndicatorNotification>(
      //       onNotification: (notification) {
      //         notification.disallowIndicator();
      //         return true;
      //       },
      //       child: const Stack(
      //         alignment: Alignment.center,
      //         children: [
      //           GlassScreenForLoginScreen(),
      //           LoginLogoAndTextFieldAndbuttonlandscape(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
