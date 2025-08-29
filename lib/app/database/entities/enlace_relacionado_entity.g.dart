// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enlace_relacionado_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnlaceRelacionadoEntityAdapter
    extends TypeAdapter<EnlaceRelacionadoEntity> {
  @override
  final int typeId = 43;

  @override
  EnlaceRelacionadoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnlaceRelacionadoEntity(
      iEnlaceRelacionadoId: fields[0] as int?,
      iOrden: fields[1] as int?,
      vNombre: fields[2] as String?,
      vEnlace: fields[3] as String?,
      vEnlaceImagen: fields[4] as String?,
      vEnlaceImagenOffline: fields[5] as String?,
      estado: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, EnlaceRelacionadoEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.iEnlaceRelacionadoId)
      ..writeByte(1)
      ..write(obj.iOrden)
      ..writeByte(2)
      ..write(obj.vNombre)
      ..writeByte(3)
      ..write(obj.vEnlace)
      ..writeByte(4)
      ..write(obj.vEnlaceImagen)
      ..writeByte(5)
      ..write(obj.vEnlaceImagenOffline)
      ..writeByte(6)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnlaceRelacionadoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
