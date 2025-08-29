// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parametro_filtro_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParametroFiltroEntityAdapter extends TypeAdapter<ParametroFiltroEntity> {
  @override
  final int typeId = 38;

  @override
  ParametroFiltroEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParametroFiltroEntity(
      filtroId: fields[0] as int?,
      tipo: fields[1] as String?,
      objeto: fields[2] as String?,
      titulo: fields[3] as String?,
      opciones: (fields[4] as List?)?.cast<ParametroFiltroOpcionesEntity>(),
      orden: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ParametroFiltroEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.filtroId)
      ..writeByte(1)
      ..write(obj.tipo)
      ..writeByte(2)
      ..write(obj.objeto)
      ..writeByte(3)
      ..write(obj.titulo)
      ..writeByte(4)
      ..write(obj.opciones)
      ..writeByte(5)
      ..write(obj.orden);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParametroFiltroEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
