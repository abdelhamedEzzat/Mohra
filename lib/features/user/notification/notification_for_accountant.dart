import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/user/notification/persrntation/views/widgets/notifcation_widget.dart';

class NotificationScreenFormAccountant extends StatelessWidget {
  const NotificationScreenFormAccountant({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> companyNotification =
        FirebaseFirestore.instance.collection('Companys').snapshots();
    Stream<QuerySnapshot> usersNotification =
        FirebaseFirestore.instance.collection('users').snapshots();

    Stream<QuerySnapshot> Notification = FirebaseFirestore.instance
        .collection('Notification')
        .where('idUserMassge',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: companyNotification,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.90,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var companyData = snapshot.data!.docs[index];

                              return StreamBuilder<QuerySnapshot>(
                                stream: usersNotification,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.90,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var userRoleData =
                                              snapshot.data!.docs[index];

                                          return StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Notification')
                                                  .where(
                                                      'NotificationCompanyID',
                                                      isEqualTo: companyData[
                                                          'companyId'])
                                                  .where('MassgeSendBy',
                                                      isEqualTo: [
                                                    'AccountantReview',
                                                    'ManagerMassage'
                                                  ]).snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.98,
                                                    child: ListView.builder(
                                                      itemCount: snapshot
                                                          .data.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Column(
                                                          children: [
                                                            CompanyNotificationForUser(
                                                              normalText: snapshot
                                                                          .data
                                                                          .docs[
                                                                      index][
                                                                  'notificationMassage'],
                                                              statusText: snapshot
                                                                          .data
                                                                          .docs[
                                                                      index][
                                                                  'MassgeSendBy'],
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  print(
                                                      'error to get notification to snapShot');
                                                } else if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {}
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });
                                        },
                                      ),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Container();
                    }))));
  }
}

//
//
class NotificationScreenFormAuditor extends StatelessWidget {
  const NotificationScreenFormAuditor({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> companyNotification =
        FirebaseFirestore.instance.collection('Companys').snapshots();
    Stream<QuerySnapshot> usersNotification =
        FirebaseFirestore.instance.collection('users').snapshots();

    Stream<QuerySnapshot> Notification = FirebaseFirestore.instance
        .collection('Notification')
        .where('idUserMassge',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: companyNotification,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.90,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var companyData = snapshot.data!.docs[index];

                              return StreamBuilder<QuerySnapshot>(
                                stream: usersNotification,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.90,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var userRoleData =
                                              snapshot.data!.docs[index];

                                          return StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Notification')
                                                  .where(
                                                      'NotificationCompanyID',
                                                      isEqualTo: companyData[
                                                          'companyId'])
                                                  .where(
                                                    'MassgeSendBy',
                                                    isEqualTo: 'AuditorReview',
                                                    // 'ManagerMassage'
                                                  )
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.98,
                                                    child: ListView.builder(
                                                      itemCount: snapshot
                                                          .data.docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Column(
                                                          children: [
                                                            CompanyNotificationForUser(
                                                              normalText: snapshot
                                                                          .data
                                                                          .docs[
                                                                      index][
                                                                  'notificationMassage'],
                                                              statusText: snapshot
                                                                          .data
                                                                          .docs[
                                                                      index][
                                                                  'MassgeSendBy'],
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  print(
                                                      'error to get notification to snapShot');
                                                } else if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {}
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });
                                        },
                                      ),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Container();
                    }))));
  }
}
