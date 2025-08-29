// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/modules/login/model/login_response_model.dart';
import 'package:perubeca/app/modules/login/model/login_send_model.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_response_model.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/model/profile_response_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_response_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_response_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_response_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_response_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_response_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_send_model.dart';
import 'package:perubeca/app/utils/methods.dart';

class LoginService {
  final dio = getItApp.get<Dio>();

  Future<APIResponseModel> login(LoginSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postLoginCuenta', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = LoginResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> registerAccount(RegisterAccountSendModel send ) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postCrearCuenta', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = RegisterAccountResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }
  
  Future<APIResponseModel> validAccount(ValidAccountSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postValidarCodigo', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ValidAccountResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> recoveryPasswordCode(RecoveryPasswordSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postRecuperarCuenta', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = RecoveryPasswordResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> updateProfile(PasswordProfileUpdateSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postEditarPerfil', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = PasswordProfileUpdateResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> getUser(int userId) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postObtenerUsuario', data: {'i_RegistroId': userId});
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ProfileResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> validEmailAccount(RecodeAccountEmailSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postRecuperarCuentaEmail', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = RecodeAccountEmailResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> validEmailCode(ValidCodeEmailSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Usuario/postValidarCodigoEmail', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ValidCodeEmailResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }
}
