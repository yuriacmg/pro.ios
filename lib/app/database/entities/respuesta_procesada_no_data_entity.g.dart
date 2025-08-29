// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_procesada_no_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestaProcesadaNoDataEntityAdapter
    extends TypeAdapter<RespuestaProcesadaNoDataEntity> {
  @override
  final int typeId = 24;

  @override
  RespuestaProcesadaNoDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespuestaProcesadaNoDataEntity(
      rptaBool: fields[0] as bool?,
      resultado: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RespuestaProcesadaNoDataEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rptaBool)
      ..writeByte(1)
      ..write(obj.resultado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespuestaProcesadaNoDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
