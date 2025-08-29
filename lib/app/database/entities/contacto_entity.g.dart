// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacto_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactoEntityAdapter extends TypeAdapter<ContactoEntity> {
  @override
  final int typeId = 2;

  @override
  ContactoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactoEntity(
      contactoId: fields[0] as int?,
      nombre: fields[1] as String?,
      tipo: fields[2] as int?,
      detalle: fields[3] as String?,
      enlaceImg: fields[4] as String?,
      enlaceCont: fields[5] as String?,
      estado: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactoEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.contactoId)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.detalle)
      ..writeByte(4)
      ..write(obj.enlaceImg)
      ..writeByte(5)
      ..write(obj.enlaceCont)
      ..writeByte(6)
      ..write(obj.estado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
