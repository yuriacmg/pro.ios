// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first, avoid_unused_constructor_parameters

class ReniecReviewSignResponseModel {
  ReniecReviewSignValue? value;
  bool? hasSucceeded;

  ReniecReviewSignResponseModel({value, hasSucceeded});

  ReniecReviewSignResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null
        ? ReniecReviewSignValue.fromJson(json['value'] as Map<String, dynamic>)
        : null;
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

class ReniecReviewSignValue {
  String? apePaterno;
  String? apeMaterno;
  String? nombre;
  String? nombreCompleto;
  String? fecNacimiento;
  String? numdoc;
  String? sexo;
  String? concurso;
  String? modalidad;
  String? fecPostulacion;

  ReniecReviewSignValue({
    required this.apePaterno,
    required this.apeMaterno,
    required this.nombre,
    required this.nombreCompleto,
    required this.fecNacimiento,
    required this.numdoc,
    required this.sexo,
    required this.concurso,
    required this.modalidad,
    required this.fecPostulacion,
  });

  ReniecReviewSignValue.fromJson(Map<String, dynamic> json) {
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nombre = json['nombre'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
    fecNacimiento = json['fecNacimiento'].toString();
    numdoc = json['numdoc'].toString();
    sexo = json['sexo'].toString();
    concurso = json['concurso'].toString();
    modalidad = json['modalidad'].toString();
    fecPostulacion = json['fecPostulacion'].toString();
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
    data['concurso'] = concurso;
    data['modalidad'] = modalidad;
    data['fecPostulacion'] = fecPostulacion;
    return data;
  }
}
