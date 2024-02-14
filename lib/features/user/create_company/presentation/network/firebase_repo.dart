import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class Company {
  final String logo;
  final String companyName;
  final String companyAddress;
  final String companyType;
  final String companyId;
  final String companyDocId;
  final String userId;
  final String additionalInformation;
  final String companyStatus;
  final String timestamp;

  Company({
    this.logo = '',
    this.companyName = '',
    this.companyAddress = '',
    this.companyType = '',
    this.companyId = '',
    this.companyDocId = '',
    this.userId = '',
    this.additionalInformation = '',
    this.companyStatus = '',
    this.timestamp = '',
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      logo: json['logo'] ?? '',
      companyName: json['company_Name'] ?? '',
      companyAddress: json['Company_Address'] ?? '',
      companyType: json['Company_type'] ?? '',
      companyId: json['companyId'] ?? '',
      companyDocId: json['companyDocId'] ?? '',
      userId: json['userID'] ?? '',
      additionalInformation: json['additionalInformation'] ?? '',
      companyStatus: json['CompanyStatus'] ?? '',
      timestamp: json['timesTamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'company_Name': companyName,
      'Company_Address': companyAddress,
      'Company_type': companyType,
      'companyId': companyId,
      'companyDocId': companyDocId,
      'userID': userId,
      'additionalInformation': additionalInformation,
      'CompanyStatus': companyStatus,
      'timesTamp': timestamp,
    };
  }
}

class CompanyRepository {
  final CollectionReference _companyCollection =
      FirebaseFirestore.instance.collection('companies');

  Future<void> addCompany(Company company, String url) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final timestamp = DateTime.now();
        final companyData = {
          'logo': url,
          'company_Name': company.companyName,
          'Company_Address': company.companyAddress,
          'Company_type': company.companyType,
          'companyId': company.companyId,
          'companyDocId': company.companyDocId,
          'userID': currentUser.uid,
          'additionalInformation': company.additionalInformation,
          'CompanyStatus': "Waiting for Accepted",
          'timesTamp': Timestamp.fromDate(timestamp),
        };
        await _companyCollection.add(companyData);
      } else {
        throw Exception("User not signed in");
      }
    } catch (e) {
      throw Exception("Failed to add company: $e");
    }
  }

  Future<void> deleteCompany(String companyId) async {
    try {
      await _companyCollection
          .where('companyId', isEqualTo: companyId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.delete();
        });
      });
    } catch (e) {
      throw Exception("Failed to delete company: $e");
    }
  }

  Stream<List<Company>> getCompanies() async* {
    final localRepository = LocalCompanyRepository();
    final localCompanies = await localRepository.getCompanies();

    if (localCompanies.isNotEmpty) {
      yield localCompanies; // Emit local data
    } else {
      final firebaseCompanies = await _fetchCompaniesFromFirebase();
      yield firebaseCompanies; // Emit data fetched from Firebase
    }
  }

  Future<List<Company>> _fetchCompaniesFromFirebase() async {
    try {
      final querySnapshot = await _companyCollection
          .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      final firebaseCompanies = querySnapshot.docs
          .map((doc) => Company.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Save fetched data locally
      final localRepository = LocalCompanyRepository();
      firebaseCompanies.forEach((company) async {
        await localRepository.addCompany(company);
      });

      return firebaseCompanies;
    } catch (e) {
      print('Failed to get companies from Firebase: $e');
      return [];
    }
  }
}

class LocalCompanyRepository {
  final String _boxName = 'companyBox';

  Future<void> addCompany(Company company) async {
    try {
      final box = await Hive.openBox<Company>(_boxName);
      await box.add(company);
      await box.close();
    } catch (e) {
      throw Exception("Failed to add company locally: $e");
    }
  }

  Future<void> deleteCompany(int index) async {
    try {
      final box = await Hive.openBox<Company>(_boxName);
      await box.deleteAt(index);
      await box.close();
    } catch (e) {
      throw Exception("Failed to delete company locally: $e");
    }
  }

  Future<List<Company>> getCompanies() async {
    try {
      final box = await Hive.openBox<Company>(_boxName);
      final companies = box.values.toList();
      await box.close();
      return companies;
    } catch (e) {
      throw Exception("Failed to get companies locally: $e");
    }
  }
}
