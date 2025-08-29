// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'modalidad_beneficio_entity.g.dart';

@HiveType(typeId: 9)
class ModalidadBeneficioEntity{
  @HiveField(0)
  int? modBeneficiotId;
  @HiveField(1)
  int? beneficioId;
  @HiveField(2)
  int? modId;
  @HiveField(3)
  String? descripc;
  @HiveField(4)
  String? enlaceImg;
  @HiveField(5)
  int? orden;
  @HiveField(6)
  bool? estado;

  ModalidadBeneficioEntity({
    this.modBeneficiotId,
    this.beneficioId,
    this.modId,
    this.descripc,
    this.enlaceImg,
    this.orden,
    this.estado,
  });
}
