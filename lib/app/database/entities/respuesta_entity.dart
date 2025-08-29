// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'respuesta_entity.g.dart';

@HiveType(typeId: 13)
class RespuestaEntity {
  @HiveField(0)
  int? preguntaId;
  @HiveField(1)
  int? alternativaRespuesta;
  @HiveField(2)
  bool? respuestaAutomatica;
  @HiveField(3)
  String? texto;
  @HiveField(4)
  bool? rptIcono;

  RespuestaEntity({
    this.preguntaId,
    this.alternativaRespuesta,
    this.respuestaAutomatica,
    this.texto,
    this.rptIcono,
  });
}
