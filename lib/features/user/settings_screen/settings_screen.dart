import 'package:flutter/material.dart';
import 'package:mohra_project/features/user/settings_screen/persentation/widgets/Language_wiget.dart';
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
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsPeofileAndCompanyWidget(
                profile: "Profile",
                key1: "Name :",
                value1: "Abdelhameed Ezzat ",
                key2: "Email :",
                value2: "amAbdo@gmail.com ",
              ),
              LanguageWidget(),
              SizedBox(
                height: 10,
              ),
              LogOutBotton()
            ]),
      ),
    );
  }
}
