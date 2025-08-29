import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/version_send_model.dart';

abstract class IUtilRepository {
  Future<APIResponseModel> getStatusServices(int parametro);
  Future<APIResponseModel> getNoticeApp();
  Future<APIResponseModel> getVersionApp(VersionSendModel send);
}
