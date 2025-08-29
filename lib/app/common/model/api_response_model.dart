//sort_constructors_first

// ignore_for_file: avoid_positional_boolean_parameters, eol_at_end_of_file

class APIResponseModel {
  APIResponseModel(this.status, this.statusCode, this.data, this.message);
  bool status = false;
  int statusCode = 999;
  dynamic data;
  String? message = '';
}
