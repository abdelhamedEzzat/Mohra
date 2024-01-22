import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';

class AuditorCompanyDocuments extends StatelessWidget {
  const AuditorCompanyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Documents"),
        leading: BackButton(
          color: ColorManger.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Icon(
                    Icons.add_box_rounded,
                    size: 55.h,
                  )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Add Document Type',
                        style: Theme.of(context).textTheme.displayLarge,
                      ))
                ]),
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              // DocumentImageAndNumberAfterUpload(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushNamed(RouterName.auditorDocumentDetails);
              //   },
              //   withState: false,
              //   numberOfDocument: "4",
              //   image: ImageManger.decument,
              // ),
              // Divider(color: ColorManger.backGroundColorToSplashScreen),
              // DocumentImageAndNumberAfterUpload(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushNamed(RouterName.auditorDocumentDetails);
              //   },
              //   withState: false,
              //   numberOfDocument: "3",
              //   image: ImageManger.decument,
              // ),
              // Divider(color: ColorManger.backGroundColorToSplashScreen),
              // DocumentImageAndNumberAfterUpload(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushNamed(RouterName.auditorDocumentDetails);
              //   },
              //   withState: false,
              //   numberOfDocument: "2",
              //   image: ImageManger.decument,
              // ),
              // Divider(color: ColorManger.backGroundColorToSplashScreen),
              // DocumentImageAndNumberAfterUpload(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushNamed(RouterName.auditorDocumentDetails);
              //   },
              //   withState: false,
              //   numberOfDocument: "1",
              //   image: ImageManger.decument,
              // ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
            ],
          ),
        ),
      ),
    );
  }
}
