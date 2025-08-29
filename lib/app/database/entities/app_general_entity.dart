// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
part 'app_general_entity.g.dart';

@HiveType(typeId: 18)
class AppGeneralEntity {
  @HiveField(0)
  String? firstTime;

  AppGeneralEntity({
    this.firstTime,
  });
}
