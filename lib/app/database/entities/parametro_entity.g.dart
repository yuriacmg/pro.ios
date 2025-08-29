// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parametro_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParametroEntityAdapter extends TypeAdapter<ParametroEntity> {
  @override
  final int typeId = 35;

  @override
  ParametroEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParametroEntity(
      modalidadId: fields[0] as int?,
    )..funcionPregunta =
        (fields[1] as List?)?.cast<ParametroFuncionPreguntaEntity>();
  }

  @override
  void write(BinaryWriter writer, ParametroEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.modalidadId)
      ..writeByte(1)
      ..write(obj.funcionPregunta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParametroEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
