// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VersionEntityAdapter extends TypeAdapter<VersionEntity> {
  @override
  final int typeId = 7;

  @override
  VersionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VersionEntity(
      versionApp: (fields[0] as List?)?.cast<String>(),
      versionCont: fields[1] as String?,
      fechaVerApp: fields[2] as String?,
      fechaVerCont: fields[3] as String?,
      versionAppIOS: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, VersionEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.versionApp)
      ..writeByte(1)
      ..write(obj.versionCont)
      ..writeByte(2)
      ..write(obj.fechaVerApp)
      ..writeByte(3)
      ..write(obj.fechaVerCont)
      ..writeByte(4)
      ..write(obj.versionAppIOS);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VersionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
