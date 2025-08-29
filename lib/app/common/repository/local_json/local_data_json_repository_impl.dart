import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/local_json/i_local_data_json_repository.dart';

import 'package:perubeca/app/common/service/local_data_json_service.dart';

class LocalDataJsonRepositoryImpl extends ILocalDataJsonRepository {
  LocalDataJsonRepositoryImpl();

  final LocalDataJsonService service = getItApp.get<LocalDataJsonService>();

  @override
  Future<String> getDataJson(String path) => service.loadData(path);

  @override
  Future<String> getDataJsonDev(String path) => service.loadDataDev(path);

  @override
  Future<String> getDataJsonStg(String path) => service.loadDataStg(path);

  @override
  Future<String> getDataJsonProd(String path) => service.loadDataProd(path);

  @override
  Future<String> getData(String path) {
    throw UnimplementedError();
  }
}
