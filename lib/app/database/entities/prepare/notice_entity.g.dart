// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoticeEntityAdapter extends TypeAdapter<NoticeEntity> {
  @override
  final int typeId = 28;

  @override
  NoticeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoticeEntity(
      codigo: fields[0] as int?,
      titulo: fields[1] as String?,
      contenido: fields[2] as String?,
      estado: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NoticeEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.contenido)
      ..writeByte(3)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoticeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
