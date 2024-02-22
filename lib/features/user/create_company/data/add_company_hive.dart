// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hive/hive.dart';

// part 'add_company_hive.g.dart';

// @HiveType(typeId: 2)
// class AddCompanyToHive extends HiveObject {
//   @HiveField(0)
//   late String logo;

//   @HiveField(1)
//   late String companyName;

//   @HiveField(2)
//   late String companyAddress;

//   @HiveField(3)
//   late String companyType;

//   @HiveField(4)
//   late String companyId;

//   @HiveField(5)
//   late String companyDocId;

//   @HiveField(6)
//   late String userID;

//   @HiveField(7)
//   late List additionalInformation;

//   @HiveField(8)
//   late String companyStatus;

//   @HiveField(9)
//   late String timesTamp;

//   AddCompanyToHive({
//     required this.logo,
//     required this.companyName,
//     required this.companyAddress,
//     required this.companyType,
//     required this.companyId,
//     required this.companyDocId,
//     required this.userID,
//     required this.additionalInformation,
//     required this.companyStatus,
//     required this.timesTamp,
//   });

//   // Define a factory method to convert Firestore snapshot to AddCompanyToHive
//   factory AddCompanyToHive.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return AddCompanyToHive(
//       logo: data['logo'],
//       companyName: data['company_Name'],
//       companyAddress: data['Company_Address'],
//       companyType: data['Company_type'],
//       companyId: data['companyId'],
//       companyDocId: data['companyDocId'],
//       userID: data['userID'],
//       additionalInformation: List.from(data['additionalInformation']),
//       companyStatus: data['CompanyStatus'],
//       timesTamp: data['timesTamp'],
//     );
//   }
//   static Future<List<AddCompanyToHive>> getCompaniesFromFirestore() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('companies').get();

//     List<AddCompanyToHive> companies = [];
//     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//       companies.add(AddCompanyToHive.fromSnapshot(doc));
//     }

//     return companies;
//   }

//   static Future<void> saveCompaniesLocally(
//       List<AddCompanyToHive> companies) async {
//     final box = await Hive.openBox<AddCompanyToHive>('companyBox');
//     await box.clear(); // Clear existing data
//     await box.addAll(companies);
//   }

//   static Future<Box<AddCompanyToHive>> getCompaniesLocally() async {
//     final box = await Hive.openBox<AddCompanyToHive>('companyBox');
//     return box;
//   }
// }
