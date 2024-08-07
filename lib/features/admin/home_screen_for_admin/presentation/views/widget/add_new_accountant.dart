import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

class AddNewAccountant extends StatefulWidget {
  const AddNewAccountant({super.key});

  @override
  State<AddNewAccountant> createState() => _AddNewAuditorState();
}

class _AddNewAuditorState extends State<AddNewAccountant> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;
    return Scaffold(
      appBar: CustomAppBar(
          onPressed: () async {
            Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
          },
          title: Text(S.of(context).NewAccountant),
          leading: BackButton(
            color: Colors.white,
          )),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AddStaffLoading) {
            isLoading = true;
          } else if (state is AddStaffSuccess) {
            isLoading = false;
            // showSnackBarAndNavigate(context);
            // BlocProvider.of<AuthCubit>(context).verifyEmail();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: ColorManger.backGroundColorToSplashScreen
                      .withOpacity(0.8),
                  content: Text(
                    S.of(context).TheAccountantHasBeenAddedSuccessfully,
                  ),
                  duration: Duration(seconds: 2),
                ))
                .close;
            await Navigator.of(context).pushNamedAndRemoveUntil(
              RouterName.adminHomeScreen,
              (route) => false,
            );
          } else if (state is AddStafffaild) {
            isLoading = false;
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          return Center(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                margin: EdgeInsets.only(top: 31.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).Pleaseentersometext;
                            } else if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$')
                                .hasMatch(value)) {
                              return S.of(context).LattersOnly;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.firstName = value;
                          },
                          labelText:
                              S.of(context).firstnameLabelTextInRegisterScreen,
                          hintText:
                              S.of(context).nameHintTextInRegisterScreenFirst,
                          prefixIcon: const Icon(Icons.person)),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).Pleaseentersometext;
                            } else if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$')
                                .hasMatch(value)) {
                              return S.of(context).LattersOnly;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.lastName = value;
                          },
                          labelText:
                              S.of(context).lastnameLabelTextInRegisterScreen,
                          hintText:
                              S.of(context).nameHintTextInRegisterScreenLast,
                          prefixIcon: const Icon(Icons.person)),
                      CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).FeildRequierd;
                            } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                              return S
                                  .of(context)
                                  .Theemailmustcontainatleastoneletter;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.emailCubit = value;
                          },
                          labelText:
                              S.of(context).emailLabelTextInRegisterScreen,
                          hintText: S.of(context).emailHintTextInRegisterScreen,
                          prefixIcon: const Icon(Icons.email)),
                      CustomTextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).FeildRequierd;
                            } else if (!RegExp(
                                    r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).+$')
                                .hasMatch(value)) {
                              return S
                                  .of(context)
                                  .Passwordmustcontainnumberslettersandspecialcharacter;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.passwordCubit = value;
                          },
                          labelText:
                              S.of(context).passwordLabelTextInRegisterScreen,
                          hintText:
                              S.of(context).passwordHintTextInRegisterScreen,
                          prefixIcon: const Icon(Icons.lock)),
                      CustomButton(
                          nameOfButton: S.of(context).CreateAccount,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              formKey.currentState!.save();
                              await trigerCubit.staffAccontantSignUP(
                                email: trigerCubit.emailCubit,
                                password: trigerCubit.passwordCubit,
                              );
                            }
                          }),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// Future<void> showSnackBarAndNavigate(BuildContext context) async {
//   final completer = Completer<void>();

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: ColorManger.backGroundColorToSplashScreen,
//       content: Text(S.of(context).TheAccountantHasBeenAddedSuccessfully),
//       duration: Duration(seconds: 2),

//     ),
//   );

//   await completer.future; // Wait for the completer to complete

//   Navigator.of(context).pushNamedAndRemoveUntil(
//     RouterName.adminHomeScreen,
//     (route) => false,
//   );
// }
// }
  // Future<void> showSnackBarAndNavigate(BuildContext context) async {
  //   final completer = Completer<void>();

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: ColorManger.backGroundColorToSplashScreen,
  //       content: Text(S.of(context).TheAccountantHasBeenAddedSuccessfully),
  //       // duration: Duration(seconds: 2),
  //       action: SnackBarAction(
  //         label: 'Close',
  //         onPressed: () {
  //           completer
  //               .complete(); // Complete the future when the SnackBar action is pressed
  //         },
  //       ),
  //     ),
  //   );

  //   await completer.future; // Wait for the completer to complete

  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //     RouterName.adminHomeScreen,
  //     (route) => false,
  //   );
  // }
}
