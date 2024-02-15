import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mohra_project/features/register_screen/data/user_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

int counter = 0;
DateTime now = DateTime.now();
Timestamp timestamp = Timestamp.fromDate(now);

String formattedStamp(timestamp) {
  var datefromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy hh:mm a').format(datefromTimeStamp);
}

const companyID = 2;
const docID = 2;
bool isCompanyDocument(String documentCompanyId, String documentId,
    Map<String, dynamic> companyData) {
  return documentCompanyId == companyData["companyID"];
}

class Constanscollection {
  Map<String, dynamic> companyData = {};

  static DocumentReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid);

  static CollectionReference<Map<String, dynamic>> companyCollection =
      FirebaseFirestore.instance.collection("Companys");

  static CollectionReference<Map<String, dynamic>> compnyDocument =
      FirebaseFirestore.instance.collection("Document");

  static var addInformationStaffToCompany = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Companys')
      .get();

  static Future<QuerySnapshot<Map<String, dynamic>>> getCompanyData() async {
    var addInformationStaffToCompany = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Companys')
        .get();

    return addInformationStaffToCompany;
  }

  static void updateUserStatus(int status) {
    final userStatusBox = Hive.box<UserStatusModel>('userStatusBox');
    final userStatus = UserStatusModel(emailStauts: status);
    userStatusBox.put('userStatus', userStatus);
  }

  static int getUserStatus() {
    final userStatusBox = Hive.box<UserStatusModel>('userStatusBox');
    final userStatus = userStatusBox.get('userStatus',
        defaultValue: UserStatusModel(emailStauts: 0));
    return userStatus!.emailStauts;
  }
}
