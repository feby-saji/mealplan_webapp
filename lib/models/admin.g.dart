// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 1;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      email: fields[1] as String,
      loggedIn: fields[4] as bool,
      usersCount: fields[2] as int,
      familysCount: fields[3] as int,
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.usersCount)
      ..writeByte(3)
      ..write(obj.familysCount)
      ..writeByte(4)
      ..write(obj.loggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
