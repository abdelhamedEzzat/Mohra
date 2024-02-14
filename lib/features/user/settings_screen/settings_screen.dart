import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/Language_wiget.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/delete_account.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/details_profile.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/log_out_Botton.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(
                      FirebaseAuth.instance.currentUser?.uid) // Null check here
                  .get(),
              builder: (context, snapshot) {
                Map<String, dynamic> userData = snapshot.data!.data() ?? {};
                String fullName = userData["fullName"] ?? "";
                String email = userData["email"] ?? "";
                return DetailsPeofileAndCompanyWidget(
                  profile: "Profile",
                  key1: "Name :",
                  value1: fullName,
                  key2: "Email :",
                  value2: email,
                );
              }),
          const LanguageWidget(),
          const SizedBox(
            height: 10,
          ),
          const LogOutBotton(),
          const SizedBox(
            height: 10,
          ),
          const DeleteAccount()
        ]),
      ),
    );
  }
}
