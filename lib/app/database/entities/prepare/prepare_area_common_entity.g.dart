// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_area_common_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareAreaCommonEntityAdapter
    extends TypeAdapter<PrepareAreaCommonEntity> {
  @override
  final int typeId = 20;

  @override
  PrepareAreaCommonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareAreaCommonEntity(
      codigo: fields[0] as int?,
      nombre: fields[1] as String?,
      orden: fields[2] as int?,
      nroPregunta: fields[3] as int?,
      enlaceLogo: fields[4] as String?,
      status: fields[5] as int?,
      codigoPreparate: fields[6] as int?,
      enlaceLogoOffline: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareAreaCommonEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.orden)
      ..writeByte(3)
      ..write(obj.nroPregunta)
      ..writeByte(4)
      ..write(obj.enlaceLogo)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.codigoPreparate)
      ..writeByte(7)
      ..write(obj.enlaceLogoOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareAreaCommonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
