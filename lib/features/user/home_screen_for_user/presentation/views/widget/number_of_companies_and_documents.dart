import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mohra_project/features/user/home_screen_for_user/presentation/views/widget/icon_and_text_company.dart';
import 'package:mohra_project/generated/l10n.dart';

class NumberOfCompaniesAndDocuments extends StatelessWidget {
  const NumberOfCompaniesAndDocuments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Companys')
              .where('userID',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return IconsAndTextToCompany(
                numberOfCompany: snapshot.data!.docs.length,
                text: S.of(context).Companies,
              );
            } else {
              return const CircularProgressIndicator(
                color: Colors.black,
              );
            }
          }),
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Companys')
            .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(color: Colors.black);
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<String> companyId = snapshot.data?.docs.map((doc) {
                return doc['companyId'] as String;
              }).toList() ??
              [];
          print(companyId);

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Document')
                  .where('companydocID', whereIn: companyId)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot docSnapshot) {
                if (docSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: Colors.black);
                }

                if (docSnapshot.hasError) {
                  return Text('Error: ${docSnapshot.error}');
                }
                print(
                  docSnapshot.data!.docs.length,
                );

                return IconsAndTextToCompany(
                  numberOfCompany: docSnapshot.data!.docs.length ?? 0,
                  text: S.of(context).Documents,
                );
              },
            );
          } else {
            return IconsAndTextToCompany(
              numberOfCompany: 0,
              text: S.of(context).Documents,
            );
          }
        },
      )
    ]);
  }
}
