// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'combo_entity.g.dart';

@HiveType(typeId: 32)
class ComboEntity {
  @HiveField(0)
  int? generalId;
  @HiveField(1)
  String? nombre;
  @HiveField(2)
  int? type;

  ComboEntity({
    this.generalId,
    this.nombre,
    this.type,
  });
}
