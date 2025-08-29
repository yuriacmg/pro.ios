// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class ForeignSendModel {
  String? vNroDocumento;
  String? vPais;
  String? vTipoDocumento;
  String? vNombres;
  String? vApellidoPaterno;
  String? vApellidoMaterno;
  bool? bTerminosCondiciones;
  bool? bDeclaracionInformacion;
  String? numCelular;

  ForeignSendModel({
    this.vNroDocumento,
    this.vPais,
    this.vTipoDocumento,
    this.vApellidoPaterno,
    this.vApellidoMaterno,
    this.bTerminosCondiciones,
    this.bDeclaracionInformacion,
    this.numCelular,
  });

  ForeignSendModel.fromJson(Map<String, dynamic> json) {
    vNroDocumento = json['v_Nro_Documento'].toString();
    vPais = json['v_Pais'].toString();
    vTipoDocumento = json['v_Tipo_Documento'].toString();
    vNombres = json['v_Nombres'].toString();
    vApellidoPaterno = json['V_Ape_Paterno'].toString();
    vApellidoMaterno = json['V_Ape_Paterno'].toString();
    numCelular = json['numCelular'].toString();
    bTerminosCondiciones = json['b_Terminos_Condiciones'].toString() == 'true';
    bDeclaracionInformacion = json['b_Declaracion_Informacion'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['v_Nro_Documento'] = vNroDocumento;
    data['v_Pais'] = vPais;
    data['v_Tipo_Documento'] = vTipoDocumento;
    data['v_Nombres'] = vNombres;
    data['V_Ape_Paterno'] = vApellidoPaterno;
    data['V_Ape_Materno'] = vApellidoMaterno;
    data['V_Nro_Celular'] = numCelular;
    data['b_Terminos_Condiciones'] = bTerminosCondiciones;
    data['b_Declaracion_Informacion'] = bDeclaracionInformacion;
    return data..removeWhere((key, value) => (value == null || value == ''));
  }
}
