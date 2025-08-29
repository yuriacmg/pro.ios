// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'consulta_siage_entity.g.dart';

@HiveType(typeId: 17)
class ConsultaSiageEntity {
  @HiveField(0)
  String? grado;
  @HiveField(1)
  String? condicion;

  ConsultaSiageEntity({
    this.grado,
    this.condicion,
  });
}
