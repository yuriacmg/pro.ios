// ignore_for_file: inference_failure_on_function_invocation, prefer_single_quotes, lines_longer_than_80_chars, inference_failure_on_function_return_type, avoid_positional_boolean_parameters, unnecessary_raw_strings

import 'dart:convert';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/widgets/alert_confirm.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1),
    });
  }
}

Future<void> registerPageAnalytics(String screenName) async {
  if (screenName != "" && screenName != "/" && screenName != "/NavigationPage") {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: "${screenName}PageApp");
  }
}

void openConfirmDialog(
  BuildContext context,
  String message,
  Function yesOnPressed,
  Function noOnPressed,
) {
  final confirmDialog = AppConfirmDialog(
    title: message,
    yesOnPressed: () {
      Navigator.pop(context);
    },
    noOnPressed: () {
      Navigator.pop(context);
    },
    yes: 'Aceptar',
    no: 'Cancelar',
  );
  showDialog(
    barrierColor: Colors.black26,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => confirmDialog,
  );
}

String geUrl(String social, String number) {
  if (social == 'Whatsapp') {
    return geUrlWhatsapp(number);
  } else {
    return getUrlFacebook();
  }
}

String geUrlWhatsapp(String value) {
  final number = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (kIsWeb) {
    return 'https://wa.me/$number';
  } else {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/+$number/?text=${Uri.encodeFull(ConstantsApp.messageWhatsapp)}";
    } else {
      return "whatsapp://send?phone=+$number&text=${Uri.encodeFull(ConstantsApp.messageWhatsapp)}";
    }
  }
}

String getUrlFacebook() {
  if (kIsWeb) {
    return 'https://www.facebook.com/PRONABEC';
  } else {
    if (Platform.isIOS) {
      return "fb://profile/PRONABEC/";
    } else {
      return "fb://page/${ConstantsApp.pageIdPronabec}/";
    }
  }
}

bool isValidEmail(String email) {
  const pattern = r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

ErrorResponseModel getErrorInit() {
  final value = ValueError(errorCode: 999, message: 'Error al realizar la petición');
  final error = ErrorResponseModel(hasSucceeded: false, value: [value], statusCode: 1);

  return error;
}

ErrorResponseModel getErrorInternet() {
  final value = ValueError(errorCode: 950, message: 'No Cuenta con servicio de Internet');
  final error = ErrorResponseModel(hasSucceeded: false, value: [value], statusCode: 1);

  return error;
}

Future<String> createPdfLocal(int courseCode, String areaName) async {
  final data = await rootBundle.load('assets/preparate_imagenes/solucionario/$courseCode.pdf');
  final uint8List = data.buffer.asUint8List();

  // Obten la ruta del directorio de documentos temporales
  final tempDir = await getTemporaryDirectory();
  final tempDocumentPath = tempDir.path;

  // Crea un archivo temporal y escribe los datos del PDF en él
  final file = File('$tempDocumentPath/solucionario_$areaName.pdf'); // Elige un nombre y ubicación para el archivo temporal
  await file.writeAsBytes(uint8List);

  return file.path;
}

Future<String> createPdf(String base64, String filename) async {
  final bytes = base64Decode(base64);
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/$filename');
  await file.writeAsBytes(bytes.buffer.asUint8List());
  return file.path;
}

Future<void> downloadFileWeb(String sbase64, String fileName) async {
  final bytes = base64.decode(sbase64);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();

  // Liberar la URL del blob
  html.Url.revokeObjectUrl(url);
}

int getAppStatusCodeError(AppStatusCode statusCode) {
  switch (statusCode) {
    case AppStatusCode.NOINTERNET:
      return 950;
    case AppStatusCode.VALIDATION:
      return 400;
    case AppStatusCode.SERVER:
      return 500;
    case AppStatusCode.NOUSER:
      return 707;
  }
}

Widget getStatus(int status) {
  final statusData = {
    ConstantsApp.areaInitial: {
      'text': 'Por Iniciar',
      'color': const Color.fromRGBO(235, 143, 16, 0.1),
      'textColor': const Color(0xffEB8F10),
    },
    ConstantsApp.areaProcess: {
      'text': 'En proceso',
      'color': const Color.fromRGBO(231, 29, 115, 0.1),
      'textColor': const Color(0xffE71D73),
    },
    ConstantsApp.areaCompleted: {
      'text': 'Completado',
      'color': const Color.fromRGBO(49, 143, 61, 0.1),
      'textColor': const Color(0xff318F3D),
    },
  };

  final data = statusData[status] ?? statusData[ConstantsApp.areaInitial];

  return Card(
    elevation: 3,
    shadowColor: Colors.grey.withOpacity(0.5),
    child: Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: data!['color']! as Color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        data['text']! as String,
        style: TextStyle(
          color: data['textColor']! as Color,
          fontSize: 10,
          fontFamily: ConstantsApp.OPSemiBold,
        ),
      ),
    ),
  );
}

