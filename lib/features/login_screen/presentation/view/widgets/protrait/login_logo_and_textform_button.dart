import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/forget_password.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/if_didnt_have_account.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/login_account_text.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/generated/l10n.dart';

class LoginLogoAndTextFieldAndbuttonProtrait extends StatefulWidget {
  const LoginLogoAndTextFieldAndbuttonProtrait({
    super.key,
  });

  @override
  State<LoginLogoAndTextFieldAndbuttonProtrait> createState() =>
      _LoginLogoAndTextFieldAndbuttonProtraitState();
}

class _LoginLogoAndTextFieldAndbuttonProtraitState
    extends State<LoginLogoAndTextFieldAndbuttonProtrait> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          Constanscollection.updateUserStatus(1);
          checkEmailAndNavigate(context);
        } else if (state is Loginfaild) {
          isLoading = false;
          showSnackBar(context, state.error.toString());
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
                        child: Form(
                          key: formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const LoginAccountText(),
                                const SizedBox(
                                  height: 8,
                                ),

                                //
                                //   TextFormField fo email

                                CustomTextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "* this Field is required You must enter data";
                                      }
                                      return null;
                                    },
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

                                //
                                //   TextFormField fo password

                                CustomTextFormField(
                                  obscureText: isPasswordVisible,
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* this Field is required You must enter data";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    trigerCubit.passwordCubit = value;
                                  },
                                  labelText: S
                                      .of(context)
                                      .passwordLabelTextInRegisterScreen,
                                  hintText: S
                                      .of(context)
                                      .passwordHintTextInRegisterScreen,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                //
                                //this widget for forget password

                                const ForgetPassword(),

                                //
                                //
                                CustomButton(
                                    nameOfButton:
                                        S.of(context).loginAccountBotton,
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        //
                                        // this function for  user sign in
                                        Constanscollection.getUserStatus();
                                        await trigerCubit.userSignin(
                                          email: trigerCubit.emailCubit,

                                          //
                                          // this function for get user data

                                          password: trigerCubit.passwordCubit,
                                        );
                                        await trigerCubit.getUserdata();
                                      }
                                    }),

                                //
                                // this function for sign in with google

                                CustomBottonWithIconOrImage(
                                    onTap: () async {
                                      await trigerCubit.signInWithGoogle();

                                      final user = trigerCubit.user;

                                      if (user != null) {
                                        checkEmailForSigninWithGoogle(context);
                                      }
                                    },
                                    imageIconButton: ImageManger.googleLogo,
                                    nameOfButton: S
                                        .of(context)
                                        .loginAccountBottonByGoogle),

                                //
                                //this function for goto signup screen

                                const IfYouDidntHaveAccount()
                              ]),
                        )),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  void showWelcomeSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
          context,
          "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours you cant do anythink after accepted. ",
          backgroundcolor: ColorManger.backGroundColorToSplashScreen,
          duration: const Duration(seconds: 20),
        ));
  }

  Future<void> checkEmailForSigninWithGoogle(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get();

        String emailStatus = userData["Email_status"] ?? "";
        String status = userData["status"] ?? "";
        if (emailStatus.toLowerCase() == "disabled") {
          Navigator.of(context)
              .pushReplacementNamed(RouterName.watingForAdminAccepted);
        } else if (emailStatus.toLowerCase() == "enabled" && status == "2") {
          print(status);

          Navigator.of(context)
              .pushReplacementNamed(RouterName.homeScreenForUser);

          print(emailStatus);
        }
      }
    } catch (e) {
      print("Error checking email status: $e");
    }
  }

  Future checkEmailAndNavigate(context) async {
    //  var user = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    return querySnapshot.docs.forEach((doc) {
      print("User Data: ${doc.data()}");
      Map<String, dynamic> roleMap = doc.get('role');
      String role = roleMap['en']; // Accessing the English role
      String emailStatus = doc.get('Email_status');
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (role == 'admin' && emailStatus == "enabled") {
          print(role);
          print(emailStatus);
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouterName.adminHomeScreen,
            (route) => false,
          );
          print(role);
          print(emailStatus);
        } else if (emailStatus.toLowerCase() == "enabled" && role == 'User') {
          FirebaseFirestore.instance.collection('Notification').add({
            'notificationMassage':
                "the user  ${doc['email']}  Login  in app to be $role ",
            'role': role,
            'MassgeSendBy': 'User',
            'NotificationCompanyID': '',
            'NotificationUserID': "${doc['fullName']}"
          });
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouterName.homeScreenForUser, (route) => false);
        }
        //   else if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        //     BlocProvider.of<AuthCubit>(context).verifyEmail();
        //     Navigator.of(context).pushReplacementNamed(RouterName.vreifyEmail);

        // }

        else if (role == 'Auditor'.toLowerCase() && emailStatus == "enabled") {
          // FirebaseFirestore.instance.collection('users').doc().update({
          //   "userID": user,
          // });
          FirebaseFirestore.instance.collection('Notification').add({
            'notificationMassage':
                "the user  ${doc['fullName']}  Login in app to be $role ",
            'role': role,
            'MassgeSendBy': 'Auditor',
            'NotificationCompanyID': '',
            'NotificationUserID': "${doc['email']}"
          });

          Navigator.of(context).pushNamedAndRemoveUntil(
              RouterName.auditorHomeScreen, (route) => false);
        }
        // else if (FirebaseAuth.instance.currentUser!.emailVerified) {
        //   BlocProvider.of<AuthCubit>(context).verifyEmail();
        //   Navigator.of(context).pushReplacementNamed(RouterName.vreifyEmail);
        // }
      }
      // else if (FirebaseAuth.instance.currentUser!.emailVerified) {
      else if (role == 'Accountant' && emailStatus == "enabled") {
        // FirebaseFirestore.instance.collection('users').doc().update({
        //   "userID": user,
        // });
        FirebaseFirestore.instance.collection('Notification').add({
          'notificationMassage':
              "the user  ${doc['fullName']}  Login in app to be $role ",
          'role': role,
          'MassgeSendBy': 'Accountant',
          'NotificationCompanyID': '',
          'NotificationUserID': "${doc['fullName']}"
        });
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouterName.accountantHomeScreen, (route) => false);
      }
      // else if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      //   BlocProvider.of<AuthCubit>(context).verifyEmail();
      //   Navigator.of(context).pushReplacementNamed(RouterName.vreifyEmail);
      // }
      // }
      // }
      else if (user == null) {
        Navigator.of(context).pushNamed(RouterName.registerScreen);
      }
    });
  }

  void handleEmailVerification(context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      checkEmailAndNavigate(context);
    } else {
      BlocProvider.of<AuthCubit>(context).verifyEmail();
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.vreifyEmail,
        (route) => false,
      );
    }
  }
}
