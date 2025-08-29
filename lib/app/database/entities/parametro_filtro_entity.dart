// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';

part 'parametro_filtro_entity.g.dart';

@HiveType(typeId: 38)
class ParametroFiltroEntity {
  @HiveField(0)
  int? filtroId;
  @HiveField(1)
  String? tipo;
  @HiveField(2)
  String? objeto;
  @HiveField(3)
  String? titulo;
  @HiveField(4)
  List<ParametroFiltroOpcionesEntity>? opciones;
  @HiveField(5)
  int? orden;

  ParametroFiltroEntity({
    this.filtroId = 0,
    this.tipo,
    this.objeto,
    this.titulo,
    this.opciones,
    this.orden,
  });
}
