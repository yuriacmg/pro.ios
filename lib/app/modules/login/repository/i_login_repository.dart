// ignore_for_file: lines_longer_than_80_chars

import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/modules/login/model/login_send_model.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_send_model.dart';

abstract class IloginRepository {
  Future<APIResponseModel> login(LoginSendModel send);
  Future<APIResponseModel> registerAccount(RegisterAccountSendModel send);
  Future<APIResponseModel> validAccount(ValidAccountSendModel send);
  Future<APIResponseModel> updateProfile(PasswordProfileUpdateSendModel send);
  Future<APIResponseModel> recoveryPasswordCode(RecoveryPasswordSendModel send);
  Future<APIResponseModel> getUser(int userId);
  Future<APIResponseModel> validEmailAccount(RecodeAccountEmailSendModel send);
  Future<APIResponseModel> validEmailCode(ValidCodeEmailSendModel send);
}
