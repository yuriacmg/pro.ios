// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation, cascade_invocations, avoid_dynamic_calls, omit_local_variable_types, strict_raw_type
import 'dart:io';

//import 'package:device_information/device_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/notice_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/model/version_response_model2.dart';
import 'package:perubeca/app/common/model/version_send_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/database/entities/version_entity.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:unique_identifier/unique_identifier.dart';

class UtilService {
  final dio = getItApp.get<Dio>();

  Future<APIResponseModel> getVersionApp(VersionSendModel send) async {
    final res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      dio.options.headers['Access-Control-Request-Method'] = 'GET, POST, PUT';
      final response = await dio.post(
        '/pronabecapp/comun/getVersionApp',
        data: send.toJson(),
      );
      final data = VersionResponseModel2.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        res
          ..status = true
          ..statusCode = int.parse(response.statusCode!.toString())
          ..data = data;
      } else {
        res
          ..status = false
          ..statusCode = 400
          ..data = null;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          res
            ..status = false
            ..statusCode = 950 // codigo que no hay internet
            ..data = getErrorInternet();
        } else {
          res
            ..status = false
            ..statusCode = e.response == null ? 500 : int.parse(e.response!.statusCode.toString())
            ..data = getErrorInit();
        }
      }
    }

    return res;
  }

  Future<APIResponseModel> getNoticeApp() async {
    final res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      // dio.options.headers['Access-Control-Request-Method'] = 'GET, POST, PUT';
      final response = await dio.get('/pronabecapp/Comunicado/getComunicado');
      final data = NoticeResponseModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode == 200) {
        res
          ..status = true
          ..statusCode = int.parse(response.statusCode!.toString())
          ..data = data;
      } else {
        res
          ..status = false
          ..statusCode = 400
          ..data = null;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          res
            ..status = false
            ..statusCode = 950 // codigo que no hay internet
            ..data = getErrorInternet();
        } else {
          res
            ..status = false
            ..statusCode = e.response == null ? 500 : int.parse(e.response!.statusCode.toString())
            ..data = getErrorInit();
        }
      }
    }

    return res;
  }

  Future<APIResponseModel> getStatusServices( int parametro) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.get('/pronabecapp/Comun/getValidarServiciosExternos/$parametro');
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = StatusServicesResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  //
  Future<String> getAppCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<VersionEntity?> getAppCurrentDataApp() async {
    final versionbox = await Hive.openBox<VersionEntity>('versionBox');
    return versionbox.values.isEmpty ? null : versionbox.values.first;
    // return  null; //versionBox.getAll().isEmpty ? null : versionBox.getAll().first;
  }

  Future<VersionSendModel> getDeviceInfo() async {
    final model = VersionSendModel(
      versionOs: 'Unknown',
      descOs: 'Unknown',
      ip: 'Unknown',
      tokenPushNoti: 'Unknown',
      idUnicoPushNoti: 'Unknown',
    );

    if (!kIsWeb) {
      //final platformVersion = await DeviceInformation.platformVersion;
      //final apiLevel = (await DeviceInformation.apiLevel).toString();
      //final packageInfo = await PackageInfo.fromPlatform();

      final networkInfo = NetworkInfo();
      final ip = await networkInfo.getWifiIP();
      String ip1 = '';
      String? identifier;
      try {
        identifier = await UniqueIdentifier.serial;
        ip1 = await getIPAddress();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }

      model.idUnicoPushNoti = identifier ?? 'string';
      model.descOs = 'platformVersion';
      model.versionOs = 'apiLevel';
      model.ip = ip ?? ip1;
      model.tokenPushNoti = 'string';
    }

    return model;
  }


  Future<String> getIPAddress() async {
    try {
      for (final interface in await NetworkInterface.list()) {
        for (final addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print('Error getting IP address: $e');
    }
    return '0.0.0.0';
  }
}
