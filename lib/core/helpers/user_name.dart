import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohra_project/features/register_screen/presentation/manger/signUp_cubit/auth_cubit.dart';

class GetNameForUser extends StatelessWidget {
  const GetNameForUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        User? user = FirebaseAuth.instance.currentUser;
        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid) // Null check here
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Return a loading indicator or a placeholder while waiting for the data.
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            } else if (snapshot.hasError) {
              // Handle the error case.
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data == null || !snapshot.data!.exists) {
              // Handle the case where the document does not exist or data is null.
              return Text("User data not available");
            } else {
              // Access the data from the snapshot.
              Map<String, dynamic> userData = snapshot.data!.data() ?? {};
              String firstName = userData["first_Name"] ?? "";

              return Text(
                "Hello: $firstName",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              );
            }
          },
        );
      },
    );
  }
}
