// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, inference_failure_on_collection_literal, lines_longer_than_80_chars

class ForeignProcessSendModel {
  String? nroDocumento;
  bool? extranjero;
  String? pais;
  String? nombres;
  String? apePaterno;
  String? apeMaterno;
  String? nroCelular;
  List<RespuestaProcesada>? respuestas;
  bool? bTerminosCondiciones;
  bool? bDeclaracionInformacion;
  String? dFechaNacimiento;
  String? vUbigeo;
  String? vCodigoVerificacion;
  ForeignProcessSendModel({
    this.nroDocumento,
    this.extranjero,
    this.pais,
    this.nombres,
    this.apePaterno,
    this.apeMaterno,
    this.nroCelular,
    this.respuestas,
    this.bDeclaracionInformacion,
    this.bTerminosCondiciones,
    this.dFechaNacimiento,
    this.vUbigeo,
    this.vCodigoVerificacion,
  });

  ForeignProcessSendModel.fromJson(Map<String, dynamic> json) {
    nroDocumento = json['nroDocumento'].toString();
    extranjero = json['extranjero'].toString() == 'true';
    pais = json['pais'].toString();
    nombres = json['nombres'].toString();
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nroCelular = json['nroCelular'].toString();
    bTerminosCondiciones = json['b_Terminos_Condiciones'] as bool;
    bDeclaracionInformacion = json['b_Declaracion_Informacion'] as bool;
    vCodigoVerificacion = json['digitoVerificador'] as String?;
    vUbigeo = json['ubigeoNacimiento'] as String?;
    dFechaNacimiento = json['fecNacimiento'] as String?;
    json['respuestas'] = [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nroDocumento'] = nroDocumento;
    data['extranjero'] = extranjero;
    data['pais'] = pais;
    data['nombres'] = nombres;
    data['apePaterno'] = apePaterno;
    data['apeMaterno'] = apeMaterno;
    data['nroCelular'] = nroCelular;
    data['b_Terminos_Condiciones'] = bTerminosCondiciones;
    data['b_Declaracion_Informacion'] = bDeclaracionInformacion;
    data['digitoVerificador'] = vCodigoVerificacion;
    data['ubigeoNacimiento'] = vUbigeo;
    data['fecNacimiento'] = dFechaNacimiento;
    if (respuestas != null) {
      data['respuestas'] = respuestas!.map((v) => v.toJson()).toList();
    }
    return data..removeWhere((key, value) => (value == null || value == ''));
  }
}

class RespuestaProcesada {
  int? idPregunta;
  int? valorRespuesta;

  RespuestaProcesada({this.idPregunta, this.valorRespuesta});

  RespuestaProcesada.fromJson(Map<String, dynamic> json) {
    idPregunta = int.parse(json['idPregunta'].toString());
    valorRespuesta = int.parse(json['valorRespuesta'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idPregunta'] = idPregunta;
    data['valorRespuesta'] = valorRespuesta;
    return data;
  }
}
