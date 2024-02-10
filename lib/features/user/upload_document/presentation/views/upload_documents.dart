// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/helpers/custom_button.dart';
import 'package:mohra_project/core/helpers/custom_text_form_field.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/create_company.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/add_Image_widget.dart';
import 'package:mohra_project/features/user/create_company/presentation/views/widget/title_of_form_create_company.dart';
import 'package:mohra_project/features/user/upload_document/presentation/manger/upload_documents/upload_documents_cubit.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);
    var companyId = ModalRoute.of(context)?.settings.arguments;
    bool isLoading = false;
    return Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            Navigator.of(context).pushNamed(RouterName.searchScreenForUser);
          },
          leading: const BackButton(color: Colors.white),
          title: const Text(
            "Upload Documents",
          ),
        ),
        body: SizedBox(
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: BlocConsumer<UploadDocumentsCubit, UploadDocumentsState>(
              listener: (context, state) {
            if (state is UploadDocumentfaild) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
              isLoading = false;
              print(state.error);
            } else if (state is UploadDocumentLoading) {
              isLoading = true;
            } else if (state is UploadDocumentSuccess) {
              isLoading = false;
            }
          }, builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: mediaQueryHeight * 0.85,
                width: mediaQueryWidth,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: mediaQueryHeight * 0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        const TitleOfFormCreateCompany(
                            titleText: "Upload Documents"),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                //   trigerCubit.clearData();
                                return ShowModelBottomSheet(
                                  onPressedForCamera: () async {
                                    await trigerCubit.openCameraAndShowImage();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  },
                                  onPressedForGalarey: () async {
                                    await trigerCubit.uploadFile();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          child: BlocBuilder<UploadDocumentsCubit,
                              UploadDocumentsState>(
                            builder: (context, state) {
                              if (trigerCubit.filePlatforme != null &&
                                  trigerCubit.imagefile == null) {
                                return AddImageWidget(
                                  image: Container(
                                      //   margin: EdgeInsets.only(bottom: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.black12,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w, top: 10.h),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 12.w),
                                              child: Text(
                                                "${trigerCubit.filePlatforme!.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.w),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(75),
                                                child: CircleAvatar(
                                                  backgroundColor: ColorManger
                                                      .backGroundColorToSplashScreen,
                                                  maxRadius: 28.h,
                                                  minRadius: 22.h,
                                                  child: Text(
                                                    "${trigerCubit.filePlatforme!.extension}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              } else if (trigerCubit.imagefile != null &&
                                  trigerCubit.filePlatforme == null) {
                                return AddImageWidget(
                                  image: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
                                    child: Image.file(
                                      trigerCubit.imagefile!,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                );
                              } else {
                                return AddImageWidget(
                                    image: Container(
                                        //   margin: EdgeInsets.only(bottom: 10.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.black12,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w, top: 10.h),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.asset(
                                            ImageManger.addCompanyLogo)));

                                //;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const TitleOfFormCreateCompany(titleText: "Comments"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Form(
                          key: formKey,
                          child: CustomTextFormField(
                            onChanged: (value) {
                              trigerCubit.comment = value;
                            },
                            min: 1,
                            max: 2,
                            hight: mediaQueryHeight * 0.08,
                            hintText: "Add any Comment Here",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Icon(
                                Icons.comment,
                                size: 25.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomButton(
                          nameOfButton: "Submit",
                          onTap: () async {
                            if (trigerCubit.filePlatforme != null) {
                              await trigerCubit.pickFile(
                                  docNumber: trigerCubit.docNumber++,
                                  // fileExtention: trigerCubit.file!.extension,
                                  companydocID: companyId as String,
                                  file: trigerCubit.files!,
                                  filename: trigerCubit.fileName,
                                  comment: trigerCubit.comment);
                              Navigator.of(context).pop(
                                trigerCubit.comment,
                              );
                            } else if (trigerCubit.imagefile != null) {
                              await trigerCubit
                                  .uploadImageAndAddInfoToFirestore(
                                      docNumber: trigerCubit.docNumber++,
                                      companydocID: companyId as String,
                                      comment: trigerCubit.comment);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop(
                                trigerCubit.comment,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      ColorManger.backGroundColorToSplashScreen,
                                  content: const Text("Upload any Document"),
                                ),
                              );
                            }
                            trigerCubit.clearData();
                            await FirebaseFirestore.instance
                                .collection('Notification')
                                .add({
                              'notificationMassage':
                                  "user in  $companyId add document number ${trigerCubit.fileName} to revjon",
                              'role': 'user',
                              'NotificationCompanyID': companyId,
                              'NotificationUserID':
                                  FirebaseAuth.instance.currentUser!.uid,
                              // 'idUserMassge': sttafuserID,
                              'MassgeSendBy': 'UserNotification',
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
