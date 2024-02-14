// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_document_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyDocumentAdapter extends TypeAdapter<CompanyDocument> {
  @override
  final int typeId = 3;

  @override
  CompanyDocument read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyDocument(
      name: fields[0] as String?,
      url: fields[1] as String?,
      urlImage: fields[2] as String?,
      comment: fields[3] as String,
      userId: fields[4] as String,
      companyDocId: fields[5] as String,
      fileExtension: fields[6] as String?,
      docId: fields[7] as String,
      status: fields[8] as String,
      companyName: fields[9] as String,
      invoiceDate: fields[10] as String,
      invoiceNumber: fields[11] as String,
      amountOfTheInvoice: fields[12] as String,
      selectItem: fields[13] as String,
      selectTypeItem: fields[14] as String,
      commentForAccountant: fields[15] as String,
      docNumber: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyDocument obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.urlImage)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.companyDocId)
      ..writeByte(6)
      ..write(obj.fileExtension)
      ..writeByte(7)
      ..write(obj.docId)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.companyName)
      ..writeByte(10)
      ..write(obj.invoiceDate)
      ..writeByte(11)
      ..write(obj.invoiceNumber)
      ..writeByte(12)
      ..write(obj.amountOfTheInvoice)
      ..writeByte(13)
      ..write(obj.selectItem)
      ..writeByte(14)
      ..write(obj.selectTypeItem)
      ..writeByte(15)
      ..write(obj.commentForAccountant)
      ..writeByte(16)
      ..write(obj.docNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyDocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
