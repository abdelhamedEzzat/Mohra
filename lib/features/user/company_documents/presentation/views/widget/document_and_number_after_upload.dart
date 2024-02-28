// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/features/user/upload_document/presentation/manger/upload_documents/upload_documents_cubit.dart';

class DocumentImageAndNumberWithoutState extends StatelessWidget {
  const DocumentImageAndNumberWithoutState({
    Key? key,
    this.color,
    this.status,
    required this.withState,
    this.numberOfDocument,
    this.typeOfDocument,
    required this.isimage,
    required this.onTap,
    required this.pdfFileExtention,
    required this.pdfFileName,
    required this.ontapForNavToDetailsScreen,
  }) : super(key: key);
  final Color? color;
  final String? status;
  final String? typeOfDocument;
  final bool withState;
  final String? numberOfDocument;

  final String? isimage;
  final void Function()? onTap;
  final String pdfFileExtention;
  final String pdfFileName;
  final void Function()? ontapForNavToDetailsScreen;
  @override
  Widget build(BuildContext context) {
    //  final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20.h),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        color: ColorManger.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    child: Image.asset(
                                      ImageManger.decument,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 20.h,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.8),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )),
                      padding: EdgeInsets.only(left: 1.w),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: Center(
                          child: Text(numberOfDocument ?? "1",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Colors.white)))),
                ),
                GestureDetector(
                  onTap: ontapForNavToDetailsScreen,
                  child: Positioned(
                    top: 20.h,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              //   topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        padding: EdgeInsets.only(left: 1.w),
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Center(
                            child: Text(typeOfDocument ?? "New",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: Colors.white)))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ));
  }
}

class ImageDocWidget extends StatelessWidget {
  const ImageDocWidget(
      {super.key,
      required this.color,
      required this.docImage,
      required this.status,
      required this.onTap,
      required this.typeOfDocument,
      required this.ontapForNavToDetailsScreen});
  final Color color;
  final String? status;
  final void Function()? ontapForNavToDetailsScreen;
  final String? typeOfDocument;
  final void Function()? onTap;
  final String? docImage;
  @override
  Widget build(BuildContext context) {
    //   final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: ColorManger.black,
                  borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //  alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color ?? ColorManger.darkGray,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          status ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24)),
                                  child: Image.network(
                                    // trigerCubit.url.toString(),
                                    docImage.toString(),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 35.h,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: ontapForNavToDetailsScreen,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  //   topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(25))),
                          padding: EdgeInsets.only(left: 1.w),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: Center(
                              child: Text(typeOfDocument ?? "1",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.white)))),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}

class FilesDocWidget extends StatelessWidget {
  const FilesDocWidget({
    super.key,
    required this.pdfFileExtention,
    required this.pdfFileName,
    required this.color,
    required this.status,
    required this.typeOfDocument,
    this.onTap,
  });
  final void Function()? onTap;
  final String pdfFileExtention;
  final String pdfFileName;
  final Color? color;
  final String? status;
  final String? typeOfDocument;

