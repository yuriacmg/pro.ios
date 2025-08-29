// ignore_for_file: sort_constructors_first

class EmailSendModel {
  String? nroDocumento;
  String? correo;
  int? nroConsultaCiudadana;

  EmailSendModel({this.nroDocumento, this.correo, this.nroConsultaCiudadana});

  EmailSendModel.fromJson(Map<String, dynamic> json) {
    nroDocumento = json['nroDocumento'].toString();
    correo = json['correo'].toString();
    nroConsultaCiudadana = int.parse(json['correo'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nroDocumento'] = nroDocumento;
    data['correo'] = correo;
    data['nroConsultaCiudadana'] = nroConsultaCiudadana;

    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
