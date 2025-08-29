// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';

part 'modalidad_impedimento_entity.g.dart';

@HiveType(typeId: 11)
class ModalidadImpedimentoEntity {
  @HiveField(0)
  int? modImpedId;
  @HiveField(1)
  int? impedId;
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

  ModalidadImpedimentoEntity({
    this.modImpedId,
    this.impedId,
    this.modId,
    this.descripc,
    this.enlaceImg,
    this.orden,
    this.estado,
  });
}
