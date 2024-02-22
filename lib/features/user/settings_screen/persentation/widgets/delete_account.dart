// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mohra_project/core/routes/name_router.dart';
// import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
// import 'package:mohra_project/generated/l10n.dart';

// class DeleteAccount extends StatelessWidget {
//   const DeleteAccount({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         return GestureDetector(
//             onTap: () async {
//               // Show delete account confirmation dialog
//               bool deleteConfirmed =
//                   await showDeleteAccountConfirmationDialog(context);
//               if (deleteConfirmed) {
//                 // Delete account logic here
//                 BlocProvider.of<AuthCubit>(context).deleteAccount().then(
//                   (value) {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(FirebaseAuth.instance.currentUser!.uid)
//                         .delete();
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                       RouterName.registerScreen,
//                       (route) => false,
//                     );
//                   },
//                 );
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.delete,
//                   size: 24.h,
//                   color: Colors.red,
//                 ),
//                 title: Text(
//                   S.of(context).Delete,
//                   style: Theme.of(context)
//                       .textTheme
//                       .displayMedium!
//                       .copyWith(color: Colors.red),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }

// showDeleteAccountConfirmationDialog(BuildContext context) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Confirm Account Deletion"),
//         content: Text("Are you sure you want to delete your account?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(false); // No
//             },
//             child: Text("No"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true); // Yes
//             },
//             child: Text("Yes"),
//           ),
//         ],
//       );
//     },
//   );
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';
import 'package:mohra_project/generated/l10n.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            // BlocProvider.of<AuthCubit>(context).deleteAccount();
            final currentUser = FirebaseAuth.instance.currentUser;

            print(currentUser!.uid);
            try {
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                print(currentUser.uid);
                // Delete user document from Firestore
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .delete();

                await FirebaseAuth.instance.currentUser!.delete();

                // Navigate to RegisterScreen after successful deletion
                await Navigator.of(context).pushReplacementNamed(
                  RouterName.registerScreen,
                );
              } else {
                // Handle the case where currentUser is null
                print("No authenticated user found");
              }
            } catch (e) {
              // Handle any exceptions that occur during the deletion process
              print("Error deleting account: $e");
              // You can show an error message to the user if desired
            }
            // Delete user document from Firestore

            // Navigator.of(context).pushReplacementNamed(
            //   RouterName.registerScreen,
            //   //   (route) => false,
            // );

            // then(
            //   (value) {
            //     if (value) {
            //       Navigator.of(context).pushNamedAndRemoveUntil(
            //         RouterName.registerScreen,
            //         (route) => false,
            //       );
            //     }
            //   },
            // );

            // bool deleteConfirmed =
            //     await showDeleteAccountConfirmationDialog(context);
            // if (deleteConfirmed) {

            // }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: ListTile(
              leading: Icon(
                Icons.delete,
                size: 24.h,
                color: Colors.red,
              ),
              title: Text(
                S.of(context).Delete,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }
}

showDeleteAccountConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).ConfirmAccountDeletion),
        content: Text(S.of(context).Areyousureyouwanttodeleteyouraccount),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // No
            },
            child: Text(S.of(context).no),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Yes
            },
            child: Text(S.of(context).yes),
          ),
        ],
      );
    },
  );
}
