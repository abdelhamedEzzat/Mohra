// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/search_screen/search_screen_for_user.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/add_Image_widget.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';
import 'package:mohra_project/generated/l10n.dart';

class CreateCompany extends StatefulWidget {
  const CreateCompany({super.key});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

GlobalKey<FormState> formKey = GlobalKey();

class _CreateCompanyState extends State<CreateCompany> {
  String compnyDocument = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Document")
      .doc()
      .id;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<FirebaseCreateCompanyCubit>(context);
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBarForUsers(
        leading: const BackButton(color: Colors.white),
        title: Text(
          S.of(context).CreateCompanys,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
          ),
          child: SingleChildScrollView(
            child: BlocConsumer<FirebaseCreateCompanyCubit,
                FirebaseCreateCompanyState>(
              listener: (context, state) {
                if (state is FirestoreStoragefaild) {
                  print(state.error);
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      TitleOfFormCreateCompany(
                        titleText: S.of(context).AddLogo,
                      ),
                      AddImageWidget(
                        ontap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return ShowModelBottomSheet(
                                onPressedForCamera: () async {
                                  await trigerCubit.getFilesFromCamera();
                                  trigerCubit.isIcon = true;
                                  Navigator.pop(context);
                                },
                                onPressedForGalarey: () async {
                                  //
                                  await trigerCubit.getimagefromGallery();
                                  trigerCubit.isIcon = true;
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        image: trigerCubit.file == null
                            ? Image.asset(ImageManger.mohraLogo)
                            : ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                child: Image.file(
                                  trigerCubit.file!,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      TitleOfFormCreateCompany(
                        titleText: S.of(context).CompanyName,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).FeildRequierd;
                            } else if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$')
                                .hasMatch(value)) {
                              // The regex pattern now includes Arabic letters from \u0600 to \u06FF
                              return S.of(context).LattersOnly;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.companyName = value;
                          },
                          hintText: S.of(context).hintNameCompany,
                          prefixIcon: Icon(
                            Icons.post_add_rounded,
                            size: 25.h,
                          )),
                      //
                      //
                      SizedBox(
                        height: 10.h,
                      ),
                      TitleOfFormCreateCompany(
                        titleText: S.of(context).CompanyAdrdress,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).FeildRequierd;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.companyAddress = value;
                          },
                          hintText: S.of(context).hintAddressCompany,
                          prefixIcon: Icon(
                            Icons.location_searching,
                            size: 25.h,
                          )),
                      //
                      //
                      SizedBox(
                        height: 10.h,
                      ),
                      TitleOfFormCreateCompany(
                        titleText: S.of(context).CompanyType,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).FeildRequierd;
                            } else if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$')
                                .hasMatch(value)) {
                              // The regex pattern now includes Arabic letters from \u0600 to \u06FF
                              return S.of(context).LattersOnly;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            trigerCubit.companyType = value;
                          },
                          hintText: S.of(context).hintCompanyType,
                          prefixIcon: Icon(
                            Icons.today_rounded,
                            size: 25.h,
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                          nameOfButton: S.of(context).Submit,
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await Future.delayed(const Duration(seconds: 2));
                            // if (trigerCubit.file == null) {
                            //   setState(() {
                            //     isLoading =
                            //         false; // Set isLoading to false here
                            //   });
                            //   // ignore: use_build_context_synchronously
                            //   // ScaffoldMessenger.of(context).showSnackBar(
                            //   //   SnackBar(
                            //   //     // ignore: use_build_context_synchronously
                            //   //     content: Text(S.of(context).MustSelectImage),
                            //   //     duration: const Duration(seconds: 2),
                            //   //   ),
                            //   // );

                            //   await trigerCubit.addCompany(
                            //       compnyCollectionID: compnyDocument,
                            //       // docid: docid,
                            //       file: trigerCubit.file,
                            //       companyName: trigerCubit.companyName,
                            //       companyAddress: trigerCubit.companyAddress,
                            //       companyType: trigerCubit.companyType);

                            //   // ignore: use_build_context_synchronously
                            //   await trigerCubit.addCompanyToHive(
                            //       file: trigerCubit.file,
                            //       companyAddress: trigerCubit.companyAddress,
                            //       companyName: trigerCubit.companyName,
                            //       companyType: trigerCubit.companyType,
                            //       logo: trigerCubit.url.toString());
                            // }

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              await trigerCubit.addCompany(
                                  compnyCollectionID: compnyDocument,
                                  // docid: docid,
                                  file: trigerCubit.file,
                                  //  ?? trigerCubit.filebase,
                                  companyName: trigerCubit.companyName,
                                  companyAddress: trigerCubit.companyAddress,
                                  companyType: trigerCubit.companyType);

                              // ignore: use_build_context_synchronously
                              // await trigerCubit.addCompanyToHive(
                              //     file: trigerCubit.file,
                              //     companyAddress: trigerCubit.companyAddress,
                              //     companyName: trigerCubit.companyName,
                              //     companyType: trigerCubit.companyType,
                              //     logo: trigerCubit.url.toString());

                              Navigator.of(context).pop();

                              trigerCubit.clearData();
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ShowModelBottomSheet extends StatelessWidget {
  const ShowModelBottomSheet({
    super.key,
    required this.onPressedForCamera,
    required this.onPressedForGalarey,
  });
  final void Function() onPressedForCamera;
  final void Function() onPressedForGalarey;
  @override
  Widget build(BuildContext context) {
    // final trigerCubit = BlocProvider.of<FirebaseCreateCompanyCubit>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      height: 120.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              S.of(context).chooseHowUploadImage,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
              builder: (context, state) {
                return Row(
                  children: [
                    ButtonInBottomSheet(
                        nameOfBotton: S.of(context).Camera,
                        icon: Icons.camera,
                        onPressed: onPressedForCamera),
                    // if (trigerCubit.file != null) Image.file(trigerCubit.file!),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonInBottomSheet(
                      nameOfBotton: S.of(context).Galarey,
                      icon: Icons.folder,
                      onPressed: onPressedForGalarey,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ButtonInBottomSheet extends StatelessWidget {
  const ButtonInBottomSheet({
    super.key,
    required this.nameOfBotton,
    required this.icon,
    this.onPressed,
  });
  final String nameOfBotton;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(children: [
          Expanded(
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(nameOfBotton,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ]),
      ),
    );
  }
}
