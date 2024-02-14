// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
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
  bool isdesapled = false;
  Timer _timer = Timer(Duration.zero, () {});
  @override
  void initState() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.reload();
        if (user.emailVerified) {
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            checkEmail(); // قم بتنفيذ الوظيفة التي تريدها هنا
          });
          WidgetsBinding.instance
              .addPostFrameCallback((_) => showEmailVerifiedSnackBar(context));
        } else {
          showWelcomeSnackBar(context);
        }
      }
    } catch (e) {
      print("Error in initState: $e");
    }
    super.initState();
  }

  void dispose() {
    _timer.cancel(); // للتأكد من إلغاء الـ Timer عند إغلاق الصفحة
    super.dispose();
  }

  void didChangeDependencies() {
    // Perform cleanup operations here before the widget is disposed.
    // This is where you can add the cleanup code that was in initState
    super.didChangeDependencies();
  }

  void showEmailVerifiedSnackBar(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(user.uid)
          .get();

      String emailStatus = userData["Email_status"];
      if (emailStatus == "disabled") {
        isdesapled = true;
        return showSnackBar(
          context,
          "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours you cant do anythink after accepted. ",
          backgroundcolor: ColorManger.backGroundColorToSplashScreen,
          duration: const Duration(days: 1),
        );
      } else {
        return;
      }
    }
  }

  void showWelcomeSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
        context, "Welcome ,You Must Verify your email login Now ",
        backgroundcolor: ColorManger.backGroundColorToSplashScreen,
        duration: const Duration(seconds: 15)));
  }

  Future<void> checkEmail() async {
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
          setState(() {
            isdesapled == true;
          });
        } else if (emailStatus.toLowerCase() == "enabled" && status == "2") {
          print(status);
          Navigator.of(context)
              .pushReplacementNamed(RouterName.homeScreenForUser);
          setState(() {
            isdesapled == false;
          });
          print(emailStatus);
        }
      }
    } catch (e) {
      print("Error checking email status: $e");
    }
  }

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
          listener: (context, state) async {
            if (state is SignupLoading) {
              isLoading = true;
            } else if (state is SignupSuccess) {
              if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                Navigator.of(context)
                    .pushReplacementNamed(RouterName.vreifyEmail);
              }
              isLoading = false;
            } else if (state is Signupfaild) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
              ));

              showSnackBar(context, state.error);
            } else if (state is AuthLoading) {
              isLoading = true;
            } else if (state is AuthAuthenticated) {
              // User? user = FirebaseAuth.instance.currentUser;
              // await FirebaseFirestore.instance
              //     .collection("users")
              //     .doc(user!.uid)
              //     .update({
              //   "status": "1",
              // });
              checkEmail();
            } else if (state is AuthUnauthenticated) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
              ));
            }
            ;
          },
          builder: (context, state) {
            return Center(
                child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: AbsorbPointer(
                absorbing: isdesapled,
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
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            await trigerCubit.userSignUP(
                                              email: trigerCubit.emailCubit,
                                              password:
                                                  trigerCubit.passwordCubit,
                                            );
                                          }
                                          await trigerCubit.addUser(
                                              email: trigerCubit.emailCubit,
                                              firstName: trigerCubit.firstName,
                                              lastName: trigerCubit.lastName);

                                          BlocProvider.of<AuthCubit>(context)
                                              .verifyEmail();

                                          await trigerCubit.getUserdata();
                                        }),

                                    //
                                    //
                                    //
                                    CustomBottonWithIconOrImage(
                                        onTap: () async {
                                          await trigerCubit.signInWithGoogle();

                                          final user = trigerCubit.user;

                                          if (user != null) {
                                            await trigerCubit
                                                .storeUserInfoInFirestore(user);
                                            showEmailVerifiedSnackBar(context);
                                          }
                                        },
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
              ),
            ));
          },
        ));
  }
}





// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
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
// import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
// import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism_Inside_screen.dart';
// import 'package:mohra_project/features/register_screen/presentation/view/widgets/register_account_text.dart';
// import 'package:mohra_project/features/register_screen/presentation/view/widgets/user_have_account.dart';
// import 'package:mohra_project/generated/l10n.dart';

// class LogoAndTextFieldAndbuttonProtrait extends StatefulWidget {
//   const LogoAndTextFieldAndbuttonProtrait({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<LogoAndTextFieldAndbuttonProtrait> createState() =>
//       _LogoAndTextFieldAndbuttonProtraitState();
// }

// class _LogoAndTextFieldAndbuttonProtraitState
//     extends State<LogoAndTextFieldAndbuttonProtrait> {
//   // int status = Constanscollection.getUserStatus();
//   GlobalKey<FormState> formKey = GlobalKey();
//   final _userStatusController = StreamController<int>();
//   Stream<int> get userStatusStream => _userStatusController.stream;
//   @override
//   void initState() {
//     super.initState();

