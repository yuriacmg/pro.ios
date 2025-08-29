// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalidad_beneficio_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModalidadBeneficioEntityAdapter
    extends TypeAdapter<ModalidadBeneficioEntity> {
  @override
  final int typeId = 9;

  @override
  ModalidadBeneficioEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModalidadBeneficioEntity(
      modBeneficiotId: fields[0] as int?,
      beneficioId: fields[1] as int?,
      modId: fields[2] as int?,
      descripc: fields[3] as String?,
      enlaceImg: fields[4] as String?,
      orden: fields[5] as int?,
      estado: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ModalidadBeneficioEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.modBeneficiotId)
      ..writeByte(1)
      ..write(obj.beneficioId)
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
      other is ModalidadBeneficioEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
