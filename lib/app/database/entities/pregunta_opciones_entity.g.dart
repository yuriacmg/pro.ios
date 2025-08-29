// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregunta_opciones_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreguntaOpcionesEntityAdapter
    extends TypeAdapter<PreguntaOpcionesEntity> {
  @override
  final int typeId = 10;

  @override
  PreguntaOpcionesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreguntaOpcionesEntity(
      valor: fields[3] as String,
      alternativaId: fields[0] as int?,
      nombre: fields[1] as String?,
      preguntaId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PreguntaOpcionesEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.alternativaId)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.preguntaId)
      ..writeByte(3)
      ..write(obj.valor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreguntaOpcionesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
