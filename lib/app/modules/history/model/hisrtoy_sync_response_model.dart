// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars

class HistorySyncResponseModel {
  List<Value>? value;
  bool? hasSucceeded;

  HistorySyncResponseModel({this.value, this.hasSucceeded});

  HistorySyncResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(v as Map<String, dynamic>));
      });
    }
    hasSucceeded = json['hasSucceeded'] as bool;
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
  int? consultaId;
  int? consultaIdTemporal;
  bool? rptaBool;
  List<MotivoError>? motivoError;

  Value({
    this.consultaId,
    this.consultaIdTemporal,
    this.rptaBool,
    this.motivoError,
  });

  Value.fromJson(Map<String, dynamic> json) {
    consultaId = json['consultaId'] as int;
    consultaIdTemporal = json['consultaIdTemporal'] as int;
    rptaBool = json['rptaBool'] as bool;
    if (json['motivoError'] != null) {
        motivoError = <MotivoError>[];
        json['motivoError'].forEach((v) {
          motivoError!.add(MotivoError.fromJson(v as Map<String, dynamic>));
        });
      }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['consultaId'] = consultaId;
    data['consultaIdTemporal'] = consultaIdTemporal;
    data['rptaBool'] = rptaBool;
    if (motivoError != null) {
      data['motivoError'] = motivoError!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotivoError {
  String? errorCode;
  String? message;

  MotivoError({this.errorCode, this.message});

  MotivoError.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'] as String?;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }
}
