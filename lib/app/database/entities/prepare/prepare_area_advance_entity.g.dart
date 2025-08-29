// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_area_advance_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareAreaAdvanceEntityAdapter
    extends TypeAdapter<PrepareAreaAdvanceEntity> {
  @override
  final int typeId = 26;

  @override
  PrepareAreaAdvanceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareAreaAdvanceEntity(
      preguntaId: fields[0] as int?,
      respuestaMarcada: fields[1] as int?,
      courseCode: fields[2] as int?,
      userDocument: fields[3] as String?,
      generalCode: fields[4] as int?,
      areaGeneralCode: fields[5] as String?,
      areaCode: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareAreaAdvanceEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.preguntaId)
      ..writeByte(1)
      ..write(obj.respuestaMarcada)
      ..writeByte(2)
      ..write(obj.courseCode)
      ..writeByte(3)
      ..write(obj.userDocument)
      ..writeByte(4)
      ..write(obj.generalCode)
      ..writeByte(5)
      ..write(obj.areaGeneralCode)
      ..writeByte(6)
      ..write(obj.areaCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareAreaAdvanceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
