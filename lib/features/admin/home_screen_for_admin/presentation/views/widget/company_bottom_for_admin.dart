import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/create_company/presentation/manger/firebase_company/create_company_cubit.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/status_company.dart';

class CompanyButtonForAdmin extends StatelessWidget {
  const CompanyButtonForAdmin({
    super.key,
    this.colorOfStatus,
    this.statusText,
    required this.companyName,
    this.logoCompany,
    required this.withStatus,
    required this.onTap,
    //  required this.onTap,
  });
  final Color? colorOfStatus;
  final String? statusText;
  final String companyName;
  final String? logoCompany;
  final bool withStatus;
  final void Function()? onTap;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child:

            //
            //   this for company name and button in user home screen
            //    this container with Status
            //

            BlocBuilder<FirebaseCreateCompanyCubit, FirebaseCreateCompanyState>(
          builder: (context, state) {
            return Stack(
              children: [
                StatusWidget(
                    colorOfStatus: colorOfStatus, statusText: statusText ?? ""),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: ColorManger.backGroundColorToSplashScreen
                            .withOpacity(0.1),
                      ),
                      height: MediaQuery.of(context).size.height * 0.13,
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 25.h),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                companyName,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 12.w, top: 6.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: CircleAvatar(
                                  maxRadius: 25.h,
                                  minRadius: 21.h,
                                  child: Image.network(
                                    logoCompany ?? "No Image",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // ),
              ],
            );
          },
        )

        //
        //   this for company name and button in user home screen
        //    this container with Status
        //

        );
  }
}