// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_company_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddCompanyToHiveAdapter extends TypeAdapter<AddCompanyToHive> {
  @override
  final int typeId = 2;

  @override
  AddCompanyToHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddCompanyToHive(
      logo: fields[0] as String,
      companyName: fields[1] as String,
      companyAddress: fields[2] as String,
      companyType: fields[3] as String,
      companyId: fields[4] as String,
      companyDocId: fields[5] as String,
      userID: fields[6] as String,
      additionalInformation: (fields[7] as List).cast<dynamic>(),
      companyStatus: fields[8] as String,
      timesTamp: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddCompanyToHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.logo)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.companyAddress)
      ..writeByte(3)
      ..write(obj.companyType)
      ..writeByte(4)
      ..write(obj.companyId)
      ..writeByte(5)
      ..write(obj.companyDocId)
      ..writeByte(6)
      ..write(obj.userID)
      ..writeByte(7)
      ..write(obj.additionalInformation)
      ..writeByte(8)
      ..write(obj.companyStatus)
      ..writeByte(9)
      ..write(obj.timesTamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddCompanyToHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
