// ignore_for_file: cascade_invocations

import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/version_entity.dart';

class LocalVersionService {
  
  Future<void> addUpdateVersion(VersionEntity entity) async {
    final versionbox = await Hive.openBox<VersionEntity>('versionBox');
    await versionbox.clear();
    await versionbox.add(entity);
  }
}
