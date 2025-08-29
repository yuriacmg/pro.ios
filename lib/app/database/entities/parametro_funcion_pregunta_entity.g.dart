// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parametro_funcion_pregunta_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParametroFuncionPreguntaEntityAdapter
    extends TypeAdapter<ParametroFuncionPreguntaEntity> {
  @override
  final int typeId = 36;

  @override
  ParametroFuncionPreguntaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParametroFuncionPreguntaEntity(
      modalidadId: fields[0] as int?,
      tipo: fields[1] as String?,
      nombre: fields[2] as String?,
      parametro: (fields[3] as List?)?.cast<String>(),
      operador: fields[4] as String?,
      valorRespuesta: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ParametroFuncionPreguntaEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.modalidadId)
      ..writeByte(1)
      ..write(obj.tipo)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.parametro)
      ..writeByte(4)
      ..write(obj.operador)
      ..writeByte(5)
      ..write(obj.valorRespuesta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParametroFuncionPreguntaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
