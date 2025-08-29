// ignore_for_file: sort_constructors_first

class RegisterAccountSendModel {
  String? vNroDocumento;
  String? dFechaNacimiento;
  String? vUbigeo;
  String? vDigitoVerificador;
  String? vCorreo;
  String? vContrasenia;
  String? uiDTransacion;
  bool? bTerminosCondiciones;
  bool? bDeclaracionInformacion;

  RegisterAccountSendModel(
      {this.vNroDocumento,
      this.dFechaNacimiento,
      this.vUbigeo,
      this.vDigitoVerificador,
      this.vCorreo,
      this.vContrasenia,
      this.uiDTransacion,
      this.bTerminosCondiciones,
      this.bDeclaracionInformacion,
      });

  RegisterAccountSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'] as String;
    dFechaNacimiento = json['d_Fecha_Nacimiento'] as String;
    vUbigeo = json['v_Ubigeo'] as String;
    vDigitoVerificador = json['v_Digito_Verificador'] as String;
    vCorreo = json['v_Correo'] as String;
    vContrasenia = json['v_Contrasenia'] as String;
    uiDTransacion = json['uiD_Transacion'] as String;
    bTerminosCondiciones = json['b_Terminos_Condiciones'] as bool;
    bDeclaracionInformacion = json['b_Declaracion_Informacion'] as bool;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['d_Fecha_Nacimiento'] = dFechaNacimiento;
    data['v_Ubigeo'] = vUbigeo;
    data['v_Digito_Verificador'] = vDigitoVerificador;
    data['v_Correo'] = vCorreo;
    data['v_Contrasenia'] = vContrasenia;
    data['uiD_Transacion'] = uiDTransacion;
    data['b_Terminos_Condiciones'] = bTerminosCondiciones;
    data['b_Declaracion_Informacion'] = bDeclaracionInformacion;
    return data;
  }
}