//     // print(Constanscollection.getUserStatus());
//   }

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<String> getEmailStatusStream(String userId) {
//     return _firestore
//         .collection('users')
//         .doc(userId)
//         .snapshots()
//         .map((snapshot) {
//       var emailStatus = snapshot.data()?['Email_status'];
//       return emailStatus ?? 'disabled';
//     });
//   }

//   // Future<DocumentSnapshot<Map<String, dynamic>>> getUserCollection(
//   //     context) async {
//   //   final currentUser = FirebaseAuth.instance.currentUser;

//   //   if (currentUser != null) {
//   //     final userCollection = await FirebaseFirestore.instance
//   //         .collection("users")
//   //         .doc(currentUser.uid)
//   //         .get();

//   //     return userCollection;
//   //   } else {
//   //     // Handle the case where the current user is null
//   //     Navigator.of(context).pushReplacementNamed(RouterName.registerScreen);
//   //     return Future.error("Welcome"); // You can return an error if needed
//   //   }
//   // }

//   Stream<DocumentSnapshot<Map<String, dynamic>>> usersInfo = FirebaseFirestore
//       .instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .snapshots();

//   @override
//   Widget build(BuildContext context) {
//     final trigerCubit = BlocProvider.of<AuthCubit>(context);
//     bool isLoading = false;
//     return Container(
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 25,
//         ),
//         child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
//           if (state is SignupLoading) {
//             isLoading = true;
//           } else if (state is SignupSuccess) {
//             isLoading = false;
//           } else if (state is Signupfaild) {
//             isLoading = false;
//             showSnackBar(context, state.error);
//           }
//         }, builder: (context, state) {
//           return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//               stream: usersInfo,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   var user = snapshot.data!.data() as Map<String, dynamic>;
//                   var emailStatus = user['Email_status'];
//                   if (emailStatus == 'enabled') {
//                     Navigator.of(context)
//                         .pushReplacementNamed(RouterName.homeScreenForUser);
//                   } else if (emailStatus == 'disabled') {
//                     if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                       WidgetsBinding.instance.addPostFrameCallback((_) =>
//                           showSnackBar(context,
//                               "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
//                               backgroundcolor:
//                                   ColorManger.backGroundColorToSplashScreen,
//                               duration: const Duration(days: 1)));
//                     } else {
//                       Navigator.of(context)
//                           .pushReplacementNamed(RouterName.vreifyEmail);
//                     }
//                   }

//                   return Center(
//                       child: ModalProgressHUD(
//                     inAsyncCall: isLoading,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           ImageManger.mohraLogo,
//                         ),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         ClassMorphismInsideScreen(
//                             blur: 20,
//                             opacity: 0.5,
//                             child: Container(
//                               height: 400.h,
//                               margin: const EdgeInsets.only(
//                                 right: 8,
//                                 left: 8,
//                               ),
//                               padding: const EdgeInsets.only(
//                                   top: 20, bottom: 20, right: 10, left: 10),
//                               child: SingleChildScrollView(
//                                 child: Form(
//                                   key: formKey,
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const RegisterAccountText(),
//                                         const SizedBox(
//                                           height: 8,
//                                         ),
//                                         CustomTextFormField(
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return 'Please enter some text.';
//                                               } else if (!RegExp(
//                                                       r'^[a-zA-Z\s]+$')
//                                                   .hasMatch(value)) {
//                                                 return 'Please enter only letters.';
//                                               }
//                                               return null;
//                                             },
//                                             onChanged: (value) {
//                                               trigerCubit.firstName = value;
//                                             },
//                                             labelText: S
//                                                 .of(context)
//                                                 .firstnameLabelTextInRegisterScreen,
//                                             hintText: S
//                                                 .of(context)
//                                                 .nameHintTextInRegisterScreen,
//                                             prefixIcon:
//                                                 const Icon(Icons.person)),
//                                         //
//                                         //
//                                         //
//                                         CustomTextFormField(
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return 'Please enter some text.';
//                                               } else if (!RegExp(
//                                                       r'^[a-zA-Z\s]+$')
//                                                   .hasMatch(value)) {
//                                                 return 'Please enter only letters.';
//                                               }
//                                               return null;
//                                             },
//                                             onChanged: (value) {
//                                               trigerCubit.lastName = value;
//                                             },
//                                             labelText: S
//                                                 .of(context)
//                                                 .lastnameLabelTextInRegisterScreen,
//                                             hintText: S
//                                                 .of(context)
//                                                 .nameHintTextInRegisterScreen,
//                                             prefixIcon:
//                                                 const Icon(Icons.person)),
//                                         //
//                                         //
//                                         //

//                                         //
//                                         //
//                                         CustomTextFormField(
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return "* this Field is required You must enter data";
//                                               } else if (!RegExp(r'[a-zA-Z]')
//                                                   .hasMatch(value)) {
//                                                 return "The email must contain at least one letter.";
//                                               }
//                                               return null;
//                                             },
//                                             onChanged: (value) {
//                                               trigerCubit.emailCubit = value;
//                                             },
//                                             //

//                                             //
//                                             labelText: S
//                                                 .of(context)
//                                                 .emailLabelTextInRegisterScreen,
//                                             hintText: S
//                                                 .of(context)
//                                                 .emailHintTextInRegisterScreen,
//                                             prefixIcon:
//                                                 const Icon(Icons.email)),
//                                         //
//                                         //
//                                         CustomTextFormField(
//                                             obscureText: true,
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return "* this Field is required You must enter data";
//                                               } else if (!RegExp(
//                                                       r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).+$')
//                                                   .hasMatch(value)) {
//                                                 return "Password must contain  numbers, letters, and special character.";
//                                               }
//                                               return null;
//                                             },
//                                             onChanged: (value) {
//                                               trigerCubit.passwordCubit = value;
//                                             },
//                                             //
//                                             //
//                                             labelText: S
//                                                 .of(context)
//                                                 .passwordLabelTextInRegisterScreen,
//                                             hintText: S
//                                                 .of(context)
//                                                 .passwordHintTextInRegisterScreen,
//                                             prefixIcon: const Icon(Icons.lock)),
//                                         //
//                                         //
//                                         //

//                                         CustomButton(
//                                             nameOfButton: S
//                                                 .of(context)
//                                                 .registerAccountBotton,
//                                             onTap: () async {
//                                               if (formKey.currentState!
//                                                   .validate()) {
//                                                 formKey.currentState!.save();
//                                                 await trigerCubit.userSignUP(
//                                                   email: trigerCubit.emailCubit,
//                                                   password:
//                                                       trigerCubit.passwordCubit,
//                                                 );
//                                               }
//                                               await trigerCubit.verifyEmail();

//                                               await trigerCubit.addUser(
//                                                   email: trigerCubit.emailCubit,
//                                                   firstName:
//                                                       trigerCubit.firstName,
//                                                   lastName:
//                                                       trigerCubit.lastName);

//                                               await trigerCubit.getUserdata();
//                                             }),

//                                         //
//                                         //
//                                         //
//                                         CustomBottonWithIconOrImage(
//                                             onTap: () {},
//                                             imageIconButton:
//                                                 ImageManger.googleLogo,
//                                             nameOfButton: S
//                                                 .of(context)
//                                                 .registerAccountBottonByGoogle),
//                                         //
//                                         //
//                                         //
//                                         const UserIfAlreadyHaveAccount()
//                                       ]),
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
//                   ));
//                 }
//               });
//         }));
//   }
// }
//   // if (status == 1) {
//                 //   WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar(
//                 //       context,
//                 //       "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
//                 //       backgroundcolor:
//                 //           ColorManger.backGroundColorToSplashScreen,
//                 //       duration: const Duration(seconds: 1)));
//                 // } else if (status == 2) {
//                 //   return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 //     future: getUserCollection(context),
//                 //     // Set initialData to null
//                 //     builder: (context, snapshot) {
//                 //       if (snapshot.hasData) {
//                 //         var userStatusFireBase = snapshot.data!.data();

//                 //         //
//                 //         //
//                 //         if (userStatusFireBase != null &&
//                 //             userStatusFireBase['role'] == 'user') {
//                 //           if (!FirebaseAuth
//                 //               .instance.currentUser!.emailVerified) {
//                 //             BlocProvider.of<AuthCubit>(context).verifyEmail();
//                 //             Navigator.of(context)
//                 //                 .pushReplacementNamed(RouterName.vreifyEmail);
//                 //           } else if (FirebaseAuth
//                 //               .instance.currentUser!.emailVerified) {
//                 //             if (userStatusFireBase['Status'] == 1) {
//                 //               WidgetsBinding.instance.addPostFrameCallback(
//                 //                   (_) => showSnackBar(context,
//                 //                       "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
//                 //                       backgroundcolor: ColorManger
//                 //                           .backGroundColorToSplashScreen,
//                 //                       duration: const Duration(seconds: 1)));
//                 //             } else if (userStatusFireBase['Status'] == 2) {
//                 //               Navigator.of(context).pushReplacementNamed(
//                 //                   RouterName.homeScreenForUser);
//                 //             }
//                 //           }
//                 //         }
//                 //         //
//                 //         //
//                 //       }
//                 //       return Container();
//                 //     },
//                 //   );
//                 // }

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
              //       String status = userData["status"] ?? "";

              //       if (emailStatus.toLowerCase() == "enabled" && status == 2) {
              //         Navigator.of(context)
              //             .pushReplacementNamed(RouterName.homeScreenForUser);
              //       }
              //     }
              //     return false;
              //   } catch (e) {
              //     print("Error checking email status: $e");
              //     return false;
              //   }
              // }