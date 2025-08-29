// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
part 'seccion_entity.g.dart';

@HiveType(typeId: 8)
class SeccionEntity {
  @HiveField(0)
  int? seccionId;
  @HiveField(1)
  String? codigo;
  @HiveField(2)
  String? nombre;
  @HiveField(3)
  String? descripcion;
  @HiveField(4)
  int? orden;
  @HiveField(5)
  bool? estado;

  @HiveField(6)
  List<PreguntaEntity>? preguntas;

  SeccionEntity({
    this.seccionId,
    this.codigo,
    this.nombre,
    this.descripcion,
    this.orden,
    this.estado,
  });
}
