// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'area_user_history_entity.g.dart';

@HiveType(typeId: 31)
class AreaUserHistoryEntity {
  @HiveField(0)
  int? areaId;
  @HiveField(1)
  int? areaStatus;
  @HiveField(2)
  String? areaName;
  @HiveField(3)
  String? userDocument;
  @HiveField(4)
  int? areaIntentos;
  @HiveField(5)
  int? generalCode;
  @HiveField(6)
  int? areaCode;
  @HiveField(7)
  String? areaGeneralCode;
  AreaUserHistoryEntity({
    this.areaId,
    this.areaStatus,
    this.areaName,
    this.userDocument,
    this.areaIntentos,
    this.generalCode,
    this.areaCode,
    this.areaGeneralCode,
  });
}
