// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class ForeignResponseModel {
  Value? value;
  bool? hasSucceeded;

  ForeignResponseModel({this.value, this.hasSucceeded});

  ForeignResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? nombres;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? nroDocumento;

  Value({this.id, this.nombres, this.apellidoPaterno, this.apellidoMaterno, this.nroDocumento});

  Value.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    nombres = json['nombres'].toString();
    apellidoPaterno = json['apePaterno'].toString();
    apellidoMaterno = json['apeMaterno'] == null ? '' : json['apeMaterno'] as String;
    nroDocumento = json['nroDocumento'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombres'] = nombres;
    data['apellidoPaterno'] = apellidoPaterno;
    data['apellidoMaterno'] = apellidoMaterno;
    data['nroDocumento'] = nroDocumento;
    return data;
  }
}
