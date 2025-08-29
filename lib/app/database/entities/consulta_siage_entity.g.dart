// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulta_siage_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsultaSiageEntityAdapter extends TypeAdapter<ConsultaSiageEntity> {
  @override
  final int typeId = 17;

  @override
  ConsultaSiageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsultaSiageEntity(
      grado: fields[0] as String?,
      condicion: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsultaSiageEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.grado)
      ..writeByte(1)
      ..write(obj.condicion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsultaSiageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
