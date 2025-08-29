// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seccion_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeccionEntityAdapter extends TypeAdapter<SeccionEntity> {
  @override
  final int typeId = 8;

  @override
  SeccionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeccionEntity(
      seccionId: fields[0] as int?,
      codigo: fields[1] as String?,
      nombre: fields[2] as String?,
      descripcion: fields[3] as String?,
      orden: fields[4] as int?,
      estado: fields[5] as bool?,
    )..preguntas = (fields[6] as List?)?.cast<PreguntaEntity>();
  }

  @override
  void write(BinaryWriter writer, SeccionEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.seccionId)
      ..writeByte(1)
      ..write(obj.codigo)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.descripcion)
      ..writeByte(4)
      ..write(obj.orden)
      ..writeByte(5)
      ..write(obj.estado)
      ..writeByte(6)
      ..write(obj.preguntas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeccionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
