// ignore_for_file: inference_failure_on_function_invocation,directives_ordering, cascade_invocations, avoid_dynamic_calls, lines_longer_than_80_chars, strict_raw_type, inference_failure_on_function_return_type
// eol_at_end_of_file,
// directives_ordering

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/widgets/alert_confirm.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/common/widgets/no_internet_widget.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class UtilCommon {
  static void openConfirmDialog(
    BuildContext context,
    String message,
    Function yesOnPressed,
    Function noOnPressed,
  ) {
    final confirmDialog = AppConfirmDialog(
      title: message,
      yesOnPressed: yesOnPressed,
      noOnPressed: noOnPressed,
      yes: 'Aceptar',
      no: 'Cancelar',
    );
    showDialog(
      barrierColor: Colors.black45,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => confirmDialog,
    );
  }

  Future<APIResponseModel> handleResponse(Response response, dynamic model) async {
    final apiResponse = APIResponseModel(false, 999, getErrorInit(), '');

    apiResponse.statusCode = response.statusCode ?? 0;

    if (response.statusCode == 200 && response.data['hasSucceeded'].toString() == 'true') {
      apiResponse.status = true;
      apiResponse.data = model.fromJson(response.data as Map<String, dynamic>);
    } else {
      apiResponse.data = ErrorResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    }

    return apiResponse;
  }

  void noInternetNoDataModal({required BuildContext context, VoidCallback? ontap, bool? visibleMessage}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoInternetWidget(ontap: ontap, visibleMessage: visibleMessage);
      },
    );
  }

  void erroServerModal({required BuildContext context, VoidCallback? ontap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorRequestServerWidget(ontap: ontap);
      },
    );
  }

static  Future<APIResponseModel> parseApiResponse(Response response) async {
    final res = APIResponseModel(false, 999, getErrorInit(), '');

    if (response.statusCode == 200 && response.data['hasSucceeded'].toString() == 'true') {
      res
        ..status = true
        ..statusCode = int.parse(response.statusCode!.toString())
        ..data = response.data;
    } else {
      res
        ..status = false
        ..statusCode = int.parse(response.statusCode!.toString())
        ..data = ErrorResponseModel.fromJson(response.data as Map<String, dynamic>);
    }

    return res;
  }

  static Future<APIResponseModel> handleAppException(dynamic e) async {
    final res = APIResponseModel(false, 999, getErrorInit(), '');

    if (e is DioException) {
      if (e.error is SocketException) {
        res
          ..status = false
          ..statusCode = 950 // código cuando no hay internet
          ..data = getErrorInternet();
      } else if (e.response != null) {
        
          if(e.response!.data != null){
              res
              ..status = false
              ..statusCode = int.parse(e.response!.statusCode!.toString())
              ..data = ErrorResponseModel.fromJson(e.response!.data as Map<String, dynamic>);
          }else{
              res
              ..status = false
              ..statusCode = int.parse(e.response!.statusCode.toString())
              ..data = getErrorInit();
          }
      }
    }

    return res;
  }


  void showErrorDialogCommon(BuildContext context, String title, String message, {Function()? onTap}) {
  final alert = AlertImageMessageGenericWidget(
    title: title,
    message: message,
    consultaId: 0,
    onTap: onTap ?? () {
      Navigator.pop(context);
    },
    bottonTitle: 'Entendido',
    image: 'assets/alert_app.svg',
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void handleErrorResponse(BuildContext context, ErrorResponseModel error, String? title) {
  if (error.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
    // No hay internet
    UtilCommon().noInternetNoDataModal(
      context: context,
      ontap: () {
        Navigator.pop(context);
      },
    );
  } else if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) && error.statusCode! < 900) {
    // Error del servidor
    UtilCommon().erroServerModal(context: context);
  } else {
    // Otro tipo de error
    var messages = '';
    for (final e in error.value) {
      messages = (messages.isEmpty ? e.message : '$messages\n${e.message}');
    }
    showErrorDialogCommon(context, title ?? 'NO PUDIMOS VALIDAR TU IDENTIDAD', messages);
  }
}
}
