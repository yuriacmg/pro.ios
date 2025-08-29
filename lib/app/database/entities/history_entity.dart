// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'history_entity.g.dart';

@HiveType(typeId: 15)
class HistoryEntity {
  @HiveField(0)
  String? numDocument;
  @HiveField(1)
  String? fullname;
  @HiveField(2)
  String? send;
  @HiveField(3)
  String? response;
  @HiveField(4)
  String? dateSend;
  @HiveField(5)
  String? names;
  @HiveField(6)
  String? lastName;
  @HiveField(7)
  bool? isForeign;
  @HiveField(8)
  bool? isLocal;
  @HiveField(9)
  String? dataSendLocal;
  @HiveField(10)
  int? localId;
  @HiveField(11)
  bool? isSync;
  @HiveField(12)
  String? digitoVerificador;
  @HiveField(13)
  String? ubigeo;
  @HiveField(14)
  String? fechaNacimiento;
  @HiveField(15)
  String? syncErrorMessage;

  HistoryEntity({
    this.numDocument,
    this.fullname,
    this.names,
    this.lastName,
    this.send,
    this.response,
    this.dateSend,
    this.isForeign,
    this.isLocal = false,
    this.dataSendLocal,
    this.localId,
    this.isSync = false,
    this.digitoVerificador,
    this.ubigeo,
    this.fechaNacimiento,
  });
}
