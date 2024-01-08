import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/core/constants/image_manger/image_manger.dart';
import 'package:mohra_project/core/helpers/custom_app_bar.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/user/company_documents/presentation/views/company_documents.dart';

class AccuntantCompanyDocuments extends StatelessWidget {
  const AccuntantCompanyDocuments({super.key});

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
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DocumentImageAndNumberAfterUpload(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouterName.accountantDocumentDetails);
                },
                withState: true,
                numberOfDocument: "4",
                image: ImageManger.decument,
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              DocumentImageAndNumberAfterUpload(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouterName.accountantDocumentDetails);
                },
                withState: true,
                numberOfDocument: "3",
                image: ImageManger.decument,
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              DocumentImageAndNumberAfterUpload(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouterName.accountantDocumentDetails);
                },
                withState: true,
                numberOfDocument: "2",
                image: ImageManger.decument,
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
              DocumentImageAndNumberAfterUpload(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouterName.accountantDocumentDetails);
                },
                withState: true,
                numberOfDocument: "1",
                image: ImageManger.decument,
              ),
              Divider(color: ColorManger.backGroundColorToSplashScreen),
            ],
          ),
        ),
      ),
    );
  }
}
