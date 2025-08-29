// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';

part 'prepare_history_entity.g.dart';

@HiveType(typeId: 25)
class PrepareHistoryEntity {
  @HiveField(0)
  int? areaCode;
  @HiveField(1)
  String? areaName;
  @HiveField(2)
  String? userName;
  @HiveField(3)
  int? attempsNumber;
  @HiveField(4)
  int? inputNumber;
  @HiveField(5)
  DateTime? startDate;
  @HiveField(6)
  DateTime? startEnd;
  @HiveField(7)
  int? score;
  @HiveField(8)
  int? totalCorrect;
  @HiveField(9)
  int? totalError;
  @HiveField(10)
  int? totalUnanswered;
  @HiveField(11)
  String? numberDoc;
  PrepareHistoryEntity({
    this.areaCode,
    this.areaName,
    this.userName,
    this.attempsNumber,
    this.inputNumber,
    this.startDate,
    this.startEnd,
    this.score,
    this.totalCorrect,
    this.totalError,
    this.totalUnanswered,
    this.numberDoc,
  });
}
