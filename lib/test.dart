// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mohra_project/core/routes/name_router.dart';

// class test extends StatelessWidget {
//   const test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: MaterialButton(
//             onPressed: () async {
//               // await FirebaseFirestore.instance
//               //     .collection('users')
//               //     .doc("1")
//               //     .collection("companys")
//               //     .doc("1")
//               //     .set(
//               //   {
//               //     "3": {"a": "1", "b": "4"}
//               //   },
//               //   // SetOptions(merge: true),
//               // );a

//               Navigator.of(context).pushNamed(RouterName.test2,
//                   arguments: "abdoooooooo" as String);
//             },
//             child: Text("dsfdsfdsfs"),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // static DocumentReference<Map<String, dynamic>> userCollection =
// //       FirebaseFirestore.instance
// //           .collection("users")
// //           .doc(FirebaseAuth.instance.currentUser!.uid);

// //   static DocumentReference<Map<String, dynamic>> companyCollection =
// //       userCollection.collection("Companys").doc();

// //   static CollectionReference<Map<String, dynamic>> compnyDocument =
// //       companyCollection.collection("Document");