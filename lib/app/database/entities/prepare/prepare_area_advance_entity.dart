// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'prepare_area_advance_entity.g.dart';

@HiveType(typeId: 26)
class PrepareAreaAdvanceEntity {
  @HiveField(0)
  int? preguntaId;
  @HiveField(1)
  int? respuestaMarcada;
  @HiveField(2)
  int? courseCode;
  @HiveField(3)
  String? userDocument;
  @HiveField(4)
  int? generalCode;
  @HiveField(5)
  String? areaGeneralCode;
  @HiveField(6)
  int? areaCode;
  PrepareAreaAdvanceEntity({
    this.preguntaId,
    this.respuestaMarcada,
    this.courseCode,
    this.userDocument,
    this.generalCode,
    this.areaGeneralCode,
    this.areaCode,
  });
}
