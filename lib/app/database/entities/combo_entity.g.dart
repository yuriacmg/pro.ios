// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComboEntityAdapter extends TypeAdapter<ComboEntity> {
  @override
  final int typeId = 32;

  @override
  ComboEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComboEntity(
      generalId: fields[0] as int?,
      nombre: fields[1] as String?,
      type: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ComboEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.generalId)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComboEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
