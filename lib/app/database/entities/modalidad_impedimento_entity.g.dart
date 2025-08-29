// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalidad_impedimento_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModalidadImpedimentoEntityAdapter
    extends TypeAdapter<ModalidadImpedimentoEntity> {
  @override
  final int typeId = 11;

  @override
  ModalidadImpedimentoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModalidadImpedimentoEntity(
      modImpedId: fields[0] as int?,
      impedId: fields[1] as int?,
      modId: fields[2] as int?,
      descripc: fields[3] as String?,
      enlaceImg: fields[4] as String?,
      orden: fields[5] as int?,
      estado: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ModalidadImpedimentoEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.modImpedId)
      ..writeByte(1)
      ..write(obj.impedId)
      ..writeByte(2)
      ..write(obj.modId)
      ..writeByte(3)
      ..write(obj.descripc)
      ..writeByte(4)
      ..write(obj.enlaceImg)
      ..writeByte(5)
      ..write(obj.orden)
      ..writeByte(6)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModalidadImpedimentoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
