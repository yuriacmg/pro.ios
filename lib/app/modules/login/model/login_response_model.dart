// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first

class LoginResponseModel {
  Value? value;
  bool? hasSucceeded;

  LoginResponseModel({this.value, this.hasSucceeded});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? iRegistroId;
  String? vNroDocumento;
  String? vEmail;
  String? vNombres;
  String? vApellidos;
  String? vFechaNacimiento;
  String? vUbigeo;
  String? vDigitoVerificador;
  String? vCelular;
  String? vPrefijo;
  String? vToken;

  Value({
    this.iRegistroId,
    this.vNroDocumento,
    this.vEmail,
    this.vNombres,
    this.vApellidos,
    this.vFechaNacimiento,
    this.vUbigeo,
    this.vDigitoVerificador,
    this.vCelular,
    this.vPrefijo,
    this.vToken,
  });

  Value.fromJson(Map<String, dynamic> json) {
    iRegistroId = json['i_registroId'] as int;
    vNroDocumento = json['v_nro_documento'] as String;
    vEmail = json['v_email'] as String;
    vNombres = json['v_nombres'] as String;
    vApellidos = json['v_apellidos'] as String;
    vFechaNacimiento = json['v_fecha_nacimiento'] as String;
    vUbigeo = json['v_ubigeo'] as String;
    vDigitoVerificador = json['v_digito_verificador'] as String;
    vCelular = json['v_celular'] == null ? '' : json['v_celular'] as String;
    vPrefijo = json['v_prefijo'] ==  null ? '' : json['v_prefijo'] as String;
    vToken = json['v_token'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_registroId'] = iRegistroId;
    data['v_nro_documento'] = vNroDocumento;
    data['v_email'] = vEmail;
    data['v_nombres'] = vNombres;
    data['v_apellidos'] = vApellidos;
    data['v_fecha_nacimiento'] = vFechaNacimiento;
    data['v_ubigeo'] = vUbigeo;
    data['v_digito_verificador'] = vDigitoVerificador;
    data['v_celular'] = vCelular;
    data['v_prefijo'] = vPrefijo;
    data['v_token'] = vToken;
    return data;
  }
}
