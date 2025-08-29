// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'prepare_alternative_entity.g.dart';

@HiveType(typeId: 22)
class PrepareAlternativeEntity {
  @HiveField(0)
  int? alternativaId;
  @HiveField(1)
  int? preguntaId;
  @HiveField(2)
  String? codigo;
  @HiveField(3)
  String? alternativa;
  @HiveField(4)
  String? enlaceImagen;
  @HiveField(5)
  String? type;
  @HiveField(6)
  String? typeAlternativa;
  @HiveField(7)
  String? alternativaOffline;
  @HiveField(8)
  String? enlaceImagenOffline;
  @HiveField(9)
  String? typeAlternativaOffline;
  PrepareAlternativeEntity({
    this.alternativaId,
    this.preguntaId,
    this.codigo,
    this.alternativa,
    this.enlaceImagen,
    this.type,
    this.typeAlternativa,
    this.alternativaOffline,
    this.enlaceImagenOffline,
    this.typeAlternativaOffline,
  });
}
