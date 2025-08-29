import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/service/auth_service.dart';

class AuthRepositoryImpl extends IAuthRepository {
  AuthRepositoryImpl();

  final AuthService service = getItApp.get<AuthService>();

  @override
  Future<APIResponseModel> getTokenAutorization() {
    return service.getTokenAutorization();
  }
}
