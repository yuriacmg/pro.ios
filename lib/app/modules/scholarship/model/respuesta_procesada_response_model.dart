// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class RespuestaProcesadaResponseModel {
  Value? value;
  bool? hasSucceeded;

  RespuestaProcesadaResponseModel({this.value, this.hasSucceeded});

  RespuestaProcesadaResponseModel.fromJson(Map<String, dynamic> json) {
    value = (json['value'] != null) ? Value.fromJson(json['value'] as Map<String, dynamic>) : null;
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
  List<int>? modalidadesId;
  int? consultaId;
  bool? rptaBool;
  String? resultado;

  Value({this.modalidadesId, this.consultaId, this.rptaBool, this.resultado});

  Value.fromJson(Map<String, dynamic> json) {
    modalidadesId = (json['modalidadesId'] as List).map((e) => e as int).toList();
    consultaId = json['consultaId'] == null ? null : int.parse(json['consultaId'].toString());
    rptaBool = json['rptaBool'].toString() == 'true';
    resultado = json['resultado'] == null ? '' : json['resultado'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modalidadesId'] = modalidadesId;
    data['consultaId'] = consultaId;
    data['rptaBool'] = rptaBool;
    data['resultado'] = resultado;
    return data;
  }
}
