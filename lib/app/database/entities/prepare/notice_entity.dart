// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'notice_entity.g.dart';

@HiveType(typeId: 28)
class NoticeEntity {
  @HiveField(0)
  int? codigo;
  @HiveField(1)
  String? titulo;
  @HiveField(2)
  String? contenido;
  @HiveField(3)
  bool? estado;
  NoticeEntity({
    this.codigo,
    this.titulo,
    this.contenido,
    this.estado,
  });
}
