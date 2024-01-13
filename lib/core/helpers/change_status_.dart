// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mohra_project/features/register_screen/presentation/view/register_screen.dart';
// import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/home_screen_for_user.dart';

// class ChangeState extends StatefulWidget {
//   const ChangeState({super.key});

//   @override
//   State<ChangeState> createState() => _ChangeStateState();
// }

// class _ChangeStateState extends State<ChangeState> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.active) {
//             FirebaseAuth.instance.currentUser?.reload();
//             if (snapshot.hasData && snapshot.data!.emailVerified) {
//               return const HomeScreenForUser();
//             } else {
//               return const RegisterScreen();
//             }
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Text("Error occured"),
//             );
//           }
//           return Container();
//         });
//   }
// }
