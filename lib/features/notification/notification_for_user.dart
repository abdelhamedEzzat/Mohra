import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/notification/persrntation/views/widgets/notifcation_widget.dart';

class NotificationScreenForUser extends StatelessWidget {
  const NotificationScreenForUser({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userNotification = FirebaseFirestore.instance
        .collection('Companys')
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: userNotification,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var userData = snapshot.data!.docs[index];

                            var userCompanysId = userData['companyId'];

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Notification')
                                  .where('NotificationCompanyID',
                                      isEqualTo: userCompanysId)
                                  .where('role', isEqualTo: 'admin')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          CompanyNotificationForUser(
                                            normalText:
                                                snapshot.data.docs[index]
                                                    ['notificationMassage'],
                                            statusText: snapshot.data
                                                .docs[index]['MassgeSendBy'],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Container();
                    }))));
  }
}
