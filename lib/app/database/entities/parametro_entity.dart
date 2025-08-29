// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/parametro_funcion_pregunta_entity.dart';
part 'parametro_entity.g.dart';

@HiveType(typeId: 35)
class ParametroEntity {
  @HiveField(0)
  int? modalidadId;
  @HiveField(1)
  List<ParametroFuncionPreguntaEntity>? funcionPregunta;

  ParametroEntity({
    this.modalidadId,
  });
}
