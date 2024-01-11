// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/document_and_number_after_upload.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/widget/upload_documents.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';

class CompanyDocuments extends StatelessWidget {
  const CompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leading: BackButton(color: Colors.white),
          title: Text(
            "Company Documents",
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DetailsPeofileAndCompanyWidget(
                  profile: "Company Details",
                  key1: "Name :",
                  value1: "Company Name",
                  key2: "Address :",
                  value2: "Company Address ",
                  key3: "Type :",
                  value3: "Company Type ",
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.uploadDocuments);
                  },
                  child: const UploadDocumentsBotton(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Document :",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                DocumentImageAndNumberAfterUpload(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouterName.detailsDocuments);
                    },
                    numberOfDocument: "1",
                    image: ImageManger.decument,
                    withState: true,
                    color: ColorManger.darkGray,
                    status: "Waiting for the accountant's review"),
                DocumentImageAndNumberAfterUpload(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouterName.detailsDocuments);
                    },
                    numberOfDocument: "1",
                    image: ImageManger.decument,
                    withState: true,
                    color: ColorManger.acceptedCompanyStatus,
                    status: "accepted"),
              ],
            ),
          ),
        ));
  }
}










// class AddCompanyLogoWidget extends StatelessWidget {
//   const AddCompanyLogoWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryHeight = MediaQuery.of(context).size.height;
//     final mediaQueryWidth = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         SizedBox(
//           height: 15.h,
//         ),
//         const TitleOfFormCreateCompany(titleText: "Add Logo"),
//         SizedBox(
//           height: 5.h,
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: ColorManger.darkGray),
//                 borderRadius: BorderRadius.circular(25),
//                 color: ColorManger.white,
//               ),
//               margin: const EdgeInsets.only(top: 10),
//               width: mediaQueryWidth,
//               height: mediaQueryHeight * 0.20,
//               child: Center(
//                   child: Icon(
//                 Icons.add_photo_alternate_rounded,
//                 color: ColorManger.darkGray,
//                 size: 80.h,
//               ))),
//         ),
//       ],
//     );
//   }
// }















// class DocumentImageAndNumberAfterUpload extends StatelessWidget {
//   const DocumentImageAndNumberAfterUpload({
//     Key? key,
//     this.color,
//     this.status,
//     required this.withState,
//     required this.image,
//     required this.numberOfDocument,
//     required this.onTap,
//     this.typeOfDocument,
//   }) : super(key: key);
//   final Color? color;
//   final String? status;
//   final bool withState;
//   final String numberOfDocument;
//   final String? typeOfDocument;
//   final String image;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: onTap,
//         child: withState == true
//             ? Column(
//                 children: [
//                   Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.25,
//                       decoration: BoxDecoration(
//                           color: ColorManger.black,
//                           borderRadius: BorderRadius.circular(25)),
//                       child: Stack(
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 padding: EdgeInsets.only(left: 15.h),
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                     color: color,
//                                     borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(25),
//                                         topRight: Radius.circular(25))),
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.05,
//                                 child: Text(
//                                   status ?? "",
//                                   style:
//                                       Theme.of(context).textTheme.displaySmall,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Expanded(
//                                         flex: 4,
//                                         child: ClipRRect(
//                                             borderRadius:
//                                                 const BorderRadius.only(
//                                                     bottomLeft:
//                                                         Radius.circular(25)),
//                                             child: Image.asset(
//                                               image,
//                                               fit: BoxFit.fill,
//                                             ))),
//                                     // Expanded(
//                                     //     child: CircleAvatar(
//                                     //   radius: 25,
//                                     //   child: Text(
//                                     //     numberOfDocument,
//                                     //     style: Theme.of(context)
//                                     //         .textTheme
//                                     //         .displayMedium!
//                                     //         .copyWith(color: Colors.black),
//                                     //   ),
//                                     // )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 35.h,
//                             right: 0,
//                             bottom: 0,
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.black87.withOpacity(0.8),
//                                     borderRadius: const BorderRadius.only(
//                                         //   topLeft: Radius.circular(10),

//                                         )),
//                                 padding: EdgeInsets.only(left: 1.w),
//                                 width: MediaQuery.of(context).size.width * 0.30,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.065,
//                                 child: Center(
//                                     child: Text(typeOfDocument ?? "1",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .displayLarge!
//                                             .copyWith(color: Colors.white)))),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                 ],
//               )
//             : Column(
//                 children: [
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                           margin: EdgeInsets.only(top: 20.h),
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 0.25,
//                           decoration: BoxDecoration(
//                               color: ColorManger.black,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Expanded(
//                                         flex: 4,
//                                         child: ClipRRect(
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(25)),
//                                           child: Image.asset(
//                                             ImageManger.decument,
//                                             fit: BoxFit.fill,
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )),
//                       Positioned(
//                         top: 20.h,
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.black87.withOpacity(0.8),
//                                 borderRadius: const BorderRadius.only(
//                                   bottomRight: Radius.circular(10),
//                                   topLeft: Radius.circular(10),
//                                 )),
//                             padding: EdgeInsets.only(left: 1.w),
//                             width: MediaQuery.of(context).size.width * 0.15,
//                             height: MediaQuery.of(context).size.height * 0.055,
//                             child: Center(
//                                 child: Text(numberOfDocument,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge!
//                                         .copyWith(color: Colors.white)))),
//                       ),
//                       Positioned(
//                         top: 20.h,
//                         right: 0,
//                         bottom: 0,
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.black87.withOpacity(0.8),
//                                 borderRadius: const BorderRadius.only(
//                                   //   topLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                 )),
//                             padding: EdgeInsets.only(left: 1.w),
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             height: MediaQuery.of(context).size.height * 0.055,
//                             child: Center(
//                                 child: Text(typeOfDocument ?? "New",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .displayLarge!
//                                         .copyWith(color: Colors.white)))),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                 ],
//               ));
//   }
// }

// / StatusWidget