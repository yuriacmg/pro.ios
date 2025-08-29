// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'pregunta_frecuente_entity.g.dart';

@HiveType(typeId: 42)
class PreguntaFrecuenteEntity {
  @HiveField(0)
  int? iPreguntaFrecuenteId;
  @HiveField(1)
  int? iOrden;
  @HiveField(2)
  String? vTitulo;
  @HiveField(3)
  String? vContenido;
  @HiveField(4)
  bool? estado;



  PreguntaFrecuenteEntity({
    this.iPreguntaFrecuenteId,
    this.iOrden,
    this.vTitulo,
    this.vContenido,
    this.estado,
  });
}
