// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'apoderado_entity.g.dart';

@HiveType(typeId: 29)
class ApoderadoEntity {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? respuesta;

  ApoderadoEntity({
    this.name,
    this.respuesta,
  });
}
