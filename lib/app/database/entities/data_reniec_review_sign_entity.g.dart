// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_reniec_review_sign_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataReniecReviewSignEntityAdapter
    extends TypeAdapter<DataReniecReviewSignEntity> {
  @override
  final int typeId = 12;

  @override
  DataReniecReviewSignEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataReniecReviewSignEntity(
      apePaterno: fields[0] as String?,
      apeMaterno: fields[1] as String?,
      nombre: fields[2] as String?,
      nombreCompleto: fields[3] as String?,
      fecNacimiento: fields[4] as String?,
      numdoc: fields[5] as String?,
      sexo: fields[6] as String?,
      concurso: fields[7] as String?,
      modalidad: fields[8] as String?,
      fecPostulacion: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataReniecReviewSignEntity obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.concurso)
      ..writeByte(8)
      ..write(obj.modalidad)
      ..writeByte(9)
      ..write(obj.fecPostulacion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataReniecReviewSignEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
