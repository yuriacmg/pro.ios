// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first, avoid_dynamic_calls, inference_failure_on_untyped_parameter

class ReniecPerformanceResponseModel {
  ValuePerformance? value;
  bool? hasSucceeded;

  ReniecPerformanceResponseModel({this.value, this.hasSucceeded});

  ReniecPerformanceResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? ValuePerformance.fromJson(json['value'] as Map<String, dynamic>) : null;
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

class ValuePerformance {
  String? apePaterno;
  String? apeMaterno;
  String? nombre;
  String? nombreCompleto;
  String? fecNacimiento;
  String? numdoc;
  String? sexo;
  String? resultadoSiagie;
  bool? rptaSiagieBool;
  String? notara;
  List<ConsultaSiagie>? consultaSiagie;

  ValuePerformance({
    this.apePaterno,
    this.apeMaterno,
    this.nombre,
    this.nombreCompleto,
    this.fecNacimiento,
    this.numdoc,
    this.sexo,
    this.resultadoSiagie,
    this.rptaSiagieBool,
    this.consultaSiagie,
  });

  ValuePerformance.fromJson(Map<String, dynamic> json) {
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nombre = json['nombre'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
    fecNacimiento = json['fecNacimiento'].toString();
    numdoc = json['numdoc'].toString();
    sexo = json['sexo'].toString();
    resultadoSiagie = json['resultadoSiagie'].toString();
    rptaSiagieBool = json['rptaSiagieBool'].toString() == 'true';
    notara = json['notara'] == null ? '' : json['notara'].toString();
    if (json['consultaSiagie'] != null) {
      consultaSiagie = <ConsultaSiagie>[];
      json['consultaSiagie'].forEach((v) {
        consultaSiagie!.add(ConsultaSiagie.fromJson(v as Map<String, dynamic>));
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
    data['resultadoSiagie'] = resultadoSiagie;
    data['rptaSiagieBool'] = rptaSiagieBool;
    if (consultaSiagie != null) {
      data['consultaSiagie'] = consultaSiagie!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultaSiagie {
  String? grado;
  String? condicion;

  ConsultaSiagie({this.grado, this.condicion});

  ConsultaSiagie.fromJson(Map<String, dynamic> json) {
    grado = json['grado'].toString();
    condicion = json['condicion'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grado'] = grado;
    data['condicion'] = condicion;
    return data;
  }
}
