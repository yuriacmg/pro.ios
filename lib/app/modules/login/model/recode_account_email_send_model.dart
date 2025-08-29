
// ignore_for_file: sort_constructors_first

class RecodeAccountEmailSendModel {
  String? vCorreo;
  String? uiDTransacion;

  RecodeAccountEmailSendModel({this.vCorreo, this.uiDTransacion});

  RecodeAccountEmailSendModel.fromJson(Map<String, dynamic> json) {
    vCorreo = json['v_Correo'] as String;
    uiDTransacion = json['uiD_Transacion'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Correo'] = vCorreo;
    data['uiD_Transacion'] = uiDTransacion;
    return data;
  }
}
