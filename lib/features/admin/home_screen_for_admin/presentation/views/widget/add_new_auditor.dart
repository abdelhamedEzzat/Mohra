import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/helpers/snackBar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

import '../../../../../../core/helpers/custom_app_bar.dart';

class AddNewAuditor extends StatefulWidget {
  const AddNewAuditor({super.key});

  @override
  State<AddNewAuditor> createState() => _AddNewAuditorState();
}

GlobalKey<FormState> formKey = GlobalKey();

class _AddNewAuditorState extends State<AddNewAuditor> {
  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<AuthCubit>(context);
    bool isLoading = false;
    return Scaffold(
      appBar: CustomAppBar(
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.searchScreenForAdmin);
          },
          title: Text(S.of(context).NewAuditor),
          leading: const BackButton(
            color: Colors.white,
          )),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            isLoading = true;
          } else if (state is SignupSuccess) {
            isLoading = false;

            // BlocProvider.of<AuthCubit>(context).verifyEmail();
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouterName.adminHomeScreen,
              (route) => false,
            );
            // Navigator.of(context)
            //     .pushReplacementNamed(RouterName.adminHomeScreen);
          } else if (state is Signupfaild) {
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
                            } else if (!RegExp(r'^[a-zA-Z\s]+$')
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
                          hintText: S.of(context).nameHintTextInRegisterScreen,
                          prefixIcon: const Icon(Icons.person)),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).Pleaseentersometext;
                            } else if (!RegExp(r'^[a-zA-Z\s]+$')
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
                          hintText: S.of(context).nameHintTextInRegisterScreen,
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
                              await trigerCubit.userSignUP(
                                email: trigerCubit.emailCubit,
                                password: trigerCubit.passwordCubit,
                              );
                            }
                            await trigerCubit.addAuditor(
                                email: trigerCubit.emailCubit,
                                firstName: trigerCubit.firstName,
                                lastName: trigerCubit.lastName);

                            // await trigerCubit.getUserdata();
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
}










//  CustomTextFormField(
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Please enter some text.';
//                                         } else if (!RegExp(r'^[a-zA-Z\s]+$')
//                                             .hasMatch(value)) {
//                                           return 'Please enter only letters.';
//                                         }
//                                         return null;
//                                       },
//                                       onChanged: (value) {
//                                         trigerCubit.firstName = value;
//                                       },
//                                       labelText: S
//                                           .of(context)
//                                           .nameLabelTextInRegisterScreen,
//                                       hintText: S
//                                           .of(context)
//                                           .nameHintTextInRegisterScreen,
//                                       prefixIcon: const Icon(Icons.person)),
//                                   //
//                                   //
//                                   //
//                                   CustomTextFormField(
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Please enter some text.';
//                                         } else if (!RegExp(r'^[a-zA-Z\s]+$')
//                                             .hasMatch(value)) {
//                                           return 'Please enter only letters.';
//                                         }
//                                         return null;
//                                       },
//                                       onChanged: (value) {
//                                         trigerCubit.lastName = value;
//                                       },
//                                       labelText: S
//                                           .of(context)
//                                           .nameLabelTextInRegisterScreen,
//                                       hintText: S
//                                           .of(context)
//                                           .nameHintTextInRegisterScreen,
//                                       prefixIcon: const Icon(Icons.person)),
//                                   //
//                                   //
//                                   //