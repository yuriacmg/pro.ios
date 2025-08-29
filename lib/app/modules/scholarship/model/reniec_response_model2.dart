// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars

class ReniecResponseModel2 {
  DataReniec? value;
  bool? hasSucceeded;

  ReniecResponseModel2({this.value, this.hasSucceeded});

  ReniecResponseModel2.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? DataReniec.fromJson(json['value'] as Map<String, dynamic>) : null;
    hasSucceeded = json['hasSucceeded'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['hasSucceeded'] = hasSucceeded;
    return data;
  }
}

class DataReniec {
  String? numDocumento;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? nombres;
  String? fechaNacimiento;
  String? sexo;
  List<Respuesta>? respuesta;
  String? numCelular;

  DataReniec({
    this.numDocumento,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.nombres,
    this.fechaNacimiento,
    this.sexo,
    this.respuesta,
    this.numCelular,
  });

  DataReniec.fromJson(Map<String, dynamic> json) {
    numDocumento = json['numDocumento'].toString();
    apellidoPaterno = json['apellidoPaterno'].toString();
    apellidoMaterno = json['apellidoMaterno'].toString();
    nombres = json['nombres'].toString();
    fechaNacimiento = json['fechaNacimiento'].toString();
    sexo = json['sexo'].toString();
    numCelular = json['numCelular'].toString();
    if (json['respuesta'] != null) {
      respuesta = [];
      json['respuesta'].forEach((v) {
        respuesta?.add(Respuesta.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numDocumento'] = numDocumento;
    data['apellidoPaterno'] = apellidoPaterno;
    data['apellidoMaterno'] = apellidoMaterno;
    data['nombres'] = nombres;
    data['fechaNacimiento'] = fechaNacimiento;
    data['sexo'] = sexo;
    data['numCelular'] = numCelular;
    if (respuesta != null) {
      data['respuesta'] = respuesta?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Respuesta {
  int? preguntaId;
  int? alternativaRespuesta;
  bool? respuestaAutomatica;
  String? texto;
  bool? rptaIcono;

  Respuesta({
    this.preguntaId,
    this.alternativaRespuesta,
    this.respuestaAutomatica,
    this.texto,
    this.rptaIcono,
  });

  Respuesta.fromJson(Map<String, dynamic> json) {
    preguntaId = int.parse(json['preguntaId'].toString());
    alternativaRespuesta = int.parse(json['alternativaRespuesta'].toString());
    respuestaAutomatica = json['respuestaAutomatica'].toString() == 'true';
    texto = json['texto'].toString();
    rptaIcono = json['rptaIcono'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['preguntaId'] = preguntaId;
    data['alternativaRespuesta'] = alternativaRespuesta;
    data['respuestaAutomatica'] = respuestaAutomatica;
    data['texto'] = texto;
    data['rptaIcono'] = rptaIcono;
    return data;
  }
}
