import 'package:hive/hive.dart';

part 'modalidad_documento_clave_entity.g.dart';

@HiveType(typeId: 45)
class ModalidadDocumentoClaveEntity {
  @HiveField(0)
  int? modDocClaveId;
  @HiveField(1)
  int? modId;
  @HiveField(2)
  String? descripc;
  @HiveField(3)
  int? orden;
  @HiveField(4)
  bool? estado;

  ModalidadDocumentoClaveEntity({
    this.modDocClaveId,
    this.modId,
    this.descripc,
    this.orden,
    this.estado,
  });
}
