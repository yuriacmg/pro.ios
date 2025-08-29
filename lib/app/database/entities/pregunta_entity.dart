// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
part 'pregunta_entity.g.dart';

@HiveType(typeId: 6)
class PreguntaEntity {
  @HiveField(0)
  int? preguntaId;
  @HiveField(1)
  int? seccionId;
  @HiveField(2)
  String? codigo;
  @HiveField(3)
  String? enunciado;
  @HiveField(4)
  String? detalle;
  @HiveField(5)
  String? enlaceImg;
  @HiveField(6)
  int? tipoId;
  @HiveField(7)
  bool? estado;
  @HiveField(8)
  String? fecRegistro;
  @HiveField(9)
  String? usrRegistro;
  @HiveField(10)
  String? fecModific;
  @HiveField(11)
  String? ursModific;
  @HiveField(12)
  int? orden;
  @HiveField(13)
  String? titulolista;
  @HiveField(14)
  List<PreguntaOpcionesEntity>? opciones;
  @HiveField(15)
  String? enlaceImgOffline;

  PreguntaEntity({
    this.preguntaId,
    this.seccionId,
    this.codigo,
    this.enunciado,
    this.detalle,
    this.enlaceImg,
    this.tipoId,
    this.estado,
    this.fecRegistro,
    this.usrRegistro,
    this.fecModific,
    this.ursModific,
    this.orden,
    this.titulolista,
    this.enlaceImgOffline,
  });
}
