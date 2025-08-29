// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalidad_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModalidadEntityAdapter extends TypeAdapter<ModalidadEntity> {
  @override
  final int typeId = 4;

  @override
  ModalidadEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModalidadEntity(
      modId: fields[0] as int?,
      nomCompleto: fields[1] as String?,
      nomCorto: fields[2] as String?,
      codigo: fields[3] as String?,
      enlaceMod: fields[4] as String?,
      enlaceInform: fields[5] as String?,
      enlaceLog: fields[6] as String?,
      beneficios: fields[7] as String?,
      impedimentos: fields[8] as String?,
      vFecPostu: fields[9] as String?,
      dFecPostu: fields[10] as String?,
      publicada: fields[11] as bool?,
      estado: fields[12] as bool?,
      fecRegistro: fields[13] as String?,
      usrRegistro: fields[14] as String?,
      fecModific: fields[15] as String?,
      ursModific: fields[16] as String?,
      base64: fields[20] as String?,
      enlaceLogOffline: fields[21] as String?,
      estadoConDiscapacidad: fields[23] as bool?,
      colorDegradadoInicio: fields[25] as String?,
      colorDegradadoFin: fields[26] as String?,
      grupo: fields[27] as String?,
      grupoEnlaceLogoGrupo: fields[28] as String?,
      grupoEnlaceLogoGrupoOffline: fields[29] as String?,
      grupoColorDegradadoInicio: fields[30] as String?,
      grupoColorDegradadoFin: fields[31] as String?,
    )
      ..listRequisitos = (fields[17] as List?)?.cast<ModalidadRequisitoEntity>()
      ..listBeneficios = (fields[18] as List?)?.cast<ModalidadBeneficioEntity>()
      ..listImpedimentos =
          (fields[19] as List?)?.cast<ModalidadImpedimentoEntity>()
      ..listPalabras = (fields[22] as List?)?.cast<PalabraClaveEntity>()
      ..listDocumentoClave =
          (fields[24] as List?)?.cast<ModalidadDocumentoClaveEntity>();
  }

  @override
  void write(BinaryWriter writer, ModalidadEntity obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.modId)
      ..writeByte(1)
      ..write(obj.nomCompleto)
      ..writeByte(2)
      ..write(obj.nomCorto)
      ..writeByte(3)
      ..write(obj.codigo)
      ..writeByte(4)
      ..write(obj.enlaceMod)
      ..writeByte(5)
      ..write(obj.enlaceInform)
      ..writeByte(6)
      ..write(obj.enlaceLog)
      ..writeByte(7)
      ..write(obj.beneficios)
      ..writeByte(8)
      ..write(obj.impedimentos)
      ..writeByte(9)
      ..write(obj.vFecPostu)
      ..writeByte(10)
      ..write(obj.dFecPostu)
      ..writeByte(11)
      ..write(obj.publicada)
      ..writeByte(12)
      ..write(obj.estado)
      ..writeByte(13)
      ..write(obj.fecRegistro)
      ..writeByte(14)
      ..write(obj.usrRegistro)
      ..writeByte(15)
      ..write(obj.fecModific)
      ..writeByte(16)
      ..write(obj.ursModific)
      ..writeByte(17)
      ..write(obj.listRequisitos)
      ..writeByte(18)
      ..write(obj.listBeneficios)
      ..writeByte(19)
      ..write(obj.listImpedimentos)
      ..writeByte(20)
      ..write(obj.base64)
      ..writeByte(21)
      ..write(obj.enlaceLogOffline)
      ..writeByte(22)
      ..write(obj.listPalabras)
      ..writeByte(23)
      ..write(obj.estadoConDiscapacidad)
      ..writeByte(24)
      ..write(obj.listDocumentoClave)
      ..writeByte(25)
      ..write(obj.colorDegradadoInicio)
      ..writeByte(26)
      ..write(obj.colorDegradadoFin)
      ..writeByte(27)
      ..write(obj.grupo)
      ..writeByte(28)
      ..write(obj.grupoEnlaceLogoGrupo)
      ..writeByte(29)
      ..write(obj.grupoEnlaceLogoGrupoOffline)
      ..writeByte(30)
      ..write(obj.grupoColorDegradadoInicio)
      ..writeByte(31)
      ..write(obj.grupoColorDegradadoFin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModalidadEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
