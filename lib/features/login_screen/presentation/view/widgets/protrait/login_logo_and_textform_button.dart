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
import 'package:mohra_project/features/login_screen/presentation/view/widgets/forget_password.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/if_didnt_have_account.dart';
import 'package:mohra_project/features/login_screen/presentation/view/widgets/login_account_text.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
import 'package:mohra_project/generated/l10n.dart';

class LoginLogoAndTextFieldAndbuttonProtrait extends StatelessWidget {
  const LoginLogoAndTextFieldAndbuttonProtrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          handleEmailVerification(context);
          Navigator.of(context)
              .pushReplacementNamed(RouterName.adminHomeScreen);
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
                                    obscureText: true,
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
                                    prefixIcon: const Icon(Icons.lock)),
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
                                    onTap: () {},
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

  Future<void> checkEmailAndNavigate(context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .get();

        String emailStatus = userData["Email_status"] ?? "";
        String role = userData["role"] ?? "";

        if (emailStatus.toLowerCase() == "enabled") {
          if (role == 'User') {
            Navigator.of(context)
                .pushReplacementNamed(RouterName.homeScreenForUser);
          } else if (role == 'Auditor') {
            Navigator.of(context)
                .pushReplacementNamed(RouterName.auditorHomeScreen);
          } else if (role == 'Accountant') {
            Navigator.of(context)
                .pushReplacementNamed(RouterName.accountantHomeScreen);
          }
        }
      }
    } catch (e) {
      print("Error checking email status: $e");
    }
  }

  void handleEmailVerification(context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      checkEmailAndNavigate(context);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouterName.vreifyEmail,
        (route) => false,
      );
    }
  }
}




// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
// import 'package:mohra_project/core/constants/constans_collections/collections.dart';
// import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
// import 'package:mohra_project/core/helpers/custom_button.dart';
// import 'package:mohra_project/core/helpers/custom_button_with_icon_or_image.dart';
// import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
// import 'package:mohra_project/core/helpers/snackBar.dart';
// import 'package:mohra_project/core/routes/name_router.dart';
// import 'package:mohra_project/features/login_screen/presentation/view/widgets/forget_password.dart';
// import 'package:mohra_project/features/login_screen/presentation/view/widgets/if_didnt_have_account.dart';
// import 'package:mohra_project/features/login_screen/presentation/view/widgets/login_account_text.dart';
// import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
// import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
// import 'package:mohra_project/generated/l10n.dart';

// class LoginLogoAndTextFieldAndbuttonProtrait extends StatefulWidget {
//   const LoginLogoAndTextFieldAndbuttonProtrait({
//     super.key,
//   });

//   @override
//   State<LoginLogoAndTextFieldAndbuttonProtrait> createState() =>
//       _LoginLogoAndTextFieldAndbuttonProtraitState();
// }

// class _LoginLogoAndTextFieldAndbuttonProtraitState
//     extends State<LoginLogoAndTextFieldAndbuttonProtrait> {
//   //
//   GlobalKey<FormState> formKey = GlobalKey();

//   final _userStatusController = StreamController<int>();
//   // Stream<int> get userStatusStream => _userStatusController.stream;
//   // int status = Constanscollection.getUserStatus();
//   // Future<void> checkUserStatus() async {
//   //   status = Constanscollection.getUserStatus();
//   //   _userStatusController.add(status);
//   // } // checkUserStatus();

//   @override
//   void initState() {
//     super.initState();
//     // checkUserStatus();
//   }

//   // Future<DocumentSnapshot<Map<String, dynamic>>> userCollection =
//   //     FirebaseFirestore.instance
//   //         .collection("users")
//   //         .doc(FirebaseAuth.instance.currentUser!.uid)
//   //         .get();
//   @override
//   Widget build(BuildContext context) {
//     GlobalKey<FormState> formKey = GlobalKey();
//     final trigerCubit = BlocProvider.of<AuthCubit>(context);
//     bool isLoading = false;

//     return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
//       if (state is LoginLoading) {
//         isLoading = true;
//       } else if (state is LoginSuccess) {
//         isLoading = false;

