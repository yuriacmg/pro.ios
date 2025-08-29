// ignore_for_file: sort_constructors_first

class PasswordProfileUpdateSendModel {
  int? iRegistroId;
  String? vPrefijo;
  String? vTelefono;
  String? vContrasenia;
  int? iAccion;
  String? vToken;

  PasswordProfileUpdateSendModel({
    this.iRegistroId,
    this.vPrefijo,
    this.vTelefono,
    this.vContrasenia,
    this.iAccion,
    this.vToken,
  });

  PasswordProfileUpdateSendModel.fromJson(Map<String, dynamic> json) {
    iRegistroId = json['i_RegistroId'] as int;
    vPrefijo = json['v_Prefijo'] as String;
    vTelefono = json['v_Telefono'] as String;
    vContrasenia = json['v_Contrasenia'] as String;
    iAccion = json['i_accion'] as int;
    vToken = json['v_token'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_RegistroId'] = iRegistroId;
    data['v_Prefijo'] = vPrefijo;
    data['v_Telefono'] = vTelefono;
    data['v_Contrasenia'] = vContrasenia;
    data['i_accion'] = iAccion;
    data['v_token'] = vToken;
    return data;
  }
}
