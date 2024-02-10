import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/notification/persrntation/views/widgets/notifcation_widget.dart';

class NotificationScreenFromAccountant extends StatelessWidget {
  const NotificationScreenFromAccountant({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> staffNotification = FirebaseFirestore.instance
        .collection('Staff')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: staffNotification,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var staffData = snapshot.data!.docs[index];

                            var staffCompanyId = staffData['CompanyId'];

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Notification')
                                  .where('NotificationCompanyID',
                                      isEqualTo: staffCompanyId)
                                  .where('MassgeSendBy',
                                      isEqualTo: 'AccountantReview')
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
                                      var userRoleData =
                                          snapshot.data!.docs[index];

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

class NotificationScreenFormAuditor extends StatelessWidget {
  const NotificationScreenFormAuditor({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> staffNotification = FirebaseFirestore.instance
        .collection('Staff')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: staffNotification,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var staffData = snapshot.data!.docs[index];
                            var staffuserid = staffData['userid'];
                            var staffCompanyId = staffData['CompanyId'];

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Notification')
                                  .where('NotificationCompanyID',
                                      isEqualTo: staffCompanyId)
                                  .where('MassgeSendBy', whereIn: [
                                'AuditorReview',
                                'UserNotification'
                              ]).snapshots(),
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
                                      var userRoleData =
                                          snapshot.data!.docs[index];

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
//  SingleChildScrollView(
            //     child: StreamBuilder<QuerySnapshot>(
            //         stream: companyNotification,
            //         builder: (BuildContext context, AsyncSnapshot snapshot) {
            //           if (snapshot.hasData) {
            //             return Container(
            //               height: MediaQuery.of(context).size.height * 0.90,
            //               width: MediaQuery.of(context).size.width,
            //               child: ListView.builder(
            //                 itemCount: snapshot.data.docs.length,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   var companyData = snapshot.data!.docs[index];

            //                   return StreamBuilder<QuerySnapshot>(
            //                     stream: usersNotification,
            //                     builder: (BuildContext context,
            //                         AsyncSnapshot snapshot) {
            //                       if (snapshot.hasData) {
            //                         return Container(
            //                           height:
            //                               MediaQuery.of(context).size.height *
            //                                   0.90,
            //                           width: MediaQuery.of(context).size.width,
            //                           child: ListView.builder(
            //                             itemCount: snapshot.data.docs.length,
            //                             itemBuilder:
            //                                 (BuildContext context, int index) {
            //                               var userRoleData =
            //                                   snapshot.data!.docs[index];

            //                               return StreamBuilder(
            //                                   stream: FirebaseFirestore.instance
            //                                       .collection('Notification')
            //                                       .where(
            //                                           'NotificationCompanyID',
            //                                           isEqualTo: companyData[
            //                                               'companyId'])
            //                                       .where(
            //                                         'MassgeSendBy',
            //                                         isEqualTo: 'AuditorReview',
            //                                         // 'ManagerMassage'
            //                                       )
            //                                       .snapshots(),
            //                                   builder: (BuildContext context,
            //                                       AsyncSnapshot snapshot) {
            //                                     if (snapshot.hasData) {
            //                                       return SizedBox(
            //                                         width:
            //                                             MediaQuery.of(context)
            //                                                 .size
            //                                                 .width,
            //                                         height:
            //                                             MediaQuery.of(context)
            //                                                     .size
            //                                                     .height *
            //                                                 0.98,
            //                                         child: ListView.builder(
            //                                           itemCount: snapshot
            //                                               .data.docs.length,
            //                                           itemBuilder:
            //                                               (BuildContext context,
            //                                                   int index) {
            //                                             return Column(
            //                                               children: [
            //                                                 CompanyNotificationForUser(
            //                                                   normalText: snapshot
            //                                                               .data
            //                                                               .docs[
            //                                                           index][
            //                                                       'notificationMassage'],
            //                                                   statusText: snapshot
            //                                                               .data
            //                                                               .docs[
            //                                                           index][
            //                                                       'MassgeSendBy'],
            //                                                 )
            //                                               ],
            //                                             );
            //                                           },
            //                                         ),
            //                                       );
            //                                     } else if (snapshot.hasError) {
            //                                       print(
            //                                           'error to get notification to snapShot');
            //                                     } else if (snapshot
            //                                             .connectionState ==
            //                                         ConnectionState.waiting) {}
            //                                     return const Center(
            //                                       child:
            //                                           CircularProgressIndicator(),
            //                                     );
            //                                   });
            //                             },
            //                           ),
            //                         );
            //                       }
            //                       return CircularProgressIndicator();
            //                     },
            //                   );
            //                 },
            //               ),
            //             );
            //           } else if (snapshot.hasError) {
            //             return Text('Error: ${snapshot.error}');
            //           }
            //           return Container();
            //         }))
  //  Column(
            //   children: [
            //     CompanyNotificationForUser(
            //       normalText: "you Aded to Amazon compant to be Auditor to it ",
            //       statusText: 'Admin',
            //     ),
            //     CompanyNotificationForUser(
            //       normalText: "Sent to You Doc in amazon campany to review it ",
            //       statusText: 'Accountant',
            //     )
            //   ],
            // )
            // return StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection('Notification')
//         .where(
//             'NotificationCompanyID',
//             isEqualTo: companyData[
//                 'companyId'])
//         .where('MassgeSendBy',
//             isEqualTo: [
//           'Auditor',
//           'ManagerMassage'
//         ]).snapshots(),
//     builder: (BuildContext context,
//         AsyncSnapshot snapshot) {
//       if (snapshot.hasData) {
//         return SizedBox(
//           width:
//               MediaQuery.of(context)
//                   .size
//                   .width,
//           child:
//            ListView.builder(
//             shrinkWrap: true,
//             physics:
//                 NeverScrollableScrollPhysics(),
//             itemCount: snapshot
//                 .data.docs.length,
//             itemBuilder:
//                 (BuildContext context,
//                     int index) {
//   },
// ),
//         );
//       } else if (snapshot.hasError) {
//         print(
//             'error to get notification to snapShot');
//       } else if (snapshot
//               .connectionState ==
//           ConnectionState.waiting) {}
//       return const Center(
//         child:
//             CircularProgressIndicator(),
//       );
//     });
//
//