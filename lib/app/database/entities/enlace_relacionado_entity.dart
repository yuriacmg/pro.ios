// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'enlace_relacionado_entity.g.dart';

@HiveType(typeId: 43)
class EnlaceRelacionadoEntity {
  @HiveField(0)
  int? iEnlaceRelacionadoId;
  @HiveField(1)
  int? iOrden;
  @HiveField(2)
  String? vNombre;
  @HiveField(3)
  String? vEnlace;
  @HiveField(4)
  String? vEnlaceImagen;
  @HiveField(5)
  String? vEnlaceImagenOffline;
  @HiveField(6)
  bool? estado;

  EnlaceRelacionadoEntity({
    this.iEnlaceRelacionadoId,
    this.iOrden,
    this.vNombre,
    this.vEnlace,
    this.vEnlaceImagen,
    this.vEnlaceImagenOffline,
    this.estado,
  });
}
