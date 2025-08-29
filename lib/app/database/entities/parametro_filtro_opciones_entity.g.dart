// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parametro_filtro_opciones_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParametroFiltroOpcionesEntityAdapter
    extends TypeAdapter<ParametroFiltroOpcionesEntity> {
  @override
  final int typeId = 39;

  @override
  ParametroFiltroOpcionesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParametroFiltroOpcionesEntity(
      filtroId: fields[1] as int?,
      filtroContenidoId: fields[0] as int?,
      opciones: fields[2] as String?,
      orden: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ParametroFiltroOpcionesEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.filtroContenidoId)
      ..writeByte(1)
      ..write(obj.filtroId)
      ..writeByte(2)
      ..write(obj.opciones)
      ..writeByte(3)
      ..write(obj.orden);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParametroFiltroOpcionesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
