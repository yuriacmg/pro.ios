// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class RegisterAccountResponseModel {
  Value? value;
  bool? hasSucceeded;

  RegisterAccountResponseModel({this.value, this.hasSucceeded});

  RegisterAccountResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ?  Value.fromJson(json['value'] as Map<String, dynamic>) : null;
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
  int? iRegistroId;
  bool? bEnvioCorreo;

  Value({this.iRegistroId, this.bEnvioCorreo});

  Value.fromJson(Map<String, dynamic> json) {
    iRegistroId = json['i_registroId'] as int;
    bEnvioCorreo = json['b_envio_correo'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_registroId'] = iRegistroId;
    data['b_envio_correo'] = bEnvioCorreo;
    return data;
  }
}
