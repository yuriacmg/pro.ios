// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_reniec_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataReniecEntityAdapter extends TypeAdapter<DataReniecEntity> {
  @override
  final int typeId = 3;

  @override
  DataReniecEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataReniecEntity(
      apellidoPaterno: fields[0] as String?,
      apellidoMaterno: fields[1] as String?,
      nombres: fields[2] as String?,
      nombreCompleto: fields[3] as String?,
      fechaNacimiento: fields[4] as String?,
      sexo: fields[5] as String?,
      numDocumento: fields[6] as String?,
      numCelular: fields[8] as String?,
    )..preguntas = (fields[7] as List?)?.cast<RespuestaEntity>();
  }

  @override
  void write(BinaryWriter writer, DataReniecEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.apellidoPaterno)
      ..writeByte(1)
      ..write(obj.apellidoMaterno)
      ..writeByte(2)
      ..write(obj.nombres)
      ..writeByte(3)
      ..write(obj.nombreCompleto)
      ..writeByte(4)
      ..write(obj.fechaNacimiento)
      ..writeByte(5)
      ..write(obj.sexo)
      ..writeByte(6)
      ..write(obj.numDocumento)
      ..writeByte(7)
      ..write(obj.preguntas)
      ..writeByte(8)
      ..write(obj.numCelular);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataReniecEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
