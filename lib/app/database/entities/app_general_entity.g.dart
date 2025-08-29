// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_general_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppGeneralEntityAdapter extends TypeAdapter<AppGeneralEntity> {
  @override
  final int typeId = 18;

  @override
  AppGeneralEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppGeneralEntity(
      firstTime: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppGeneralEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.firstTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppGeneralEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
