// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/signup_cubit.dart';
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
    final trigerCubit = BlocProvider.of<SignupCubit>(context);
    bool isLoading = false;
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupLoading) {
              isLoading = true;
            } else if (state is SignupSuccess) {
              Navigator.of(context)
                  .pushReplacementNamed(RouterName.homeScreenForUser);
            } else if (state is Signupfaild) {
              isLoading = false;
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            return Center(
                child: ModalProgressHUD(
              inAsyncCall: isLoading,
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
                            //
                            //
                            CustomTextFormField(
                                onChanged: (value) {
                                  trigerCubit.emailCubit = value;
                                },
                                //
                                //
                                labelText: S
                                    .of(context)
                                    .emailLabelTextInRegisterScreen,
                                hintText:
                                    S.of(context).emailHintTextInRegisterScreen,
                                prefixIcon: const Icon(Icons.email)),
                            //
                            //
                            CustomTextFormField(
                                onChanged: (value) {
                                  trigerCubit.passwordCubit = value;
                                },
                                //
                                //
                                labelText: S
                                    .of(context)
                                    .passwordLabelTextInRegisterScreen,
                                hintText: S
                                    .of(context)
                                    .passwordHintTextInRegisterScreen,
                                prefixIcon: const Icon(Icons.lock)),
                            //
                            //
                            //
                            CustomTextFormField(
                                labelText:
                                    S.of(context).nameLabelTextInRegisterScreen,
                                hintText:
                                    S.of(context).nameHintTextInRegisterScreen,
                                prefixIcon: const Icon(Icons.person)),
                            //
                            //
                            //
                            CustomTextFormField(
                                labelText:
                                    S.of(context).nameLabelTextInRegisterScreen,
                                hintText:
                                    S.of(context).nameHintTextInRegisterScreen,
                                prefixIcon: const Icon(Icons.person)),
                            //
                            //
                            //
                            CustomButton(
                                nameOfButton:
                                    S.of(context).registerAccountBotton,
                                onTap: () async {
                                  await trigerCubit.userSignUP(
                                    email: trigerCubit.emailCubit,
                                    password: trigerCubit.passwordCubit,
                                  );
                                }),

                            //
                            //
                            //
                            CustomBottonWithIconOrImage(
                                onTap: () {},
                                imageIconButton: ImageManger.googleLogo,
                                nameOfButton: S
                                    .of(context)
                                    .registerAccountBottonByGoogle),
                            //
                            //
                            //
                            const UserIfAlreadyHaveAccount()
                          ]),
                    )),
                  ),
                ],
              ),
            ));
          },
        ));
  }
}
