// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'profile_entity.g.dart';

@HiveType(typeId: 33)
class ProfileEntity {
  @HiveField(0)
  int? iRegistroId;
  @HiveField(1)
  String? vNroDocumento;
  @HiveField(2)
  String? vEmail;
  @HiveField(3)
  String? vNombres;
  @HiveField(4)
  String? vApellidos;
  @HiveField(5)
  String? vFechaNacimiento;
  @HiveField(6)
  String? vUbigeo;
  @HiveField(7)
  String? vDigitoVerificador;
  @HiveField(8)
  String? vCelular;
  @HiveField(9)
  String? vPrefijo;

  ProfileEntity({
    this.iRegistroId,
    this.vNroDocumento,
    this.vEmail,
    this.vNombres,
    this.vApellidos,
    this.vFechaNacimiento,
    this.vUbigeo,
    this.vDigitoVerificador,
    this.vCelular,
    this.vPrefijo,
  });
}
