// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'data_reniec_review_sign_entity.g.dart';

@HiveType(typeId: 12)
class DataReniecReviewSignEntity {
  @HiveField(0)
  String? apePaterno;
  @HiveField(1)
  String? apeMaterno;
  @HiveField(2)
  String? nombre;
  @HiveField(3)
  String? nombreCompleto;
  @HiveField(4)
  String? fecNacimiento;
  @HiveField(5)
  String? numdoc;
  @HiveField(6)
  String? sexo;
  @HiveField(7)
  String? concurso;
  @HiveField(8)
  String? modalidad;
  @HiveField(9)
  String? fecPostulacion;

  DataReniecReviewSignEntity({
    this.apePaterno,
    this.apeMaterno,
    this.nombre,
    this.nombreCompleto,
    this.fecNacimiento,
    this.numdoc,
    this.sexo,
    this.concurso,
    this.modalidad,
    this.fecPostulacion,
  });
}
