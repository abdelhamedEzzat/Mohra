// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mohra_project/core/constants/color_manger/color_manger.dart';
// import 'package:mohra_project/core/helpers/snackBar.dart';
// import 'package:mohra_project/core/routes/name_router.dart';
// import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

// class CheckUserStatusScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//         future: getUserCollection(context),
//         initialData: null, // Set initialData to null
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             if (snapshot.hasData) {
//               var userStatusFireBase = snapshot.data!.data();
//               if (userStatusFireBase != null &&
//                   userStatusFireBase['role'] == 'Admin') {
//                 Navigator.of(context)
//                     .pushReplacementNamed(RouterName.adminHomeScreen);
//               }
//               //
//               //
//               else if (userStatusFireBase != null &&
//                   userStatusFireBase['role'] == 'user') {
//                 if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                   BlocProvider.of<AuthCubit>(context).verifyEmail();
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.vreifyEmail);
//                 } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                   if (userStatusFireBase['Status'] == 1) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) =>
//                         showSnackBar(context,
//                             "Congratulations, your email has been authenticated and your data will be reviewed by the administration within 24 hours.",
//                             backgroundcolor:
//                                 ColorManger.backGroundColorToSplashScreen,
//                             duration: const Duration(seconds: 1)));
//                   } else if (userStatusFireBase['Status'] == 2) {
//                     Navigator.of(context)
//                         .pushReplacementNamed(RouterName.homeScreenForUser);
//                   }
//                 }
//               }
//               //
//               //
//               else if (userStatusFireBase != null &&
//                   userStatusFireBase['role'] == 'Auditor') {
//                 if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                   BlocProvider.of<AuthCubit>(context).verifyEmail();
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.vreifyEmail);
//                 } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.auditorHomeScreen);
//                 }
//                 //
//                 //
//               } else if (userStatusFireBase != null &&
//                   userStatusFireBase['role'] == 'Accountant') {
//                 if (!FirebaseAuth.instance.currentUser!.emailVerified) {
//                   BlocProvider.of<AuthCubit>(context).verifyEmail();
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.vreifyEmail);
//                 } else if (FirebaseAuth.instance.currentUser!.emailVerified) {
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouterName.accountantHomeScreen);
//                 }
//               }
//             }
//          }return conta //
//           //
//         }
        
//         );
//   }

//   // Rest of your code...

//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserCollection(
//       context) async {
//     final currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser != null) {
//       final userCollection = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(currentUser.uid)
//           .get();

//       return userCollection;
//     } else {
//       // Handle the case where the current user is null
//       Navigator.of(context).pushReplacementNamed(RouterName.registerScreen);
//       return Future.error("Welcome"); // You can return an error if needed
//     }
//   }
// }
