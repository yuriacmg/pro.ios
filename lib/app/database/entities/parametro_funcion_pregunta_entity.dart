// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'parametro_funcion_pregunta_entity.g.dart';

@HiveType(typeId: 36)
class ParametroFuncionPreguntaEntity {
  @HiveField(0)
  int? modalidadId;
  @HiveField(1)
  String? tipo;
  @HiveField(2)
  String? nombre;
  @HiveField(3)
  List<String>? parametro;
  @HiveField(4)
  String? operador;
  @HiveField(5)
  String? valorRespuesta;


  ParametroFuncionPreguntaEntity({
    this.modalidadId,
    this.tipo,
    this.nombre,
    this.parametro,
    this.operador,
    this.valorRespuesta,
  });
}
