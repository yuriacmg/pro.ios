// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';

part 'palabras_clave_entity.g.dart';

@HiveType(typeId: 37)
class PalabraClaveEntity {
  @HiveField(0)
  int? filtroContenidoId;
  @HiveField(1)
  int? modId;

  PalabraClaveEntity({
    this.filtroContenidoId,
    this.modId,
  });
}
