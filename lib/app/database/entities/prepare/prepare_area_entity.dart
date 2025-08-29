// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'prepare_area_entity.g.dart';

@HiveType(typeId: 19)
class PrepareAreaEntity {
  @HiveField(0)
  String? codigo;
  @HiveField(1)
  String? nombre;
  @HiveField(2)
  String? enlaceLogo;
  @HiveField(3)
  int? orden;
  @HiveField(4)
  String? enlaceLogoOffline;

  PrepareAreaEntity({
    this.codigo,
    this.nombre,
    this.enlaceLogo,
    this.orden,
    this.enlaceLogoOffline,
  });
}
