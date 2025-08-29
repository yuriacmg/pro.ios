
// ignore_for_file: sort_constructors_first

class ValidCodeEmailSendModel {
  String? vCodigo;
  String? vCorreo;
  String? uiDTransacion;

  ValidCodeEmailSendModel({this.vCodigo, this.vCorreo, this.uiDTransacion});

  ValidCodeEmailSendModel.fromJson(Map<String, dynamic> json) {
    vCodigo = json['v_Codigo'] as String;
    vCorreo = json['v_Correo'] as String;
    uiDTransacion = json['uiD_Transacion'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Codigo'] = vCodigo;
    data['v_Correo'] = vCorreo;
    data['uiD_Transacion'] = uiDTransacion;
    return data;
  }
}
