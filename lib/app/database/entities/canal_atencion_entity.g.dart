// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canal_atencion_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CanalAtencionEntityAdapter extends TypeAdapter<CanalAtencionEntity> {
  @override
  final int typeId = 1;

  @override
  CanalAtencionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CanalAtencionEntity(
      canalId: fields[0] as int?,
      nombreCanal: fields[1] as String?,
      detalleCanal: fields[2] as String?,
      enlaceImg: fields[3] as String?,
      enlaceCanAte: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CanalAtencionEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.canalId)
      ..writeByte(1)
      ..write(obj.nombreCanal)
      ..writeByte(2)
      ..write(obj.detalleCanal)
      ..writeByte(3)
      ..write(obj.enlaceImg)
      ..writeByte(4)
      ..write(obj.enlaceCanAte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CanalAtencionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
