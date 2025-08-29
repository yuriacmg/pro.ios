// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, omit_local_variable_types, lines_longer_than_80_chars

class NoticeResponseModel {
  List<Value>? value;
  bool? hasSucceeded;

  NoticeResponseModel({this.value, this.hasSucceeded});

  NoticeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(v as Map<String, dynamic>));
      });
    }
    hasSucceeded = json['hasSucceeded'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.map((v) => v.toJson()).toList();
    }
    data['hasSucceeded'] = hasSucceeded;
    return data;
  }
}

class Value {
  int? codigo;
  String? titulo;
  String? contenido;
  bool? estado;

  Value({this.codigo, this.titulo, this.contenido, this.estado});

  Value.fromJson(Map<String, dynamic> json) {
    codigo = int.parse(json['codigo'].toString());
    titulo = json['titulo'].toString();
    contenido = json['contenido'].toString();
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['titulo'] = titulo;
    data['contenido'] = contenido;
    data['estado'] = estado;
    return data;
  }
}
