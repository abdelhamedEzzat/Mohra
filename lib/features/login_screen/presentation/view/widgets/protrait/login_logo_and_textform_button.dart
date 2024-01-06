import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/forget_password.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/if_didnt_have_account.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/login_account_text.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/generated/l10n.dart';

class LoginLogoAndTextFieldAndbuttonProtrait extends StatelessWidget {
  const LoginLogoAndTextFieldAndbuttonProtrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageManger.mohraLogo,
            ),
            SizedBox(
              height: 20.h,
            ),
            ClassMorphismInsideScreen(
              blur: 20,
              opacity: 0.5,
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(
                      right: 8,
                      left: 8,
                    ),
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 10, left: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LoginAccountText(),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextFormField(
                              labelText:
                                  S.of(context).emailLabelTextInRegisterScreen,
                              hintText:
                                  S.of(context).emailHintTextInRegisterScreen,
                              prefixIcon: const Icon(Icons.email)),
                          CustomTextFormField(
                              labelText: S
                                  .of(context)
                                  .passwordLabelTextInRegisterScreen,
                              hintText: S
                                  .of(context)
                                  .passwordHintTextInRegisterScreen,
                              prefixIcon: const Icon(Icons.lock)),

                          const ForgetPassword(),
                          //  fontSize: FontSize.s12.h, color: ColorManger.black
                          CustomButton(
                              nameOfButton: S.of(context).loginAccountBotton,
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    RouterName.homeScreenForUser);
                              }),
                          CustomBottonWithIconOrImage(
                              onTap: () {},
                              imageIconButton: ImageManger.googleLogo,
                              nameOfButton:
                                  S.of(context).loginAccountBottonByGoogle),
                          const IfYouDidntHaveAccount()
                        ])),
              ),
            ),
          ],
        )));
  }
}
