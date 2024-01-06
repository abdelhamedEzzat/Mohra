import 'package:flutter/material.dart';
import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/home_screen_for_user_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CompanyNotificationForUser(),
              DocumentNotificationsForUser(),
              DecumentNotificationForAcountant(),
              CompanyNotificationForAcountant(),
              AcceptedOrRejectedDocFromOuditorToAcountant(),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusWidget(
                        colorOfStatus: ColorManger.accountantNotification,
                        statusText: 'Accountant Notification',
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ListTile(
                            title: Text(
                              "DecumentName For Company Name",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            subtitle: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "Has Been Send to you",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.grey),
                              ),
                              TextSpan(
                                  text: " For audit",
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                            ]))),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AcceptedOrRejectedDocFromOuditorToAcountant extends StatelessWidget {
  const AcceptedOrRejectedDocFromOuditorToAcountant({
    super.key,
  });

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
          colorOfStatus: ColorManger.auditorNotification,
          statusText: 'Auditor Notification',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                "Document Name For  Company Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Has Been ",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: "Accepted",
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}

class CompanyNotificationForAcountant extends StatelessWidget {
  const CompanyNotificationForAcountant({
    super.key,
  });

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
          statusText: 'Company Notification',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                "Company Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Has Been ",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: "available to you",
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}

class DecumentNotificationForAcountant extends StatelessWidget {
  const DecumentNotificationForAcountant({
    super.key,
  });

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
          colorOfStatus: ColorManger.darkGray,
          statusText: 'ْDecument Notification',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                "Company Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Added Document for ",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: "review",
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}

class DocumentNotificationsForUser extends StatelessWidget {
  const DocumentNotificationsForUser({
    super.key,
  });

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
          colorOfStatus: ColorManger.darkGray,
          statusText: 'Document Notifications',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                "Document Name for  Company Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Your Document Has Been",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: " accepted",
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}

class CompanyNotificationForUser extends StatelessWidget {
  const CompanyNotificationForUser({
    super.key,
  });

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
          statusText: 'Company Notification',
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ListTile(
              title: Text(
                "CompanyName",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Your Company Has Been",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey),
                ),
                TextSpan(
                    text: " accepted",
                    style: Theme.of(context).textTheme.displaySmall),
              ]))),
        )
      ]),
    );
  }
}
