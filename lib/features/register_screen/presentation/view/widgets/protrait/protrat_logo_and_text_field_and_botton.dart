// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/register_account_text.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/user_have_account.dart';
import 'package:mohra_project/generated/l10n.dart';

class LogoAndTextFieldAndbuttonProtrait extends StatefulWidget {
  const LogoAndTextFieldAndbuttonProtrait({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoAndTextFieldAndbuttonProtrait> createState() =>
      _LogoAndTextFieldAndbuttonProtraitState();
}

class _LogoAndTextFieldAndbuttonProtraitState
    extends State<LogoAndTextFieldAndbuttonProtrait> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override

  // void initState() {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       user.reload();
  //       if (user.emailVerified) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
  //             context,
  //             "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
  //             backgroundcolor: ColorManger.backGroundColorToSplashScreen,
  //             duration: const Duration(days: 1)));
  //       } else {}
  //     } else if (user == null) {
  //       // Handle the case where the user is null
  //     }
  //   } catch (e) {
  //     print({"=======================error$e"});
  //   }

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;
    return Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignupLoading) {
              isLoading = true;
            } else if (state is SignupSuccess) {
              isLoading = false;

              // BlocProvider.of<AuthCubit>(context).verifyEmail();
              // Future<bool> checkEmailStatus() async {
              //   try {
              //     User? user = FirebaseAuth.instance.currentUser;
              //     if (user != null) {
              //       DocumentSnapshot<Map<String, dynamic>> userData =
              //           await FirebaseFirestore.instance
              //               .collection("users")
              //               .doc(user.uid)
              //               .get();

              //       String emailStatus = userData["Email_status"] ?? "";

              //       if (emailStatus.toLowerCase() == "disabled") {
              //         Navigator.of(context).pushReplacementNamed(
              //             RouterName.acceptedMassageScreen);
              //       } else if (emailStatus.toLowerCase() == "enabled") {
              Navigator.of(context)
                  .pushReplacementNamed(RouterName.adminHomeScreen);
              //       }
              //     }
              //     return false;
              //   } catch (e) {
              //     print("Error checking email status: $e");
              //     return false;
              //   }
              // }
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
                      child: Container(
                        height: 400.h,
                        margin: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                        ),
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 10, left: 10),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const RegisterAccountText(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomTextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text.';
                                        } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                            .hasMatch(value)) {
                                          return 'Please enter only letters.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        trigerCubit.firstName = value;
                                      },
                                      labelText: S
                                          .of(context)
                                          .firstnameLabelTextInRegisterScreen,
                                      hintText: S
                                          .of(context)
                                          .nameHintTextInRegisterScreen,
                                      prefixIcon: const Icon(Icons.person)),
                                  //
                                  //
                                  //
                                  CustomTextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text.';
                                        } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                            .hasMatch(value)) {
                                          return 'Please enter only letters.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        trigerCubit.lastName = value;
                                      },
                                      labelText: S
                                          .of(context)
                                          .lastnameLabelTextInRegisterScreen,
                                      hintText: S
                                          .of(context)
                                          .nameHintTextInRegisterScreen,
                                      prefixIcon: const Icon(Icons.person)),
                                  //
                                  //
                                  //

                                  //
                                  //
                                  CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "* this Field is required You must enter data";
                                        } else if (!RegExp(r'[a-zA-Z]')
                                            .hasMatch(value)) {
                                          return "The email must contain at least one letter.";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        trigerCubit.emailCubit = value;
                                      },
                                      //

                                      //
                                      labelText: S
                                          .of(context)
                                          .emailLabelTextInRegisterScreen,
                                      hintText: S
                                          .of(context)
                                          .emailHintTextInRegisterScreen,
                                      prefixIcon: const Icon(Icons.email)),
                                  //
                                  //
                                  CustomTextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "* this Field is required You must enter data";
                                        } else if (!RegExp(
                                                r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).+$')
                                            .hasMatch(value)) {
                                          return "Password must contain  numbers, letters, and special character.";
                                        }
                                        return null;
                                      },
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

                                  CustomButton(
                                      nameOfButton:
                                          S.of(context).registerAccountBotton,
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          await trigerCubit.userSignUP(
                                            email: trigerCubit.emailCubit,
                                            password: trigerCubit.passwordCubit,
                                          );
                                        }
                                        await trigerCubit.addUser(
                                            email: trigerCubit.emailCubit,
                                            firstName: trigerCubit.firstName,
                                            lastName: trigerCubit.lastName);

                                        await trigerCubit.getUserdata();
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
                          ),
                        ),
                      )),
                ],
              ),
            ));
          },
        ));
  }
}
