// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalidad_documento_clave_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModalidadDocumentoClaveEntityAdapter
    extends TypeAdapter<ModalidadDocumentoClaveEntity> {
  @override
  final int typeId = 45;

  @override
  ModalidadDocumentoClaveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModalidadDocumentoClaveEntity(
      modDocClaveId: fields[0] as int?,
      modId: fields[1] as int?,
      descripc: fields[2] as String?,
      orden: fields[3] as int?,
      estado: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ModalidadDocumentoClaveEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.modDocClaveId)
      ..writeByte(1)
      ..write(obj.modId)
      ..writeByte(2)
      ..write(obj.descripc)
      ..writeByte(3)
      ..write(obj.orden)
      ..writeByte(4)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModalidadDocumentoClaveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
