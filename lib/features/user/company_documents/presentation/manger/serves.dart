import 'package:hive/hive.dart';
import 'package:mohra_project/features/user/upload_document/data/company_document_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Box<CompanyDocument>? _companyDocumentBox; // Make the box nullable

  // Method to initialize Hive and the box
  static Future<void> initializeHive() async {
    if (_companyDocumentBox == null) {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(CompanyDocumentAdapter());
      _companyDocumentBox =
          await Hive.openBox<CompanyDocument>('company_documents');
    }
  }

  // Method to cache documents
  static Future<void> cacheCompanyDocuments(
      List<CompanyDocument> documents) async {
    // Ensure _companyDocumentBox is initialized before accessing it
    await initializeHive();

    // Now _companyDocumentBox should not be null
    if (_companyDocumentBox != null) {
      await _companyDocumentBox!.clear(); // Clear existing data
      await _companyDocumentBox!.addAll(documents);
    }
  }

  // Method to get cached documents
  static List<CompanyDocument> getCachedCompanyDocuments() {
    // Ensure _companyDocumentBox is initialized before accessing it
    initializeHive();

    // Now _companyDocumentBox should not be null
    if (_companyDocumentBox == null) {
      throw HiveError('Hive box is not open.');
    }
    return _companyDocumentBox!.values.toList();
  }
}
