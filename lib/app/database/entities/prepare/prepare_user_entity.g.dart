// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareUserEntityAdapter extends TypeAdapter<PrepareUserEntity> {
  @override
  final int typeId = 27;

  @override
  PrepareUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareUserEntity(
      apePaterno: fields[0] as String?,
      apeMaterno: fields[1] as String?,
      nombre: fields[2] as String?,
      nombreCompleto: fields[3] as String?,
      fecNacimiento: fields[4] as String?,
      numdoc: fields[5] as String?,
      sexo: fields[6] as String?,
      status: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareUserEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.apePaterno)
      ..writeByte(1)
      ..write(obj.apeMaterno)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.nombreCompleto)
      ..writeByte(4)
      ..write(obj.fecNacimiento)
      ..writeByte(5)
      ..write(obj.numdoc)
      ..writeByte(6)
      ..write(obj.sexo)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
