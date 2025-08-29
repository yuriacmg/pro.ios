// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_alternative_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareAlternativeEntityAdapter
    extends TypeAdapter<PrepareAlternativeEntity> {
  @override
  final int typeId = 22;

  @override
  PrepareAlternativeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareAlternativeEntity(
      alternativaId: fields[0] as int?,
      preguntaId: fields[1] as int?,
      codigo: fields[2] as String?,
      alternativa: fields[3] as String?,
      enlaceImagen: fields[4] as String?,
      type: fields[5] as String?,
      typeAlternativa: fields[6] as String?,
      alternativaOffline: fields[7] as String?,
      enlaceImagenOffline: fields[8] as String?,
      typeAlternativaOffline: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareAlternativeEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.alternativaId)
      ..writeByte(1)
      ..write(obj.preguntaId)
      ..writeByte(2)
      ..write(obj.codigo)
      ..writeByte(3)
      ..write(obj.alternativa)
      ..writeByte(4)
      ..write(obj.enlaceImagen)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.typeAlternativa)
      ..writeByte(7)
      ..write(obj.alternativaOffline)
      ..writeByte(8)
      ..write(obj.enlaceImagenOffline)
      ..writeByte(9)
      ..write(obj.typeAlternativaOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareAlternativeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
