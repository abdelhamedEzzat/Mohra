// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/constans_collections/collections.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/add_Image_widget.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';

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
  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<FirebaseCreateCompanyCubit>(context);
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          "Create Company",
        ),
      ),
      body: Container(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<FirebaseCreateCompanyCubit,
              FirebaseCreateCompanyState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    const TitleOfFormCreateCompany(
                      titleText: "Add Logo",
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
                    const TitleOfFormCreateCompany(
                      titleText: "Company Name",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*this Field is Requierd';
                          } else if (!RegExp(r'^[a-zA-Z\s]+$')
                              .hasMatch(value)) {
                            return 'Please enter only letters.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          trigerCubit.companyName = value;
                        },
                        hintText: "Write Your Company Name",
                        prefixIcon: Icon(
                          Icons.post_add_rounded,
                          size: 25.h,
                        )),
                    //
                    //
                    SizedBox(
                      height: 10.h,
                    ),
                    const TitleOfFormCreateCompany(
                      titleText: "Company Adrdress",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*this Field is Requierd';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          trigerCubit.companyAddress = value;
                        },
                        hintText: "Write  Your Company Address",
                        prefixIcon: Icon(
                          Icons.location_searching,
                          size: 25.h,
                        )),
                    //
                    //
                    SizedBox(
                      height: 10.h,
                    ),
                    const TitleOfFormCreateCompany(
                      titleText: " Company Type",
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*this Field is Requierd';
                          } else if (!RegExp(r'^[a-zA-Z\s\W]+$')
                              .hasMatch(value)) {
                            return 'Please enter only letters.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          trigerCubit.companyType = value;
                        },
                        hintText: "Write  Your Company Type",
                        prefixIcon: Icon(
                          Icons.today_rounded,
                          size: 25.h,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(
                        nameOfButton: "Submit",
                        onTap: () async {
                          if (trigerCubit.file == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select an image.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            await trigerCubit
                                .addCompany(
                                    compnyCollectionID: compnyDocument,
                                    docid: docid,
                                    file: trigerCubit.file,
                                    companyName: trigerCubit.companyName,
                                    companyAddress: trigerCubit.companyAddress,
                                    companyType: trigerCubit.companyType)
                                .then((value) => counter++);

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
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
              'Choose how to upload the image',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
              builder: (context, state) {
                return Row(
                  children: [
                    ButtonInBottomSheet(
                        nameOfBotton: 'Camera',
                        icon: Icons.camera,
                        onPressed: onPressedForCamera),
                    // if (trigerCubit.file != null) Image.file(trigerCubit.file!),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonInBottomSheet(
                      nameOfBotton: 'Galarey',
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
