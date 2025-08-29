// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class ValidAccountResponseModel {
  Value? value;
  bool? hasSucceeded;

  ValidAccountResponseModel({
    this.value,
    this.hasSucceeded,
  });

  ValidAccountResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null
        ? Value.fromJson(json['value'] as Map<String, dynamic>)
        : null;
    hasSucceeded = json['hasSucceeded'] as bool;
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
  int? iRegistroId;
  bool? bValidacion;
  String? vCodigoValidacion;

  Value({
    this.iRegistroId,
    this.bValidacion,
    this.vCodigoValidacion,
  });

  Value.fromJson(Map<String, dynamic> json) {
    iRegistroId = json['i_registroId'] as int;
    bValidacion = json['b_validacion'] as bool;
    vCodigoValidacion = json['v_codigo_validacion'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_registroId'] = iRegistroId;
    data['b_validacion'] = bValidacion;
    data['v_codigo_validacion'] = vCodigoValidacion;
    return data;
  }
}
