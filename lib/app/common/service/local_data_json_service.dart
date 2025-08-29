import 'package:flutter/services.dart';

class LocalDataJsonService {
  Future<String> loadData(String pathRelative) {
    return rootBundle.loadString('assets/static_data/$pathRelative');
  }

  Future<String> loadDataDev(String pathRelative) {
    return rootBundle.loadString('assets/static_data/dev/$pathRelative');
  }

  Future<String> loadDataStg(String pathRelative) {
    return rootBundle.loadString('assets/static_data/stg/$pathRelative');
  }

  Future<String> loadDataProd(String pathRelative) {
    return rootBundle.loadString('assets/static_data/prod/$pathRelative');
  }
}
