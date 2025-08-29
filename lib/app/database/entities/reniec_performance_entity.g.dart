// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reniec_performance_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReniecPerformanceEntityAdapter
    extends TypeAdapter<ReniecPerformanceEntity> {
  @override
  final int typeId = 16;

  @override
  ReniecPerformanceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReniecPerformanceEntity(
      apePaterno: fields[0] as String?,
      apeMaterno: fields[1] as String?,
      nombre: fields[2] as String?,
      nombreCompleto: fields[3] as String?,
      fecNacimiento: fields[4] as String?,
      numdoc: fields[5] as String?,
      sexo: fields[6] as String?,
      resultadoSiagie: fields[7] as String?,
      rptaSiagieBool: fields[8] as bool?,
      notara: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReniecPerformanceEntity obj) {
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
      ..write(obj.resultadoSiagie)
      ..writeByte(8)
      ..write(obj.rptaSiagieBool)
      ..writeByte(9)
      ..write(obj.notara);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReniecPerformanceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
