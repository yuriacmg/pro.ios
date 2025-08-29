// ignore_for_file: sort_constructors_first

class DownloadFileSendModel {
  int? id;
  String? nroDocumento;
  int? nroConsultaCiudadana;

  DownloadFileSendModel({
    this.id,
    this.nroDocumento,
    this.nroConsultaCiudadana,
  });

  DownloadFileSendModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    nroDocumento = json['nroDocumento'] as String?;
    nroConsultaCiudadana = json['nroConsultaCiudadana'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nroDocumento'] = nroDocumento;
    data['nroConsultaCiudadana'] = nroConsultaCiudadana;

    data.removeWhere((key, value) => value == null || value == '');

    return data;
  }
}
