// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
part 'data_reniec_entity.g.dart';

@HiveType(typeId: 3)
class DataReniecEntity {
  @HiveField(0)
  String? apellidoPaterno;
  @HiveField(1)
  String? apellidoMaterno;
  @HiveField(2)
  String? nombres;
  @HiveField(3)
  String? nombreCompleto;
  @HiveField(4)
  String? fechaNacimiento;
  @HiveField(5)
  String? sexo;
  @HiveField(6)
  String? numDocumento;
  @HiveField(7)
  List<RespuestaEntity>? preguntas;
  @HiveField(8)
  String? numCelular;

  DataReniecEntity({
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.nombres,
    this.nombreCompleto,
    this.fechaNacimiento,
    this.sexo,
    this.numDocumento,
    this.numCelular,
  });
}
