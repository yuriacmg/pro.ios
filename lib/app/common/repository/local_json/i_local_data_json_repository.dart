abstract class ILocalDataJsonRepository {
  Future<String> getDataJson(String path);
  Future<String> getDataJsonDev(String path);
  Future<String> getDataJsonStg(String path);
  Future<String> getDataJsonProd(String path);
  Future<String> getData(String path);
}
