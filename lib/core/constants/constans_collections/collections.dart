import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

String docid = uuid.v4();

int counter = 0;

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
      userCollection.collection("Companys");

  static CollectionReference<Map<String, dynamic>> compnyDocument =
      userCollection.collection("Document");
}
