import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';

class DocumentImageAndNumberAfterUpload extends StatelessWidget {
  const DocumentImageAndNumberAfterUpload({
    Key? key,
    this.color,
    this.status,
    required this.withState,
    required this.image,
    required this.numberOfDocument,
    required this.onTap,
    this.typeOfDocument,
  }) : super(key: key);
  final Color? color;
  final String? status;
  final bool withState;
  final String numberOfDocument;
  final String? typeOfDocument;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: withState == true
            ? Column(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  status ?? "",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(25)),
                                            child: Image.asset(
                                              image,
                                              fit: BoxFit.fill,
                                            ))),
                                    // Expanded(
                                    //     child: CircleAvatar(
                                    //   radius: 25,
                                    //   child: Text(
                                    //     numberOfDocument,
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .displayMedium!
                                    //         .copyWith(color: Colors.black),
                                    //   ),
                                    // )),
                                  ],
                                ),
                              ),
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

                                        )),
                                padding: EdgeInsets.only(left: 1.w),
                                width: MediaQuery.of(context).size.width * 0.30,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
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
              )
            : Column(
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
                                child: Text(numberOfDocument,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: Colors.white)))),
                      ),
                      Positioned(
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
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ));
  }
}