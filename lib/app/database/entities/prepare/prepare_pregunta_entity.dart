// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';

part 'prepare_pregunta_entity.g.dart';

@HiveType(typeId: 23)
class PreparePreguntaEntity {
  @HiveField(0)
  int? preguntaId;
  @HiveField(1)
  String? pregunta;
  @HiveField(2)
  String? comentarios;
  @HiveField(3)
  String? enlaceImagen;
  @HiveField(4)
  int? orden;
  @HiveField(5)
  String? respuesta;
  @HiveField(6)
  int? codigoCourse;
  @HiveField(7)
  int? simulacroId;
  @HiveField(8)
  String? tipo;
  @HiveField(9)
  int? preguntaPadreId;
  @HiveField(10)
  String? area;
  @HiveField(11)
  List<PrepareAlternativeEntity>? alternatives;
  @HiveField(12)
  String? preguntaOffline;
  @HiveField(13)
  String? comentarioOffline;
  @HiveField(14)
  String? enlaceImagenOffline;

  PreparePreguntaEntity({
    this.preguntaId,
    this.pregunta,
    this.comentarios,
    this.enlaceImagen,
    this.orden,
    this.respuesta,
    this.codigoCourse,
    this.simulacroId,
    this.tipo,
    this.preguntaPadreId,
    this.area,
    this.preguntaOffline,
    this.comentarioOffline,
    this.enlaceImagenOffline,
  });
}
