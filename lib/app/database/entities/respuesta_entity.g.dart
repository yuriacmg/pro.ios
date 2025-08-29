// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestaEntityAdapter extends TypeAdapter<RespuestaEntity> {
  @override
  final int typeId = 13;

  @override
  RespuestaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RespuestaEntity(
      preguntaId: fields[0] as int?,
      alternativaRespuesta: fields[1] as int?,
      respuestaAutomatica: fields[2] as bool?,
      texto: fields[3] as String?,
      rptIcono: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, RespuestaEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.preguntaId)
      ..writeByte(1)
      ..write(obj.alternativaRespuesta)
      ..writeByte(2)
      ..write(obj.respuestaAutomatica)
      ..writeByte(3)
      ..write(obj.texto)
      ..writeByte(4)
      ..write(obj.rptIcono);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespuestaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
