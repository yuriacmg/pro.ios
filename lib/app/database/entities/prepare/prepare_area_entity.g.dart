// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_area_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareAreaEntityAdapter extends TypeAdapter<PrepareAreaEntity> {
  @override
  final int typeId = 19;

  @override
  PrepareAreaEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareAreaEntity(
      codigo: fields[0] as String?,
      nombre: fields[1] as String?,
      enlaceLogo: fields[2] as String?,
      orden: fields[3] as int?,
      enlaceLogoOffline: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareAreaEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.enlaceLogo)
      ..writeByte(3)
      ..write(obj.orden)
      ..writeByte(4)
      ..write(obj.enlaceLogoOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareAreaEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
