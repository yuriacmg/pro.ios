// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_history_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrepareHistoryEntityAdapter extends TypeAdapter<PrepareHistoryEntity> {
  @override
  final int typeId = 25;

  @override
  PrepareHistoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrepareHistoryEntity(
      areaCode: fields[0] as int?,
      areaName: fields[1] as String?,
      userName: fields[2] as String?,
      attempsNumber: fields[3] as int?,
      inputNumber: fields[4] as int?,
      startDate: fields[5] as DateTime?,
      startEnd: fields[6] as DateTime?,
      score: fields[7] as int?,
      totalCorrect: fields[8] as int?,
      totalError: fields[9] as int?,
      totalUnanswered: fields[10] as int?,
      numberDoc: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrepareHistoryEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.areaCode)
      ..writeByte(1)
      ..write(obj.areaName)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.attempsNumber)
      ..writeByte(4)
      ..write(obj.inputNumber)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.startEnd)
      ..writeByte(7)
      ..write(obj.score)
      ..writeByte(8)
      ..write(obj.totalCorrect)
      ..writeByte(9)
      ..write(obj.totalError)
      ..writeByte(10)
      ..write(obj.totalUnanswered)
      ..writeByte(11)
      ..write(obj.numberDoc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareHistoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
