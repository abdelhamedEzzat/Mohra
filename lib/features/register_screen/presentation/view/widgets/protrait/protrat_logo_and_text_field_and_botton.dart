import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/register_account_text.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/user_have_account.dart';
import 'package:mohra_project/generated/l10n.dart';

class LogoAndTextFieldAndbuttonProtrait extends StatelessWidget {
  const LogoAndTextFieldAndbuttonProtrait({
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
                          const RegisterAccountText(),
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
                          CustomTextFormField(
                              labelText:
                                  S.of(context).nameLabelTextInRegisterScreen,
                              hintText:
                                  S.of(context).nameHintTextInRegisterScreen,
                              prefixIcon: const Icon(Icons.person)),
                          CustomButton(
                              nameOfButton: S.of(context).registerAccountBotton,
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    RouterName.homeScreenForUser);
                              }),
                          CustomBottonWithIconOrImage(
                              onTap: () {},
                              imageIconButton: ImageManger.googleLogo,
                              nameOfButton:
                                  S.of(context).registerAccountBottonByGoogle),
                          const UserIfAlreadyHaveAccount()
                        ])),
              ),
            ),
          ],
        )));
  }
}
