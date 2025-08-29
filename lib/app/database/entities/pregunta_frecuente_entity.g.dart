// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregunta_frecuente_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreguntaFrecuenteEntityAdapter
    extends TypeAdapter<PreguntaFrecuenteEntity> {
  @override
  final int typeId = 42;

  @override
  PreguntaFrecuenteEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreguntaFrecuenteEntity(
      iPreguntaFrecuenteId: fields[0] as int?,
      iOrden: fields[1] as int?,
      vTitulo: fields[2] as String?,
      vContenido: fields[3] as String?,
      estado: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PreguntaFrecuenteEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.iPreguntaFrecuenteId)
      ..writeByte(1)
      ..write(obj.iOrden)
      ..writeByte(2)
      ..write(obj.vTitulo)
      ..writeByte(3)
      ..write(obj.vContenido)
      ..writeByte(4)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreguntaFrecuenteEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
