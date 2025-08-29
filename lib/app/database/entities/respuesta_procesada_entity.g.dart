// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_procesada_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestaProcesadaEntityAdapter
    extends TypeAdapter<RespuestaProcesadaEntity> {
  @override
  final int typeId = 14;

  @override
  RespuestaProcesadaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespuestaProcesadaEntity(
      modId: fields[0] as int?,
      consultaId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RespuestaProcesadaEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.modId)
      ..writeByte(1)
      ..write(obj.consultaId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespuestaProcesadaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
