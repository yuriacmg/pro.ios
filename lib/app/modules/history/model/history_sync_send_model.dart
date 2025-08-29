// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars

class HistorySyncSendModel {
  int? consultaIdTemporal;
  String? nroDocumento;
  String? nombres;
  String? apePaterno;
  String? apeMaterno;
  String? nroCelular;
  String? correo;
  String? fechaNacimiento;
  String? ubigeo;
  String? digitoVerificador;
  bool? terminosCondiciones;
  bool? declaracionInformacion;
  String? fechaRegistro;
  String? usuarioRegistro;
  List<FichaTecnicaSync>? fichaTecnica;

  HistorySyncSendModel(
      {this.consultaIdTemporal,
      this.nroDocumento,
      this.nombres,
      this.apePaterno,
      this.apeMaterno,
      this.nroCelular,
      this.correo,
      this.fechaNacimiento,
      this.ubigeo,
      this.digitoVerificador,
      this.terminosCondiciones,
      this.declaracionInformacion,
      this.fechaRegistro,
      this.usuarioRegistro,
      this.fichaTecnica,});

  HistorySyncSendModel.fromJson(Map<String, dynamic> json) {
    consultaIdTemporal = json['consultaIdTemporal'] as int;
    nroDocumento = json['nroDocumento'] as String;
    nombres = json['nombres'] as String;
    apePaterno = json['apePaterno'] as String;
    apeMaterno = json['apeMaterno'] as String;
    nroCelular = json['nroCelular'] as String;
    correo = json['correo'] as String;
    fechaNacimiento = json['fechaNacimiento'] as String;
    ubigeo = json['ubigeo'] as String;
    digitoVerificador = json['digitoVerificador'] as String;
    terminosCondiciones = json['terminosCondiciones'] as bool;
    declaracionInformacion = json['declaracionInformacion'] as bool;
    fechaRegistro = json['fechaRegistro'] as String;
    usuarioRegistro = json['usuarioRegistro'] as String;
    if (json['fichaTecnica'] != null) {
      fichaTecnica = <FichaTecnicaSync>[];
      json['fichaTecnica'].forEach((v) {
        fichaTecnica!.add(FichaTecnicaSync.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['consultaIdTemporal'] = consultaIdTemporal;
    data['nroDocumento'] = nroDocumento;
    data['nombres'] = nombres;
    data['apePaterno'] = apePaterno;
    data['apeMaterno'] = apeMaterno;
    data['nroCelular'] = nroCelular;
    data['correo'] = correo;
    data['fechaNacimiento'] = fechaNacimiento;
    data['ubigeo'] = ubigeo;
    data['digitoVerificador'] = digitoVerificador;
    data['terminosCondiciones'] = terminosCondiciones;
    data['declaracionInformacion'] = declaracionInformacion;
    data['fechaRegistro'] = fechaRegistro;
    data['usuarioRegistro'] = usuarioRegistro;
    if (fichaTecnica != null) {
      data['fichaTecnica'] = fichaTecnica!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FichaTecnicaSync {
  int? idModalidad;
  List<DetalleSync>? detalle;

  FichaTecnicaSync({this.idModalidad, this.detalle});

  FichaTecnicaSync.fromJson(Map<String, dynamic> json) {
    idModalidad = json['idModalidad'] as int;
    if (json['detalle'] != null) {
      detalle = <DetalleSync>[];
      json['detalle'].forEach((v) {
        detalle!.add(DetalleSync.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idModalidad'] = idModalidad;
    if (detalle != null) {
      data['detalle'] = detalle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetalleSync {
  String? tipo;
  String? nombre;
  List<String>? parametro;
  String? operador;
  String? valorRespuesta;

  DetalleSync({
    this.tipo,
    this.nombre,
    this.parametro,
    this.operador,
    this.valorRespuesta,
  });

  DetalleSync.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'] as String;
    nombre = json['nombre'] as String;
    parametro = (json['parametro'] as List<dynamic>?)?.cast<String>();
    operador = json['operador'] as String;
    valorRespuesta = json['valorRespuesta'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipo'] = tipo;
    data['nombre'] = nombre;
    data['parametro'] = parametro;
    data['operador'] = operador;
    data['valorRespuesta'] = valorRespuesta;
    return data;
  }
}
