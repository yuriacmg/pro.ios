// ignore_for_file: lines_longer_than_80_chars

import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/modules/login/model/login_send_model.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_send_model.dart';
import 'package:perubeca/app/modules/login/repository/i_login_repository.dart';
import 'package:perubeca/app/modules/login/service/login_service.dart';

class LoginRepositoryImpl extends IloginRepository{
  final LoginService service = getItApp.get<LoginService>();
  
  @override
  Future<APIResponseModel> login(LoginSendModel send) {
   return service.login(send);
  }

  @override
  Future<APIResponseModel> updateProfile( PasswordProfileUpdateSendModel send ) {
    return service.updateProfile(send);
  }

  @override
  Future<APIResponseModel> registerAccount(RegisterAccountSendModel send) {
    return service.registerAccount(send);
  }

  @override
  Future<APIResponseModel> validAccount( ValidAccountSendModel send ) {
    return service.validAccount(send);
  }

  @override
  Future<APIResponseModel> recoveryPasswordCode(RecoveryPasswordSendModel send) {
    return service.recoveryPasswordCode(send);
  }

  @override
  Future<APIResponseModel> getUser(int userId) {
    return service.getUser(userId);
  }

  @override
  Future<APIResponseModel> validEmailAccount(RecodeAccountEmailSendModel send) {
    return service.validEmailAccount(send);
  }

  @override
  Future<APIResponseModel> validEmailCode(ValidCodeEmailSendModel send) {
    return service.validEmailCode(send);
  }

}
