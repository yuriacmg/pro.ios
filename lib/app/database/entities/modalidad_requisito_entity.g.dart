// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalidad_requisito_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModalidadRequisitoEntityAdapter
    extends TypeAdapter<ModalidadRequisitoEntity> {
  @override
  final int typeId = 5;

  @override
  ModalidadRequisitoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModalidadRequisitoEntity(
      modRequisId: fields[0] as int?,
      requisId: fields[1] as int?,
      modId: fields[2] as int?,
      descripc: fields[3] as String?,
      enlaceImg: fields[4] as String?,
      orden: fields[5] as int?,
      estado: fields[6] as bool?,
      fecRegistro: fields[7] as String?,
      usrRegistro: fields[8] as String?,
      fecModific: fields[9] as String?,
      ursModific: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModalidadRequisitoEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.modRequisId)
      ..writeByte(1)
      ..write(obj.requisId)
      ..writeByte(2)
      ..write(obj.modId)
      ..writeByte(3)
      ..write(obj.descripc)
      ..writeByte(4)
      ..write(obj.enlaceImg)
      ..writeByte(5)
      ..write(obj.orden)
      ..writeByte(6)
      ..write(obj.estado)
      ..writeByte(7)
      ..write(obj.fecRegistro)
      ..writeByte(8)
      ..write(obj.usrRegistro)
      ..writeByte(9)
      ..write(obj.fecModific)
      ..writeByte(10)
      ..write(obj.ursModific);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModalidadRequisitoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
