// ignore_for_file: sort_constructors_first, avoid_dynamic_calls, inference_failure_on_untyped_parameter, lines_longer_than_80_chars

class ErrorResponseModel {
  late bool hasSucceeded;
  late List<ValueError> value;
  late int? statusCode;

  ErrorResponseModel({required this.hasSucceeded, required this.value, required this.statusCode});

  ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    hasSucceeded = json['hasSucceeded'].toString() == 'true';
    statusCode = json['statusCode'] == null ? 0 : int.parse(json['statusCode'].toString());
    if (json['value'] != null) {
      value = [];
      json['value'].forEach((v) {
        value.add(ValueError.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hasSucceeded'] = hasSucceeded;
    data['statusCode'] = statusCode;
    data['value'] = value.map((v) => v.toJson()).toList();
    return data;
  }
}

class ValueError {
  late int errorCode;
  late String message;
  late String title;

  ValueError({required this.errorCode, required this.message});

  ValueError.fromJson(Map<String, dynamic> json) {
    errorCode = int.parse(json['errorCode'].toString());
    message = json['message'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    data['title'] = title;
    return data;
  }
}
