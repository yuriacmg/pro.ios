// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls

class ReniecPrepareExamResponseModel {
  Value? value;
  bool? hasSucceeded;

  ReniecPrepareExamResponseModel({this.value, this.hasSucceeded});

  ReniecPrepareExamResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Preparate>? preparate;

  Value({this.apePaterno, this.apeMaterno, this.nombre, this.nombreCompleto, this.fecNacimiento, this.numdoc, this.sexo, this.preparate});

  Value.fromJson(Map<String, dynamic> json) {
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nombre = json['nombre'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
    fecNacimiento = json['fecNacimiento'].toString();
    numdoc = json['numdoc'].toString();
    sexo = json['sexo'].toString();
    if (json['preparate'] != null) {
      preparate = <Preparate>[];
      json['preparate'].forEach((v) {
        preparate!.add(Preparate.fromJson(v as Map<String, dynamic>));
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
    if (preparate != null) {
      data['preparate'] = preparate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preparate {
  String? codigo;
  String? nombre;
  String? enlaceLogo;
  String? enlaceLogoOffline;
  int? orden;
  List<Preparate>? preparateHijos;


  Preparate({this.codigo, this.nombre, this.enlaceLogo, this.enlaceLogoOffline, this.orden, this.preparateHijos});

  Preparate.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'].toString();
    nombre = json['nombre'].toString();
    enlaceLogo = json['enlace_Logo'].toString();
    orden = int.parse(json['orden'].toString());
    enlaceLogoOffline = json['enlace_Logo_offline'].toString();
    if (json['preparateHijos'] != null) {
      preparateHijos = <Preparate>[];
      json['preparateHijos'].forEach((v) {
        preparateHijos!.add(Preparate.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nombre'] = nombre;
    data['enlace_Logo'] = enlaceLogo;
    data['orden'] = orden;
    data['enlace_Logo_offline'] = enlaceLogoOffline;
    return data;
  }
}
