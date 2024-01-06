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

class LogoAndTextFieldAndbuttonlandscape extends StatelessWidget {
  const LogoAndTextFieldAndbuttonlandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                ImageManger.mohraLogo,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ClassMorphismInsideScreen(
                  blur: 20,
                  opacity: 0.5,
                  child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      //   height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(
                          right: 8, left: 8, top: 8, bottom: 8),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 10, left: 10),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const RegisterAccountText(),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextFormField(
                                  labelText: S
                                      .of(context)
                                      .emailLabelTextInRegisterScreen,
                                  hintText: S
                                      .of(context)
                                      .emailHintTextInRegisterScreen,
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
                                  labelText: S
                                      .of(context)
                                      .nameLabelTextInRegisterScreen,
                                  hintText: S
                                      .of(context)
                                      .nameHintTextInRegisterScreen,
                                  prefixIcon: const Icon(Icons.person)),
                              CustomButton(
                                  nameOfButton:
                                      S.of(context).registerAccountBotton,
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        RouterName.homeScreenForUser);
                                  }),
                              CustomBottonWithIconOrImage(
                                  onTap: () {},
                                  imageIconButton: ImageManger.googleLogo,
                                  nameOfButton: S
                                      .of(context)
                                      .registerAccountBottonByGoogle),
                              const UserIfAlreadyHaveAccount()
                            ]),
                      )),
                ),
              ),
            ),
          ],
        )));
  }
}
