// ignore_for_file: sort_constructors_first, avoid_unused_constructor_parameters, lines_longer_than_80_chars

class ReniecSendModel {
  String? vNroDocumento;
  String? dFechaNacimiento;
  String? vUbigeo;
  String? vCodigoVerificacion;
  bool? bTerminosCondiciones;
  bool? bDeclaracionInformacion;
  String? vNroCelular;
  String? vNombres; 
  String? vApellidoPaterno; 
  String? vApellidoMaterno; 

  ReniecSendModel({
    this.vNroDocumento,
    this.dFechaNacimiento,
    this.vUbigeo,
    this.vCodigoVerificacion,
    this.bTerminosCondiciones,
    this.bDeclaracionInformacion,
    this.vNroCelular,
    this.vNombres,  
    this.vApellidoPaterno, 
    this.vApellidoMaterno, 
  });

  ReniecSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'].toString();
    vNombres = json['v_Nombres'].toString();
    vApellidoPaterno = json['v_Apellido_Paterno'].toString();
    vApellidoMaterno = json['v_Apellido_Materno'].toString();
    dFechaNacimiento = json['d_Fecha_Nacimiento'].toString();
    vUbigeo = json['v_Ubigeo'].toString();
    vCodigoVerificacion = json['v_Digito_Verificador'].toString();
    vNroCelular = json['v_Nro_Celular'].toString();
    bTerminosCondiciones = json['b_Terminos_Condiciones'].toString() == 'true';
    bDeclaracionInformacion = json['b_Declaracion_Informacion'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['v_Nombres'] = vNombres;
    data['v_Apellido_Paterno'] = vApellidoPaterno;
    data['v_Apellido_Materno'] = vApellidoMaterno;
    data['d_Fecha_Nacimiento'] = dFechaNacimiento;
    data['v_Ubigeo'] = vUbigeo;
    data['v_Digito_Verificador'] = vCodigoVerificacion;
    data['v_Nro_Celular'] = vNroCelular;
    data['b_Terminos_Condiciones'] = bTerminosCondiciones;
    data['b_Declaracion_Informacion'] = bDeclaracionInformacion;
    return data;
  }
}

class ReniecPrepareSendModel {
  String? vNroDocumento;
  String? dFechaNacimiento;
  String? vUbigeo;
  String? vCodigoVerificacion;
  bool? bTerminosCondiciones;
  bool? bDeclaracionInformacion;
  String? vNombres;
  String? vApellidoPaterno;
  String? vApellidoMaterno;

  ReniecPrepareSendModel({
    vNroDocumento,
    dFechaNacimiento,
    vUbigeo,
    vCodigoVerificacion,
    bTerminosCondiciones,
    bDeclaracionInformacion,
    vNombres,
    vApellidoPaterno,
    vApellidoMaterno,
  });

  ReniecPrepareSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'].toString();
    vNombres = json['v_Nombres'].toString();
    vApellidoPaterno = json['v_Apellido_Paterno'].toString();
    vApellidoMaterno = json['v_Apellido_Materno'].toString();
    dFechaNacimiento = json['d_Fecha_Nacimiento'].toString();
    vUbigeo = json['v_Ubigeo'].toString();
    vCodigoVerificacion = json['v_Digito_Verificador'].toString();
    bTerminosCondiciones = json['b_Terminos_Condiciones'].toString() == 'true';
    bDeclaracionInformacion = json['b_Declaracion_Informacion'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['v_Nombres'] = vNombres;
    data['v_Apellido_Paterno'] = vApellidoPaterno;
    data['v_Apellido_Materno'] = vApellidoMaterno;
    data['d_Fecha_Nacimiento'] = dFechaNacimiento;
    data['v_Ubigeo'] = vUbigeo;
    data['v_Digito_Verificador'] = vCodigoVerificacion;
    data['b_Terminos_Condiciones'] = bTerminosCondiciones;
    data['b_Declaracion_Informacion'] = bDeclaracionInformacion;
    return data;
  }
}
