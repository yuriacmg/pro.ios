// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'prepare_area_common_entity.g.dart';

@HiveType(typeId: 20)
class PrepareAreaCommonEntity {
  @HiveField(0)
  int? codigo;
  @HiveField(1)
  String? nombre;
  @HiveField(2)
  int? orden;
  @HiveField(3)
  int? nroPregunta;
  @HiveField(4)
  String? enlaceLogo;
  @HiveField(5)
  int? status; //1-iniciar, 2-en proceso,3-completado
  @HiveField(6)
  int? codigoPreparate;
  @HiveField(7)
  String? enlaceLogoOffline;
  PrepareAreaCommonEntity({
    this.codigo,
    this.nombre,
    this.orden,
    this.nroPregunta,
    this.enlaceLogo,
    this.status,
    this.codigoPreparate,
    this.enlaceLogoOffline,
  });
}
