// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'reniec_performance_entity.g.dart';

@HiveType(typeId: 16)
class ReniecPerformanceEntity {
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
  String? resultadoSiagie;
  @HiveField(8)
  bool? rptaSiagieBool;
  @HiveField(9)
  String? notara;

  ReniecPerformanceEntity({
    this.apePaterno,
    this.apeMaterno,
    this.nombre,
    this.nombreCompleto,
    this.fecNacimiento,
    this.numdoc,
    this.sexo,
    this.resultadoSiagie,
    this.rptaSiagieBool,
    this.notara,
  });
}
