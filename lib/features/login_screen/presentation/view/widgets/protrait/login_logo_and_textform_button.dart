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
import 'package:mohra_project/features/login_screen/presentation/manger/login_cubit/login_cubit.dart';
import 'package:mohra_project/features/login_screen/presentation/manger/login_cubit/login_state.dart';
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
    final trigerCubit = BlocProvider.of<LoginCubit>(context);
    bool isLoading = false;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouterName.homeScreenForUser,
            (route) => false,
          );
        } else if (state is Loginfaild) {
          isLoading = false;
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Center(
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
                              const LoginAccountText(),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextFormField(
                                  onChanged: (value) {
                                    trigerCubit.emailCubit = value;
                                  },
                                  labelText: S
                                      .of(context)
                                      .emailLabelTextInRegisterScreen,
                                  hintText: S
                                      .of(context)
                                      .emailHintTextInRegisterScreen,
                                  prefixIcon: const Icon(Icons.email)),
                              CustomTextFormField(
                                  onChanged: (value) {
                                    trigerCubit.passwordCubit = value;
                                  },
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
                                  nameOfButton:
                                      S.of(context).loginAccountBotton,
                                  onTap: () {
                                    trigerCubit.userSignin(
                                        email: trigerCubit.emailCubit,
                                        password: trigerCubit.passwordCubit);
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
            ),
          )),
        );
      },
    );
  }
}