//         User? user = FirebaseAuth.instance.currentUser;
//         var kk = FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .get()
//             .then((DocumentSnapshot documentSnapshot) {
//           if (documentSnapshot.exists) {
//             if (documentSnapshot.get('role') == "admin") {
//               Navigator.of(context)
//                   .pushReplacementNamed(RouterName.adminHomeScreen);
//             } else if (documentSnapshot.get('role') == "user") {
//               if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                 BlocProvider.of<AuthCubit>(context).verifyEmail();
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.vreifyEmail);
//               } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                 if (documentSnapshot.get('status') == 1) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
//                       context,
//                       "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
//                       backgroundcolor:
//                           ColorManger.backGroundColorToSplashScreen,
//                       duration: const Duration(seconds: 1)));
//                 } else if (documentSnapshot.get('status') == 2) {
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.homeScreenForUser);
//                 }
//               }
//             } else if (documentSnapshot != null &&
//                 documentSnapshot.get('role') == 'Auditor') {
//               if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                 BlocProvider.of<AuthCubit>(context).verifyEmail();
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.vreifyEmail);
//               } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.auditorHomeScreen);
//               }
//               //
//               //
//             } else if (documentSnapshot != null &&
//                 documentSnapshot.get('role') == 'Accountant') {
//               if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                 BlocProvider.of<AuthCubit>(context).verifyEmail();
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.vreifyEmail);
//               } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.accountantHomeScreen);
//               }
//             }
//           }
//         });
//       } else if (state is Loginfaild) {
//         isLoading = false;
//         showSnackBar(context, state.error);
//       }
//     }, builder: (context, state) {
//       return Container(
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 25,
//         ),
//         child: Center(
//             child: ModalProgressHUD(
//           inAsyncCall: isLoading,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 ImageManger.mohraLogo,
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               ClassMorphismInsideScreen(
//                 blur: 20,
//                 opacity: 0.5,
//                 child: SingleChildScrollView(
//                   child: Container(
//                       margin: const EdgeInsets.only(
//                         right: 8,
//                         left: 8,
//                       ),
//                       padding: const EdgeInsets.only(
//                           top: 20, bottom: 20, right: 10, left: 10),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const LoginAccountText(),
//                               const SizedBox(
//                                 height: 8,
//                               ),

//                               //
//                               //   TextFormField fo email

//                               CustomTextFormField(
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "* this Field is required You must enter data";
//                                     }
//                                     return null;
//                                   },
//                                   onChanged: (value) {
//                                     trigerCubit.emailCubit = value;
//                                   },
//                                   labelText: S
//                                       .of(context)
//                                       .emailLabelTextInRegisterScreen,
//                                   hintText: S
//                                       .of(context)
//                                       .emailHintTextInRegisterScreen,
//                                   prefixIcon: const Icon(Icons.email)),

//                               //
//                               //   TextFormField fo password

//                               CustomTextFormField(
//                                   obscureText: true,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "* this Field is required You must enter data";
//                                     }
//                                     return null;
//                                   },
//                                   onChanged: (value) {
//                                     trigerCubit.passwordCubit = value;
//                                   },
//                                   labelText: S
//                                       .of(context)
//                                       .passwordLabelTextInRegisterScreen,
//                                   hintText: S
//                                       .of(context)
//                                       .passwordHintTextInRegisterScreen,
//                                   prefixIcon: const Icon(Icons.lock)),
//                               //
//                               //this widget for forget password

//                               const ForgetPassword(),

//                               //
//                               //
//                               CustomButton(
//                                   nameOfButton:
//                                       S.of(context).loginAccountBotton,
//                                   onTap: () async {
//                                     if (formKey.currentState!.validate()) {
//                                       formKey.currentState!.save();
//                                       //
//                                       // this function for  user sign in

//                                       await trigerCubit.userSignin(
//                                           context: context,
//                                           email: trigerCubit.emailCubit,

//                                           //
//                                           // this function for get user data

//                                           password: trigerCubit.passwordCubit);
//                                       await trigerCubit.getUserdata();
//                                       // Constanscollection.updateUserStatus(2);
//                                     }
//                                   }),

//                               //
//                               // this function for sign in with google

//                               CustomBottonWithIconOrImage(
//                                   onTap: () {},
//                                   imageIconButton: ImageManger.googleLogo,
//                                   nameOfButton:
//                                       S.of(context).loginAccountBottonByGoogle),

//                               //
//                               //this function for goto signup screen

//                               const IfYouDidntHaveAccount()
//                             ]),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         )),
//       );
//     });
//   }
// }
