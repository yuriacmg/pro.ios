// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class PasswordProfileUpdateResponseModel {
  Value? value;
  bool? hasSucceeded;

  PasswordProfileUpdateResponseModel({this.value, this.hasSucceeded});

  PasswordProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value'] as Map<String, dynamic>) : null;
    hasSucceeded = json['hasSucceeded'] as  bool;
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

  Value({this.iRegistroId});

  Value.fromJson(Map<String, dynamic> json) {
    iRegistroId = json['i_registroId'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_registroId'] = iRegistroId;
    return data;
  }
}
