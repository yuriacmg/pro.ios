// ignore_for_file: sort_constructors_first

class ValidAccountSendModel {
  String? vNroDocumento;
  String? vCodigo;
  String? vCorreo;
  String? uiDTransacion;

  ValidAccountSendModel({
    this.vNroDocumento,
    this.vCodigo,
    this.vCorreo,
    this.uiDTransacion,
  });

  ValidAccountSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'] as String;
    vCodigo = json['v_Codigo'] as String;
    vCorreo = json['v_Correo'] as String;
    uiDTransacion = json['uiD_Transacion'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['v_Codigo'] = vCodigo;
    data['v_Correo'] = vCorreo;
    data['uiD_Transacion'] = uiDTransacion;
    return data;
  }
}
