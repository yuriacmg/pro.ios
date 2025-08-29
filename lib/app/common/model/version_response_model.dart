// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls, sort_constructors_first

class VersionResponseModel {
  Value? value;
  bool? hasSucceeded;

  VersionResponseModel({this.value, this.hasSucceeded});

  VersionResponseModel.fromJson(Map<String, dynamic> json) {
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
  Value({this.registros});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['registros'] != null) {
      registros = <Registros>[];
      json['registros'].forEach((v) {
        registros!.add(Registros.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Registros>? registros;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (registros != null) {
      data['registros'] = registros!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Registros {
  String? versionApp;
  String? versionCont;
  String? fechaVerApp;
  String? fechaVerCont;

  Registros({this.versionApp, this.versionCont, this.fechaVerApp, this.fechaVerCont});

  Registros.fromJson(Map<String, dynamic> json) {
    versionApp = json['versionApp'].toString();
    versionCont = json['versionCont'].toString();
    fechaVerApp = json['fechaVerApp'].toString();
    fechaVerCont = json['fechaVerCont'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['versionApp'] = versionApp;
    data['versionCont'] = versionCont;
    data['fechaVerApp'] = fechaVerApp;
    data['fechaVerCont'] = fechaVerCont;
    return data;
  }
}
