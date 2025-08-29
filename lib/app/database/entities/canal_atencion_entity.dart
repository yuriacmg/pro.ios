// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'canal_atencion_entity.g.dart';

@HiveType(typeId: 1)
class CanalAtencionEntity {
  @HiveField(0)
  int? canalId;
  @HiveField(1)
  String? nombreCanal;
  @HiveField(2)
  String? detalleCanal;
  @HiveField(3)
  String? enlaceImg;
  @HiveField(4)
  String? enlaceCanAte;

  CanalAtencionEntity({
    this.canalId,
    this.nombreCanal,
    this.detalleCanal,
    this.enlaceImg,
    this.enlaceCanAte,
  });
}
