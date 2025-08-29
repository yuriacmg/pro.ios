// ignore_for_file: sort_constructors_first

//import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/modules/scholarship/model/new_scholarship_response_model.dart';
part 'beca_otro_pais_hijo_entity.g.dart';

@HiveType(typeId: 41)
class BecaOtroPaisHijoEntity {
  @HiveField(0)
  int? iBopId;
  @HiveField(1)
  String? vTituloBop;
  @HiveField(2)
  String? vDescripcionTituloBop;
  @HiveField(3)
  bool? bPadreBop;
  @HiveField(4)
  int? iBopIdPadre;
  @HiveField(5)
  String? vNombreBop;
  @HiveField(6)
  String? vDescripcionNombreBop;
  @HiveField(7)
  String? vCodigo;
  @HiveField(8)
  String? vEnlaceBop;
  @HiveField(9)
  String? vEnlaceInformacionBop;
  @HiveField(10)
  String? vEnlaceLogoBop;
  @HiveField(11)
  String? vEnlaceLogoBopOffline;
  @HiveField(12)
  String? vFechaPostulacion;
  @HiveField(13)
  String? dFechaPostulacion;
  @HiveField(14)
  List<BecasOtrosPaisesHijos>? becasOtrosPaisesHijos;


  BecaOtroPaisHijoEntity({
    this.iBopId,
    this.vTituloBop,
    this.vDescripcionTituloBop,
    this.bPadreBop,
    this.iBopIdPadre,
    this.vNombreBop,
    this.vDescripcionNombreBop,
    this.vCodigo,
    this.vEnlaceBop,
    this.vEnlaceInformacionBop,
    this.vEnlaceLogoBop,
    this.vEnlaceLogoBopOffline,
    this.vFechaPostulacion,
    this.dFechaPostulacion,
  });
}
