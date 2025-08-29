// ignore_for_file: sort_constructors_first
import 'package:hive/hive.dart';
part 'version_entity.g.dart';

@HiveType(typeId: 7)
class VersionEntity {
  @HiveField(0)
  List<String>? versionApp;
  @HiveField(1)
  String? versionCont;
  @HiveField(2)
  String? fechaVerApp;
  @HiveField(3)
  String? fechaVerCont;
  @HiveField(4)
  List<String>? versionAppIOS;

  VersionEntity({
    this.versionApp,
    this.versionCont,
    this.fechaVerApp,
    this.fechaVerCont,
    this.versionAppIOS,
  });
}
