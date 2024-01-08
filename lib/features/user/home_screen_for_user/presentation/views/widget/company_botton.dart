import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/status_company.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key,
    this.colorOfStatus,
    this.statusText,
    required this.companyName,
    required this.logoCompany,
    required this.withStatus,
    required this.onTap,
    //  required this.onTap,
  });
  final Color? colorOfStatus;
  final String? statusText;
  final String companyName;
  final String logoCompany;
  final bool withStatus;
  final void Function()? onTap;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: withStatus == true
          ? Stack(
              children: [
                StatusWidget(
                    colorOfStatus: colorOfStatus, statusText: statusText ?? ""),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black12,
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        companyName,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: 30.h,
                      child: Image.asset(logoCompany),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              margin: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black12,
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    companyName,
                    style: Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: CircleAvatar(
                    radius: 30.h,
                    child: Image.asset(logoCompany),
                  ),
                ),
              ),
            ),
    );
  }
}
