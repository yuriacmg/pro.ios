// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_user_history_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaUserHistoryEntityAdapter extends TypeAdapter<AreaUserHistoryEntity> {
  @override
  final int typeId = 31;

  @override
  AreaUserHistoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AreaUserHistoryEntity(
      areaId: fields[0] as int?,
      areaStatus: fields[1] as int?,
      areaName: fields[2] as String?,
      userDocument: fields[3] as String?,
      areaIntentos: fields[4] as int?,
      generalCode: fields[5] as int?,
      areaCode: fields[6] as int?,
      areaGeneralCode: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AreaUserHistoryEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.areaId)
      ..writeByte(1)
      ..write(obj.areaStatus)
      ..writeByte(2)
      ..write(obj.areaName)
      ..writeByte(3)
      ..write(obj.userDocument)
      ..writeByte(4)
      ..write(obj.areaIntentos)
      ..writeByte(5)
      ..write(obj.generalCode)
      ..writeByte(6)
      ..write(obj.areaCode)
      ..writeByte(7)
      ..write(obj.areaGeneralCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaUserHistoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
