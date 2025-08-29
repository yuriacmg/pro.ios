// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beca_otro_pais_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BecaOtroPaisEntityAdapter extends TypeAdapter<BecaOtroPaisEntity> {
  @override
  final int typeId = 40;

  @override
  BecaOtroPaisEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BecaOtroPaisEntity(
      iBopId: fields[0] as int?,
      vTituloBop: fields[1] as String?,
      vDescripcionTituloBop: fields[2] as String?,
      bPadreBop: fields[3] as bool?,
      iBopIdPadre: fields[4] as int?,
      vNombreBop: fields[5] as String?,
      vDescripcionNombreBop: fields[6] as String?,
      vCodigo: fields[7] as String?,
      vEnlaceBop: fields[8] as String?,
      vEnlaceInformacionBop: fields[9] as String?,
      vEnlaceLogoBop: fields[10] as String?,
      vEnlaceLogoBopOffline: fields[11] as String?,
      vFechaPostulacion: fields[12] as String?,
      dFechaPostulacion: fields[13] as String?,
    )..becasOtrosPaisesHijos =
        (fields[14] as List?)?.cast<BecaOtroPaisHijoEntity>();
  }

  @override
  void write(BinaryWriter writer, BecaOtroPaisEntity obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.iBopId)
      ..writeByte(1)
      ..write(obj.vTituloBop)
      ..writeByte(2)
      ..write(obj.vDescripcionTituloBop)
      ..writeByte(3)
      ..write(obj.bPadreBop)
      ..writeByte(4)
      ..write(obj.iBopIdPadre)
      ..writeByte(5)
      ..write(obj.vNombreBop)
      ..writeByte(6)
      ..write(obj.vDescripcionNombreBop)
      ..writeByte(7)
      ..write(obj.vCodigo)
      ..writeByte(8)
      ..write(obj.vEnlaceBop)
      ..writeByte(9)
      ..write(obj.vEnlaceInformacionBop)
      ..writeByte(10)
      ..write(obj.vEnlaceLogoBop)
      ..writeByte(11)
      ..write(obj.vEnlaceLogoBopOffline)
      ..writeByte(12)
      ..write(obj.vFechaPostulacion)
      ..writeByte(13)
      ..write(obj.dFechaPostulacion)
      ..writeByte(14)
      ..write(obj.becasOtrosPaisesHijos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BecaOtroPaisEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
