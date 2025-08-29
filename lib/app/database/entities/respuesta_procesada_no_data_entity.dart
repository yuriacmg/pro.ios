// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'respuesta_procesada_no_data_entity.g.dart';

@HiveType(typeId: 24)
class RespuestaProcesadaNoDataEntity {
  @HiveField(0)
  bool? rptaBool;
  @HiveField(1)
  String? resultado;

  RespuestaProcesadaNoDataEntity({
    this.rptaBool,
    this.resultado,
  });
}
