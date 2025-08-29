// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls

class VersionResponseModel2 {
  Value? value;
  bool? hasSucceeded;

  VersionResponseModel2({this.value, this.hasSucceeded});

  VersionResponseModel2.fromJson(Map<String, dynamic> json) {
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
  List<Registros>? registros;

  Value({this.registros});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['registros'] != null) {
      registros = <Registros>[];
      json['registros'].forEach((v) {
        registros!.add(Registros.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (registros != null) {
      data['registros'] = registros!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Registros {
  List<String>? versionApp;
  List<String>? versionAppIOS;
  String? versionCont;
  String? fechaVerApp;
  String? fechaVerCont;

  Registros({this.versionApp, this.versionAppIOS, this.versionCont, this.fechaVerApp, this.fechaVerCont});

  Registros.fromJson(Map<String, dynamic> json) {
    versionApp = (json['versionApp'] as List).map((dynamic elemento) => elemento.toString()).toList();
    versionAppIOS = (json['versionAppIOS'] as List).map((dynamic elemento) => elemento.toString()).toList();
    versionCont = json['versionCont'].toString();
    fechaVerApp = json['fechaVerApp'].toString();
    fechaVerCont = json['fechaVerCont'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['versionApp'] = versionApp;
    data['versionAppIOS'] = versionAppIOS;
    data['versionCont'] = versionCont;
    data['fechaVerApp'] = fechaVerApp;
    data['fechaVerCont'] = fechaVerCont;
    return data;
  }
}
