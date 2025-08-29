// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileEntityAdapter extends TypeAdapter<ProfileEntity> {
  @override
  final int typeId = 33;

  @override
  ProfileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileEntity(
      iRegistroId: fields[0] as int?,
      vNroDocumento: fields[1] as String?,
      vEmail: fields[2] as String?,
      vNombres: fields[3] as String?,
      vApellidos: fields[4] as String?,
      vFechaNacimiento: fields[5] as String?,
      vUbigeo: fields[6] as String?,
      vDigitoVerificador: fields[7] as String?,
      vCelular: fields[8] as String?,
      vPrefijo: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.iRegistroId)
      ..writeByte(1)
      ..write(obj.vNroDocumento)
      ..writeByte(2)
      ..write(obj.vEmail)
      ..writeByte(3)
      ..write(obj.vNombres)
      ..writeByte(4)
      ..write(obj.vApellidos)
      ..writeByte(5)
      ..write(obj.vFechaNacimiento)
      ..writeByte(6)
      ..write(obj.vUbigeo)
      ..writeByte(7)
      ..write(obj.vDigitoVerificador)
      ..writeByte(8)
      ..write(obj.vCelular)
      ..writeByte(9)
      ..write(obj.vPrefijo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
