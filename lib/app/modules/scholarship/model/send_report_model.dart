// ignore_for_file: sort_constructors_first

class SendReportModel {
  BodyData? data;
  String? rutaPlantilla;
  String? nombrePlantilla;

  SendReportModel({this.data, this.rutaPlantilla, this.nombrePlantilla});

  SendReportModel.fromJson(Map<String, dynamic> json) {
    data = BodyData.fromJson(json['data'] as Map<String, dynamic>);
    rutaPlantilla = json['rutaPlantilla'].toString();
    nombrePlantilla = json['nombrePlantilla'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    data['rutaPlantilla'] = rutaPlantilla;
    data['nombrePlantilla'] = nombrePlantilla;
    return data;
  }
}

class BodyData {
  String? nombreConcurso;
  String? fechaPostulacion;
  String? nombreModalidad;
  String? numDocumento;
  String? nombreCompleto;

  BodyData({
    this.nombreConcurso,
    this.fechaPostulacion,
    this.nombreModalidad,
    this.numDocumento,
    this.nombreCompleto,
  });

  BodyData.fromJson(Map<String, dynamic> json) {
    nombreConcurso = json['nombreConcurso'].toString();
    fechaPostulacion = json['fechaPostulacion'].toString();
    nombreModalidad = json['nombreModalidad'].toString();
    numDocumento = json['numDocumento'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombreConcurso'] = nombreConcurso;
    data['fechaPostulacion'] = fechaPostulacion;
    data['nombreModalidad'] = nombreModalidad;
    data['numDocumento'] = numDocumento;
    data['nombreCompleto'] = nombreCompleto;
    return data;
  }
}
