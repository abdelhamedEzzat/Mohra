import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/notification/persrntation/views/widgets/notifcation_widget.dart';

class NotificationScreenForAdminAndUser extends StatelessWidget {
  const NotificationScreenForAdminAndUser({Key? key});

  @override
  Widget build(BuildContext context) {
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
        child: StreamBuilder(
          stream: usersNotification,
          builder: (BuildContext context, AsyncSnapshot userSnapshot) {
            if (userSnapshot.hasData) {
              return ListView.builder(
                itemCount: userSnapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var userRoleData = userSnapshot.data.docs[index];

                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Notification')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot notificationSnapshot) {
                      if (notificationSnapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Your user-related widget here

                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notificationSnapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CompanyNotificationForUser(
                                  normalText: notificationSnapshot
                                      .data.docs[index]['notificationMassage'],
                                  statusText: notificationSnapshot
                                      .data.docs[index]['MassgeSendBy'],
                                );
                              },
                            ),
                          ],
                        );
                      } else if (notificationSnapshot.hasError) {
                        print('Error getting notification from snapshot');
                      } else if (notificationSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox();
                    },
                  );
                },
              );
            } else if (userSnapshot.hasError) {
              print('Error getting user data from snapshot');
            } else if (userSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
