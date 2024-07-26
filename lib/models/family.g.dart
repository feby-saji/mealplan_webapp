// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyModelAdapter extends TypeAdapter<FamilyModel> {
  @override
  final int typeId = 2;

  @override
  FamilyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyModel(
      id: fields[0] as String,
      createdOn: fields[3] as String,
      creator: fields[1] as String,
      members: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FamilyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creator)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.createdOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
