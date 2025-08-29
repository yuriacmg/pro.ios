// ignore_for_file: sort_constructors_first

//import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_documento_clave_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/palabras_clave_entity.dart';
part 'modalidad_entity.g.dart';

@HiveType(typeId: 4)
class ModalidadEntity {
  @HiveField(0)
  int? modId;
  @HiveField(1)
  String? nomCompleto;
  @HiveField(2)
  String? nomCorto;
  @HiveField(3)
  String? codigo;
  @HiveField(4)
  String? enlaceMod;
  @HiveField(5)
  String? enlaceInform;
  @HiveField(6)
  String? enlaceLog;
  @HiveField(7)
  String? beneficios;
  @HiveField(8)
  String? impedimentos;
  @HiveField(9)
  String? vFecPostu;
  @HiveField(10)
  String? dFecPostu;
  @HiveField(11)
  bool? publicada;
  @HiveField(12)
  bool? estado;
  @HiveField(13)
  String? fecRegistro;
  @HiveField(14)
  String? usrRegistro;
  @HiveField(15)
  String? fecModific;
  @HiveField(16)
  String? ursModific;
  @HiveField(17)
  List<ModalidadRequisitoEntity>? listRequisitos;
  @HiveField(18)
  List<ModalidadBeneficioEntity>? listBeneficios;
  @HiveField(19)
  List<ModalidadImpedimentoEntity>? listImpedimentos;
  @HiveField(20)
  String? base64;
  @HiveField(21)
  String? enlaceLogOffline;
  @HiveField(22)
  List<PalabraClaveEntity>? listPalabras;
  @HiveField(23)
  bool? estadoConDiscapacidad;
  @HiveField(24)
  List<ModalidadDocumentoClaveEntity>? listDocumentoClave;
  @HiveField(25)
  String? colorDegradadoInicio;
  @HiveField(26)
  String? colorDegradadoFin;
  @HiveField(27)
  String? grupo;
  @HiveField(28)
  String? grupoEnlaceLogoGrupo;
  @HiveField(29)
  String? grupoEnlaceLogoGrupoOffline;
  @HiveField(30)
  String? grupoColorDegradadoInicio;
  @HiveField(31)
  String? grupoColorDegradadoFin;

  ModalidadEntity({
    this.modId,
    this.nomCompleto,
    this.nomCorto,
    this.codigo,
    this.enlaceMod,
    this.enlaceInform,
    this.enlaceLog,
    this.beneficios,
    this.impedimentos,
    this.vFecPostu,
    this.dFecPostu,
    this.publicada,
    this.estado,
    this.fecRegistro,
    this.usrRegistro,
    this.fecModific,
    this.ursModific,
    this.base64,
    this.enlaceLogOffline,
    this.estadoConDiscapacidad,
    this.colorDegradadoInicio,
    this.colorDegradadoFin,
    this.grupo,
    this.grupoEnlaceLogoGrupo,
    this.grupoEnlaceLogoGrupoOffline,
    this.grupoColorDegradadoInicio,
    this.grupoColorDegradadoFin
  });
}
