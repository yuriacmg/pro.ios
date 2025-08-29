// ignore_for_file: sort_constructors_first

class RecoveryPasswordSendModel {
  String? vNroDocumento;
  String? uiDTransacion;

  RecoveryPasswordSendModel({
    this.vNroDocumento,
    this.uiDTransacion,
  });

  RecoveryPasswordSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'] as String;
    uiDTransacion = json['uiD_Transacion'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['uiD_Transacion'] = uiDTransacion;
    return data;
  }
}
