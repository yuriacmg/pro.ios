// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryEntityAdapter extends TypeAdapter<HistoryEntity> {
  @override
  final int typeId = 15;

  @override
  HistoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryEntity(
      numDocument: fields[0] as String?,
      fullname: fields[1] as String?,
      names: fields[5] as String?,
      lastName: fields[6] as String?,
      send: fields[2] as String?,
      response: fields[3] as String?,
      dateSend: fields[4] as String?,
      isForeign: fields[7] as bool?,
      isLocal: fields[8] as bool?,
      dataSendLocal: fields[9] as String?,
      localId: fields[10] as int?,
      isSync: fields[11] as bool?,
      digitoVerificador: fields[12] as String?,
      ubigeo: fields[13] as String?,
      fechaNacimiento: fields[14] as String?,
    )..syncErrorMessage = fields[15] as String?;
  }

  @override
  void write(BinaryWriter writer, HistoryEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.numDocument)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.send)
      ..writeByte(3)
      ..write(obj.response)
      ..writeByte(4)
      ..write(obj.dateSend)
      ..writeByte(5)
      ..write(obj.names)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.isForeign)
      ..writeByte(8)
      ..write(obj.isLocal)
      ..writeByte(9)
      ..write(obj.dataSendLocal)
      ..writeByte(10)
      ..write(obj.localId)
      ..writeByte(11)
      ..write(obj.isSync)
      ..writeByte(12)
      ..write(obj.digitoVerificador)
      ..writeByte(13)
      ..write(obj.ubigeo)
      ..writeByte(14)
      ..write(obj.fechaNacimiento)
      ..writeByte(15)
      ..write(obj.syncErrorMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
