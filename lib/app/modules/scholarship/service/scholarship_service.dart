// ignore_for_file: inference_failure_on_function_invocation, lines_longer_than_80_chars, avoid_dynamic_calls, depend_on_referenced_packages
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/modules/history/model/hisrtoy_sync_response_model.dart';
import 'package:perubeca/app/modules/history/model/history_sync_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/download_file_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_search_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/new_scholarship_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/prepare_examen_init_data_response_model2.dart';
import 'package:perubeca/app/modules/scholarship/model/prepare_examen_init_data_response_model3.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_minor_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_performance_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_prepare_exam_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_response_model2.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_review_sign_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/report_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/send_report_model.dart';
import 'package:perubeca/app/utils/methods.dart';

class ScholarShipService {
  final dio = getItApp.get<Dio>();

  Future<APIResponseModel> getScholarship() async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.get('/pronabecapp/Comun/GetContenidoApp');
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = NewScholarshipResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniec(ReniecSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/PostValidarReniecv2', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecResponseModel2.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniecIsMinor(ReniecSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Contenido/postValidarReniecContenido', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecMinorResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniecIsMinorTutor(ReniecSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Contenido/postValidarReniecContenido', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecMinorResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchForeignSearch(ForeignSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/postValidarExtranjeros', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ForeignResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> responseMixtProcess(ForeignProcessSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Comun/postProcesarRespuestasMixto', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ForeignProcessResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniecFirma(ReniecSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/PostValidarReniecRevisaFirma', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecReviewSignResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> downloadReport(SendReportModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/reportes/api/reporte', data: jsonEncode(send.toJson()));
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReportResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> downloadFile(DownloadFileSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/postDescargarPdf',data: send.toJson());
      //cambiamos la url al que corresponde
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = FileResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> sendEmailRegister(EmailSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/postEnviarCorreo', data: jsonEncode(send.toJson()));
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = EmailResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> sendEmailSearchMod(EmailSendSearchModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Comun/postEnviarCorreoFiltros', data: jsonEncode(send.toJson()));
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = EmailResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniecPerformance(ReniecSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/comun/postValidarReniecRendimientoAcademico', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecPerformanceResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> searchUserReniecPrepareExam(ReniecPrepareSendModel send) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.post('/pronabecapp/Preparate/postValidarReniecPreparate', data: send.toJson());
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = ReniecPrepareExamResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> getDataInitPrepareExam() async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.get('/pronabecapp/Preparate/getpreparateApp');
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = PrepareExamInitDataResponseModel2.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

   Future<APIResponseModel> getDataInitPrepareExam2() async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.get('/pronabecapp/Preparate/getpreparateApp2');
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = PrepareExamInitDataResponseModel3.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> downloadFileSolution(int courseCode) async {
    var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await dio.get('/pronabecapp/Preparate/getDescargarSimulacroPdf/$courseCode/2');
      //cambiamos la url al que corresponde
      res = await UtilCommon.parseApiResponse(response);
      if (res.status) {
        res.data = FileResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }

  Future<APIResponseModel> syncHistory(HistorySyncSendModel send, String token) async {
  var res = APIResponseModel(false, 999, getErrorInit(), '');
    try {
      final response = await http.post(
        Uri.parse('${InitFlavorConfig.urlApp}/pronabecapp/Comun/postSincronizarOffline'),
        headers: <String, String>{
          'Authorization': 'bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode([send.toJson()]),
      );

      if (response.statusCode == 200) {
          res.data = HistorySyncResponseModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // Manejar el error de solicitud HTTP
        res = APIResponseModel(false, response.statusCode, ErrorResponseModel.fromJson(response.body as Map<String, dynamic>), 'Error en la sincronizacion');
      }
    } catch (e) {
      res = await UtilCommon.handleAppException(e);
    }

    return res;
  }
}
