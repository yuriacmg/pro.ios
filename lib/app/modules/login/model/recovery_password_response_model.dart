// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class RecoveryPasswordResponseModel {
  Value? value;
  bool? hasSucceeded;

  RecoveryPasswordResponseModel({this.value, this.hasSucceeded});

  RecoveryPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null
        ? Value.fromJson(json['value'] as Map<String, dynamic>)
        : null;
    hasSucceeded = json['hasSucceeded'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['hasSucceeded'] = hasSucceeded;
    return data;
  }
}

class Value {
  String? vNroDocumento;
  String? vCorreo;
  int? iRegistroId;
  bool? bEnvioCorreo;
  String? vToken;

  Value({
    this.vNroDocumento,
    this.vCorreo,
    this.iRegistroId,
    this.bEnvioCorreo,
    this.vToken,
  });

  Value.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_nro_documento'] as String;
    vCorreo = json['v_correo'] as String;
    iRegistroId = json['i_registroId'] as int;
    bEnvioCorreo = json['b_envio_correo'] as bool;
    vToken = json['v_Token'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_nro_documento'] = vNroDocumento;
    data['v_correo'] = vCorreo;
    data['i_registroId'] = iRegistroId;
    data['b_envio_correo'] = bEnvioCorreo;
    data['v_Token'] = vToken;
    return data;
  }
}
