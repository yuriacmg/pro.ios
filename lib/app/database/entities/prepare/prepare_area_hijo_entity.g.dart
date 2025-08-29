// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_area_hijo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareAreaHijoEntityAdapter extends TypeAdapter<PrepareAreaHijoEntity> {
  @override
  final int typeId = 34;

  @override
  PrepareAreaHijoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareAreaHijoEntity(
      codigo: fields[0] as String?,
      codigoPadre: fields[1] as String?,
      nombre: fields[2] as String?,
      enlaceLogo: fields[3] as String?,
      orden: fields[4] as int?,
      enlaceLogoOffline: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareAreaHijoEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.codigoPadre)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.enlaceLogo)
      ..writeByte(4)
      ..write(obj.orden)
      ..writeByte(5)
      ..write(obj.enlaceLogoOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareAreaHijoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
