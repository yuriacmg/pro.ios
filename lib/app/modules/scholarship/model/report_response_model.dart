// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class ReportResponseModel {
  String? value;
  bool? hasSucceeded;

  ReportResponseModel({this.value, this.hasSucceeded});

  ReportResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'].toString();
    hasSucceeded = json['hasSucceeded'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['hasSucceeded'] = hasSucceeded;
    return data;
  }
}

class FileResponseModel {
  ValueResponseFile? value;
  bool? hasSucceeded;

  FileResponseModel({this.value, this.hasSucceeded});

  FileResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? ValueResponseFile.fromJson(json['value'] as Map<String, dynamic>) : null;
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

class ValueResponseFile {
  String? base64;
  String? nombrearchivo;
  String? path;

  ValueResponseFile({this.base64, this.nombrearchivo});

  ValueResponseFile.fromJson(Map<String, dynamic> json) {
    base64 = json['base64'].toString();
    nombrearchivo = json['nombrearchivo'].toString();
    path = json['path'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['base64'] = base64;
    data['nombrearchivo'] = nombrearchivo;
    data['path'] = path;
    return data;
  }
}
