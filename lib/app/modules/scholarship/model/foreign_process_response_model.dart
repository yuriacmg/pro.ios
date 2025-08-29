// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class ForeignProcessResponseModel {
  ValueForeign? value;
  bool? hasSucceeded;

  ForeignProcessResponseModel({this.value, this.hasSucceeded});

  ForeignProcessResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? ValueForeign.fromJson(json['value'] as Map<String, dynamic>) : null;
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

class ValueForeign {
  int? consultaId;
  String? resultado;
  bool? rptaBool;
  List<int>? modalidadesId;

  ValueForeign({this.consultaId, this.resultado, this.rptaBool, this.modalidadesId});

  ValueForeign.fromJson(Map<String, dynamic> json) {
    consultaId = int.parse(json['consultaId'].toString());
    resultado = json['resultado'].toString();
    rptaBool = json['rptaBool'].toString() == 'true';
    modalidadesId = (json['modalidadesId'] as List).map((e) => e as int).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['consultaId'] = consultaId;
    data['resultado'] = resultado;
    data['rptaBool'] = rptaBool;
    data['modalidadesId'] = modalidadesId;
    return data;
  }
}
