// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reniec_send_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReniecSendEntityAdapter extends TypeAdapter<ReniecSendEntity> {
  @override
  final int typeId = 30;

  @override
  ReniecSendEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReniecSendEntity(
      vNroDocumento: fields[0] as String?,
      dFechaNacimiento: fields[1] as String?,
      vUbigeo: fields[2] as String?,
      vCodigoVerificacion: fields[3] as String?,
      vNroCelular: fields[6] as String?,
      bTerminosCondiciones: fields[4] as bool?,
      bDeclaracionInformacion: fields[5] as bool?,
      vNombres: fields[7] as String?,
      vApellidoPaterno: fields[8] as String?,
      vApellidoMaterno: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReniecSendEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.vNroDocumento)
      ..writeByte(1)
      ..write(obj.dFechaNacimiento)
      ..writeByte(2)
      ..write(obj.vUbigeo)
      ..writeByte(3)
      ..write(obj.vCodigoVerificacion)
      ..writeByte(4)
      ..write(obj.bTerminosCondiciones)
      ..writeByte(5)
      ..write(obj.bDeclaracionInformacion)
      ..writeByte(6)
      ..write(obj.vNroCelular)
      ..writeByte(7)
      ..write(obj.vNombres)
      ..writeByte(8)
      ..write(obj.vApellidoPaterno)
      ..writeByte(9)
      ..write(obj.vApellidoMaterno);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReniecSendEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
