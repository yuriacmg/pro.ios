// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'prepare_area_hijo_entity.g.dart';

@HiveType(typeId: 34)
class PrepareAreaHijoEntity {
  @HiveField(0)
  String? codigo;
  @HiveField(1)
  String? codigoPadre;
  @HiveField(2)
  String? nombre;
  @HiveField(3)
  String? enlaceLogo;
  @HiveField(4)
  int? orden;
  @HiveField(5)
  String? enlaceLogoOffline;

  PrepareAreaHijoEntity({
    this.codigo,
    this.codigoPadre,
    this.nombre,
    this.enlaceLogo,
    this.orden,
    this.enlaceLogoOffline,
  });
}
