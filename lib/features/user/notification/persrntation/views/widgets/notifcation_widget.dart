import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/status_company.dart';

class CompanyNotificationForUser extends StatelessWidget {
  const CompanyNotificationForUser({
    super.key,
    required this.statusText,
    this.companyName,
    required this.normalText,
    this.boldText,
  });
  final String statusText;
  final String? companyName;
  final String normalText;
  final String? boldText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        StatusWidget(
          colorOfStatus: ColorManger.black,
          statusText: statusText,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                companyName ?? "",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: normalText,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: boldText,
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}
