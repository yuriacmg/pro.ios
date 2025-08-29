// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palabras_clave_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PalabraClaveEntityAdapter extends TypeAdapter<PalabraClaveEntity> {
  @override
  final int typeId = 37;

  @override
  PalabraClaveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PalabraClaveEntity(
      filtroContenidoId: fields[0] as int?,
      modId: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PalabraClaveEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.filtroContenidoId)
      ..writeByte(1)
      ..write(obj.modId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PalabraClaveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
