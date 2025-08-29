// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationEntityAdapter extends TypeAdapter<NotificationEntity> {
  @override
  final int typeId = 44;

  @override
  NotificationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationEntity(
      idNotification: fields[0] as int?,
      title: fields[1] as String,
      description: fields[2] as String,
      isOpen: fields[3] as bool,
      registerDate: fields[4] as DateTime?,
      image: fields[5] as String?,
      url: fields[6] as String?,
      option: fields[7] as String?,
      idApi: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idNotification)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isOpen)
      ..writeByte(4)
      ..write(obj.registerDate)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.option)
      ..writeByte(8)
      ..write(obj.idApi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
