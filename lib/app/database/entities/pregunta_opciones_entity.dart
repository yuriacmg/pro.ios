// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'pregunta_opciones_entity.g.dart';

@HiveType(typeId: 10)
class PreguntaOpcionesEntity{
  @HiveField(0)
  int? alternativaId;
  @HiveField(1)
  String? nombre;
  @HiveField(2)
  int? preguntaId;
  @HiveField(3)
  String valor;

  PreguntaOpcionesEntity({
    required this.valor, 
    this.alternativaId,
    this.nombre,
    this.preguntaId,
  });
}
