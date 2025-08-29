// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'respuesta_procesada_entity.g.dart';

@HiveType(typeId: 14)
class RespuestaProcesadaEntity {
  @HiveField(0)
  int? modId;
  @HiveField(1)
  int? consultaId;

  RespuestaProcesadaEntity({
    this.modId,
    this.consultaId,
  });
}
