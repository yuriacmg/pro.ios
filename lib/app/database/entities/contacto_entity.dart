// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'contacto_entity.g.dart';

@HiveType(typeId: 2)
class ContactoEntity {
  @HiveField(0)
  int? contactoId;
  @HiveField(1)
  String? nombre;
  @HiveField(2)
  int? tipo;
  @HiveField(3)
  String? detalle;
  @HiveField(4)
  String? enlaceImg;
  @HiveField(5)
  String? enlaceCont;
  @HiveField(6)
  bool? estado;

  ContactoEntity({
    this.contactoId,
    this.nombre,
    this.tipo,
    this.detalle,
    this.enlaceImg,
    this.enlaceCont,
    this.estado,
  });
}
