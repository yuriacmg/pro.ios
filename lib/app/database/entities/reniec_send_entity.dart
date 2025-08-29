// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'reniec_send_entity.g.dart';

@HiveType(typeId: 30)
class ReniecSendEntity {
  @HiveField(0)
  String? vNroDocumento;
  @HiveField(1)
  String? dFechaNacimiento;
  @HiveField(2)
  String? vUbigeo;
  @HiveField(3)
  String? vCodigoVerificacion;
  @HiveField(4)
  bool? bTerminosCondiciones;
  @HiveField(5)
  bool? bDeclaracionInformacion;
  @HiveField(6)
  String? vNroCelular;
  @HiveField(7)
  String? vNombres;
  @HiveField(8)
  String? vApellidoPaterno;
  @HiveField(9)
  String? vApellidoMaterno;

  ReniecSendEntity({
    this.vNroDocumento,
    this.dFechaNacimiento,
    this.vUbigeo,
    this.vCodigoVerificacion,
    this.vNroCelular,
    this.bTerminosCondiciones,
    this.bDeclaracionInformacion,
    this.vNombres,
    this.vApellidoPaterno,
    this.vApellidoMaterno,
  });
}
