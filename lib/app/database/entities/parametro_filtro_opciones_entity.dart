// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';

part 'parametro_filtro_opciones_entity.g.dart';

@HiveType(typeId: 39)
class ParametroFiltroOpcionesEntity {
  @HiveField(0)
  int? filtroContenidoId;
  @HiveField(1)
  int? filtroId;
  @HiveField(2)
  String? opciones;
  @HiveField(3)
  int? orden;

  ParametroFiltroOpcionesEntity({
    this.filtroId,
    this.filtroContenidoId,
    this.opciones,
    this.orden,
  });
}
