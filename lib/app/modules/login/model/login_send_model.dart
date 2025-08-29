// ignore_for_file: sort_constructors_first

class LoginSendModel {
  String? vCorreo;
  String? vContrasenia;

  LoginSendModel({this.vCorreo, this.vContrasenia});

  LoginSendModel.fromJson(Map<String, dynamic> json) {
    vCorreo = json['v_Correo'] as String;
    vContrasenia = json['v_Contrasenia'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Correo'] = vCorreo;
    data['v_Contrasenia'] = vContrasenia;
    return data;
  }
}
