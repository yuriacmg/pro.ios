// ignore_for_file: sort_constructors_first, avoid_unused_constructor_parameters, lines_longer_than_80_chars

class ReniecResponseModel {
  DataReniec? value;
  bool? hasSucceeded;

  ReniecResponseModel({
    value,
    hasSucceeded,
  });

  ReniecResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? DataReniec.fromJson(json['value'] as Map<String, dynamic>) : null;
    hasSucceeded = json['hasSucceeded'] == 'true';
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
  String? apePaterno;
  String? apeMaterno;
  String? nombre;
  String? nombreCompleto;
  String? fecNacimiento;
  String? sexo;

  DataReniec({apePaterno, apeMaterno, nombre, nombreCompleto, fecNacimiento, sexo});

  DataReniec.fromJson(Map<String, dynamic> json) {
    apePaterno = json['apePaterno'].toString();
    apeMaterno = json['apeMaterno'].toString();
    nombre = json['nombre'].toString();
    nombreCompleto = json['nombreCompleto'].toString();
    fecNacimiento = json['fecNacimiento'].toString();
    sexo = json['sexo'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['apePaterno'] = apePaterno;
    data['apeMaterno'] = apeMaterno;
    data['nombre'] = nombre;
    data['nombreCompleto'] = nombreCompleto;
    data['fecNacimiento'] = fecNacimiento;
    data['sexo'] = sexo;
    return data;
  }
}