Future<void> launchUrlAPP(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $uri');
  }
}

String removeLastCharacterIfCharacter(String texto, String character) {
  if (texto.isNotEmpty && texto.endsWith(character)) {
    return texto.substring(0, texto.length - 1);
  } else {
    return texto;
  }
}

//metodos para la pagina de preparate
Color getBorderColor(bool isSelected, bool isCorrect, bool noSelected) {
  return isSelected && noSelected
      ? const Color(0xFFF59D24)
      : isSelected && isCorrect
          ? const Color(0xFF0A921A)
          : isSelected && !isCorrect
              ? const Color(0xffFF5A6A)
              : isCorrect
                  ? const Color(0xff0A921A)
                  : const Color(0xffD8E5F1);
}

Color getBackgroundColor(bool isSelected, bool isCorrect, bool noSelected) {
  return isSelected && noSelected
      ? const Color(0xFFFFF5E3)
      : isSelected && isCorrect
          ? const Color(0xFFE2F5E3)
          : (isSelected && !isCorrect)
              ? const Color(0xffFEE7E9)
              : isCorrect
                  ? const Color(0xffE2F5E3)
                  : const Color(0xffffffff);
}

Color getChecKBorderSelectedColor(bool isSelected, bool isCorrect, bool noSelected) {
  return isSelected && noSelected
      ? const Color(0xFFF59D24)
      : isSelected && isCorrect
          ? const Color(0xffF7F8FC)
          : (isSelected && !isCorrect)
              ? const Color(0xffF7F8FC)
              : isCorrect
                  ? const Color(0xffF7F8FC)
                  : const Color(0xffF7F8FC);
}

Color getChecKBorderColor(bool isSelected, bool isCorrect, bool exist, bool noSelected) {
  return exist
      ? isSelected && noSelected
          ? Colors.transparent
          : isSelected && isCorrect
              ? const Color(0xff0B941C)
              : (isSelected && !isCorrect)
                  ? const Color(0xffFF5A6A)
                  : isCorrect
                      ? const Color(0xff14B045)
                      : const Color(0xffB2C8DE)
      : const Color(0xffB2C8DE);
}

Color getCheckBackgroundColor(bool isSelected, bool isCorrect, bool noSelected) {
  return isSelected && noSelected
      ? Colors.transparent
      : isSelected && isCorrect
          ? const Color(0xff0B941C)
          : (isSelected && !isCorrect)
              ? const Color(0xffFF5A6A)
              : isCorrect
                  ? const Color(0xffF7F8FC)
                  : const Color(0xffF7F8FC);
}

Color getTextColor(bool isSelected, bool isCorrect, bool exist) {
  return exist
      ? isSelected && isCorrect
          ? ConstantsApp.textBlackQuaternary
          : (isSelected && !isCorrect)
              ? ConstantsApp.textBlackQuaternary
              : isCorrect
                  ? ConstantsApp.textBlackQuaternary
                  : ConstantsApp.textBlackQuaternary
      : ConstantsApp.textBlackQuaternary;
}

Widget getIcon(bool isSelected, bool isCorrect, bool noSelected) {
  return isSelected && noSelected
      ? const SizedBox.shrink()
      : isSelected && isCorrect
          ? Center(child: Image.asset('assets/scholarship/correct.png', scale: 1.9))
          : (isSelected && !isCorrect)
              ? Center(child: Image.asset('assets/scholarship/error.png', scale: 1.9))
              : isCorrect
                  ? const SizedBox.shrink()
                  : const SizedBox.shrink();
}

String hiddenCorreo(String correo) {
  if (correo.length > 3) {
    final primerosTres = correo.substring(0, 3);
    final dominio = correo.split('@')[1];
    final asteriscos = 'x' * (dominio.length - 3);
    return '$primerosTres$asteriscos@$dominio';
  }
  return correo; // En caso de que el correo sea muy corto
}
