import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/font_manger/font_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/glass_screen_for_login_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/gradiant_list.dart';
import 'package:mohra_project/generated/l10n.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 10, bottom: 8),
        alignment: Alignment.centerRight,
        child: Text.rich(WidgetSpan(
            child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(RouterName.resetPasswordScreen);
          },
          child: Text(
            S.of(context).forgetPassword,
            style: TextStyle(
                fontSize: FontSize.s12.h,
                color: ColorManger.backGroundColorToSplashScreen),
          ),
        ))));
  }
}

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                ResetPasswordBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;

    return BlocConsumer<AuthCubit, AuthState>(
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.of(context).resetPassword,
                                  style: TextStyle(
                                      color: ColorManger
                                          .backGroundColorToSplashScreen,
                                      fontSize: FontSize.s20.h,
                                      fontWeight: FontWeightManager.bold),
                                ),
                              ),
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
                              // CustomTextFormField(
                              //     onChanged: (value) {
                              //       trigerCubit.passwordCubit = value;
                              //     },
                              //     labelText: S
                              //         .of(context)
                              //         .passwordLabelTextInRegisterScreen,
                              //     hintText: S
                              //         .of(context)
                              //         .passwordHintTextInRegisterScreen,
                              //     prefixIcon: const Icon(Icons.lock)),

                              // const ForgetPassword(),
                              //  fontSize: FontSize.s12.h, color: ColorManger.black
                              CustomButton(
                                  nameOfButton: S.of(context).sendRequest,
                                  onTap: () async {
                                    if (trigerCubit.emailCubit.isNotEmpty) {
                                      await trigerCubit.resetAccount().then(
                                          (value) =>
                                              Navigator.of(context).pop());
                                    }
                                  }),
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