  @override
  Widget build(BuildContext context) {
    final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: ColorManger.black,
                  borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        //alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          status ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorManger.slogenColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25))),
                                    height: MediaQuery.of(context).size.height,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: ColorManger.darkGray,
                                          maxRadius: 28.h,
                                          minRadius: 22.h,
                                          child: Text(
                                            pdfFileExtention,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            pdfFileName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge!
                                                .copyWith(color: Colors.white),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    )))
                          ],
                        ),
                      ),
                      //      Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     BlocBuilder<UploadDocumentsCubit, UploadDocumentsState>(
                      //         builder: (context, state) {
                      //       if (trigerCubit.filePlatforme != null &&
                      //           trigerCubit.imagefile == null) {
                      //         if (trigerCubit.filePlatforme!.extension == 'jpg' ||
                      //             trigerCubit.filePlatforme!.extension == 'jpeg' ||
                      //             trigerCubit.filePlatforme!.extension == 'JPG' ||
                      //             trigerCubit.filePlatforme!.extension == 'JPEG') {
                      //           return AddImageWidget(
                      //             image: ClipRRect(
                      //               borderRadius:
                      //                   const BorderRadius.all(Radius.circular(24)),
                      //               child: Image.file(
                      //                 File(trigerCubit.filePlatforme!.path
                      //                     .toString()),
                      //                 fit: BoxFit.fitWidth,
                      //               ),
                      //             ),
                      //           );
                      //         } else if (trigerCubit.imagefile != null &&
                      //             trigerCubit.filePlatforme == null) {
                      //           return Expanded(
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Expanded(
                      //                     flex: 4,
                      //                     child: Container(
                      //                         decoration: BoxDecoration(
                      //                             color: ColorManger.slogenColor,
                      //                             borderRadius:
                      //                                 const BorderRadius.only(
                      //                                     bottomLeft:
                      //                                         Radius.circular(25),
                      //                                     bottomRight:
                      //                                         Radius.circular(25))),
                      //                         height: MediaQuery.of(context)
                      //                             .size
                      //                             .height,
                      //                         child: Row(
                      //                           children: [
                      //                             SizedBox(
                      //                               width: 10.w,
                      //                             ),
                      //                             CircleAvatar(
                      //                               backgroundColor:
                      //                                   ColorManger.darkGray,
                      //                               maxRadius: 28.h,
                      //                               minRadius: 22.h,
                      //                               child: Text(
                      //                                 pdfFileExtention,
                      //                                 style: Theme.of(context)
                      //                                     .textTheme
                      //                                     .displayLarge!
                      //                                     .copyWith(
                      //                                         color: Colors.white),
                      //                               ),
                      //                             ),
                      //                             SizedBox(
                      //                               width: 10.w,
                      //                             ),
                      //                             SizedBox(
                      //                               width: 200.w,
                      //                               child: Text(
                      //                                 pdfFileName,
                      //                                 style: Theme.of(context)
                      //                                     .textTheme
                      //                                     .displayLarge!
                      //                                     .copyWith(
                      //                                         color: Colors.white),
                      //                                 maxLines: 3,
                      //                                 overflow:
                      //                                     TextOverflow.ellipsis,
                      //                               ),
                      //                             )
                      //                           ],
                      //                         )))
                      //               ],
                      //             ),
                      //           );
                      //         }
                      //       }
                      //     }

                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                  Positioned(
                    top: 35.h,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                                //   topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(25))),
                        padding: EdgeInsets.only(left: 1.w),
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.065,
                        child: Center(
                            child: Text(typeOfDocument ?? "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: Colors.white)))),
                  ),
                ],
              )),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}

class DocumentForAuditor extends StatelessWidget {
  const DocumentForAuditor(
      {super.key,
      required this.color,
      this.docImage,
      required this.status,
      required this.onTap,
      required this.typeOfDocument,
      required this.ontapForNavToDetailsScreen});
  final Color color;
  final String? status;
  final void Function()? ontapForNavToDetailsScreen;
  final String? typeOfDocument;
  final void Function()? onTap;
  final String? docImage;
  @override
  Widget build(BuildContext context) {
    //   final trigerCubit = BlocProvider.of<UploadDocumentsCubit>(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: ColorManger.black,
                  borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Text(
                          status ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // padding: EdgeInsets.only(left: 15.h),
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child:

                              //  Expanded(child: Container(
                              //   width: MediaQuery.of(context).size.width,

                              //   child: Text("asdsadasd")))
                              Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24)),
                                    child: Image.network(
                                      // trigerCubit.url.toString(),
                                      docImage.toString(),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 35.h,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: ontapForNavToDetailsScreen,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  //   topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(25))),
                          padding: EdgeInsets.only(left: 1.w),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: Center(
                              child: Text(typeOfDocument ?? "1",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.white)))),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
