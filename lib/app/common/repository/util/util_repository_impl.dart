import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/version_send_model.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/service/util_service.dart';

class UtilRepositoryImpl extends IUtilRepository {
  UtilRepositoryImpl();

  final UtilService service = getItApp.get<UtilService>();

  @override
  Future<APIResponseModel> getNoticeApp() {
    return service.getNoticeApp();
  }

  @override
  Future<APIResponseModel> getStatusServices(int parametro) {
    return service.getStatusServices(parametro);
  }

  @override
  Future<APIResponseModel> getVersionApp(VersionSendModel send) {
    return service.getVersionApp(send);
  }
}
