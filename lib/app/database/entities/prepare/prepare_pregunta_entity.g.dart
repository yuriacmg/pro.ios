// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_pregunta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreparePreguntaEntityAdapter extends TypeAdapter<PreparePreguntaEntity> {
  @override
  final int typeId = 23;

  @override
  PreparePreguntaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreparePreguntaEntity(
      preguntaId: fields[0] as int?,
      pregunta: fields[1] as String?,
      comentarios: fields[2] as String?,
      enlaceImagen: fields[3] as String?,
      orden: fields[4] as int?,
      respuesta: fields[5] as String?,
      codigoCourse: fields[6] as int?,
      simulacroId: fields[7] as int?,
      tipo: fields[8] as String?,
      preguntaPadreId: fields[9] as int?,
      area: fields[10] as String?,
      preguntaOffline: fields[12] as String?,
      comentarioOffline: fields[13] as String?,
      enlaceImagenOffline: fields[14] as String?,
    )..alternatives = (fields[11] as List?)?.cast<PrepareAlternativeEntity>();
  }

  @override
  void write(BinaryWriter writer, PreparePreguntaEntity obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.preguntaId)
      ..writeByte(1)
      ..write(obj.pregunta)
      ..writeByte(2)
      ..write(obj.comentarios)
      ..writeByte(3)
      ..write(obj.enlaceImagen)
      ..writeByte(4)
      ..write(obj.orden)
      ..writeByte(5)
      ..write(obj.respuesta)
      ..writeByte(6)
      ..write(obj.codigoCourse)
      ..writeByte(7)
      ..write(obj.simulacroId)
      ..writeByte(8)
      ..write(obj.tipo)
      ..writeByte(9)
      ..write(obj.preguntaPadreId)
      ..writeByte(10)
      ..write(obj.area)
      ..writeByte(11)
      ..write(obj.alternatives)
      ..writeByte(12)
      ..write(obj.preguntaOffline)
      ..writeByte(13)
      ..write(obj.comentarioOffline)
      ..writeByte(14)
      ..write(obj.enlaceImagenOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreparePreguntaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
