// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class EmailResponseModel {
  Value? value;
  bool? hasSucceeded;

  EmailResponseModel({this.value, this.hasSucceeded});

  EmailResponseModel.fromJson(Map<String, dynamic> json) {
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
  bool? enviado;

  Value({this.enviado});

  Value.fromJson(Map<String, dynamic> json) {
    enviado = json['enviado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['enviado'] = enviado;
    return data;
  }
}
