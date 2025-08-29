// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls

class ReniecMinorResponseModel {
  Value? value;
  bool? hasSucceeded;

  ReniecMinorResponseModel({this.value, this.hasSucceeded});

  ReniecMinorResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value'] as Map<String, dynamic>) : null;
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

class Value {
  String? apePaterno;
  String? apeMaterno;
  String? nombre;
  String? nombreCompleto;
  String? fecNacimiento;
  String? numdoc;
  String? sexo;
  bool? esMenor;
  String? respuesta;
  List<Apoderados>? apoderados;

  Value({
    this.apePaterno,
    this.apeMaterno,
    this.nombre,
    this.nombreCompleto,
    this.fecNacimiento,
    this.numdoc,
    this.sexo,
    this.esMenor,
    this.respuesta,
    this.apoderados,
  });

  Value.fromJson(Map<String, dynamic> json) {
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nombre = json['nombre'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
    fecNacimiento = json['fecNacimiento'].toString();
    numdoc = json['numdoc'].toString();
    sexo = json['sexo'].toString();
    esMenor = json['esMenor'].toString() == 'true';
    respuesta = json['respuesta'].toString();
    if (json['apoderados'] != null) {
      apoderados = <Apoderados>[];
      json['apoderados'].forEach((v) {
        apoderados!.add(Apoderados.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['apePaterno'] = apePaterno;
    data['apeMaterno'] = apeMaterno;
    data['nombre'] = nombre;
    data['nombreCompleto'] = nombreCompleto;
    data['fecNacimiento'] = fecNacimiento;
    data['numdoc'] = numdoc;
    data['sexo'] = sexo;
    data['esMenor'] = esMenor;
    data['respuesta'] = respuesta;
    if (apoderados != null) {
      data['apoderados'] = apoderados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apoderados {
  String? nombre;

  Apoderados({this.nombre});

  Apoderados.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    return data;
  }
}
