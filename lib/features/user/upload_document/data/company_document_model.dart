import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'company_document_model.g.dart';

@HiveType(typeId: 3)
class CompanyDocument extends HiveObject {
  @HiveField(0)
  late String? name;

  @HiveField(1)
  late String? url;

  @HiveField(2)
  late String? urlImage;

  @HiveField(3)
  late String? comment;

  @HiveField(4)
  late String? userId;

  @HiveField(5)
  late String? companyDocId;

  @HiveField(6)
  late String? fileExtension;

  @HiveField(7)
  late String? docId;

  @HiveField(8)
  late String? status;

  @HiveField(9)
  late String? companyName;

  @HiveField(10)
  late String? invoiceDate;

  @HiveField(11)
  late String? invoiceNumber;

  @HiveField(12)
  late String? amountOfTheInvoice;

  @HiveField(13)
  late String? selectItem;

  @HiveField(14)
  late String? selectTypeItem;

  @HiveField(15)
  late String? commentForAccountant;

  @HiveField(16)
  late int? docNumber;

  CompanyDocument({
    this.name,
    this.url,
    this.urlImage,
    this.comment,
    this.userId,
    this.companyDocId,
    this.fileExtension,
    this.docId,
    this.status,
    this.companyName,
    this.invoiceDate,
    this.invoiceNumber,
    this.amountOfTheInvoice,
    this.selectItem,
    this.selectTypeItem,
    this.commentForAccountant,
    this.docNumber,
  });

  factory CompanyDocument.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CompanyDocument(
      name: data['name'] ?? '', // Use default value '' if 'name' is null
      url: data['url'] ?? '',
      urlImage: data['urlImage'] ?? '',
      comment: data['comment'] ?? '',
      userId: data['userId'] ?? '',
      companyDocId: data['companyDocId'] ?? '',
      fileExtension: data['fileExtension'] ?? '',
      docId: data['DocID'] ?? '',
      status: data['status'] ?? '',
      companyName: data['companyName'] ?? '',
      invoiceDate: data['invoiceDate'] ?? '',
      invoiceNumber: data['invoiceNumber'] ?? '',
      amountOfTheInvoice: data['amountOfTheInvoice'] ?? '',
      selectItem: data['selectItem'] ?? '',
      selectTypeItem: data['selectTypeItem'] ?? '',
      commentForAccountant: data['commentForAccountatnt'] ?? '',
      docNumber:
          data['docNumer'] ?? 0, // Use default value 0 if 'docNumer' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'urlImage': urlImage,
      'comment': comment,
      'userId': userId,
      'companyDocId': companyDocId,
      'fileExtension': fileExtension,
      'DocID': docId,
      'status': status,
      'companyName': companyName,
      'invoiceDate': invoiceDate,
      'invoiceNumber': invoiceNumber,
      'amountOfTheInvoice': amountOfTheInvoice,
      'selectItem': selectItem,
      'selectTypeItem': selectTypeItem,
      'commentForAccountatnt': commentForAccountant,
      'docNumer': docNumber,
    };
  }
}
