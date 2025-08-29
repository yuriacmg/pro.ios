// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'modalidad_requisito_entity.g.dart';

@HiveType(typeId: 5)
class ModalidadRequisitoEntity {
  @HiveField(0)
  int? modRequisId;
  @HiveField(1)
  int? requisId;
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
  @HiveField(7)
  String? fecRegistro;
  @HiveField(8)
  String? usrRegistro;
  @HiveField(9)
  String? fecModific;
  @HiveField(10)
  String? ursModific;

  ModalidadRequisitoEntity({
    this.modRequisId,
    this.requisId,
    this.modId,
    this.descripc,
    this.enlaceImg,
    this.orden,
    this.estado,
    this.fecRegistro,
    this.usrRegistro,
    this.fecModific,
    this.ursModific,
  });
}
