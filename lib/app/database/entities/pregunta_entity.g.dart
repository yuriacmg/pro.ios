// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregunta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreguntaEntityAdapter extends TypeAdapter<PreguntaEntity> {
  @override
  final int typeId = 6;

  @override
  PreguntaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreguntaEntity(
      preguntaId: fields[0] as int?,
      seccionId: fields[1] as int?,
      codigo: fields[2] as String?,
      enunciado: fields[3] as String?,
      detalle: fields[4] as String?,
      enlaceImg: fields[5] as String?,
      tipoId: fields[6] as int?,
      estado: fields[7] as bool?,
      fecRegistro: fields[8] as String?,
      usrRegistro: fields[9] as String?,
      fecModific: fields[10] as String?,
      ursModific: fields[11] as String?,
      orden: fields[12] as int?,
      titulolista: fields[13] as String?,
      enlaceImgOffline: fields[15] as String?,
    )..opciones = (fields[14] as List?)?.cast<PreguntaOpcionesEntity>();
  }

  @override
  void write(BinaryWriter writer, PreguntaEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.preguntaId)
      ..writeByte(1)
      ..write(obj.seccionId)
      ..writeByte(2)
      ..write(obj.codigo)
      ..writeByte(3)
      ..write(obj.enunciado)
      ..writeByte(4)
      ..write(obj.detalle)
      ..writeByte(5)
      ..write(obj.enlaceImg)
      ..writeByte(6)
      ..write(obj.tipoId)
      ..writeByte(7)
      ..write(obj.estado)
      ..writeByte(8)
      ..write(obj.fecRegistro)
      ..writeByte(9)
      ..write(obj.usrRegistro)
      ..writeByte(10)
      ..write(obj.fecModific)
      ..writeByte(11)
      ..write(obj.ursModific)
      ..writeByte(12)
      ..write(obj.orden)
      ..writeByte(13)
      ..write(obj.titulolista)
      ..writeByte(14)
      ..write(obj.opciones)
      ..writeByte(15)
      ..write(obj.enlaceImgOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreguntaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
