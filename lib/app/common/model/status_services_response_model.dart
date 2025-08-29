// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class StatusServicesResponseModel {
  final bool hasSucceeded;
  final Value value;

  StatusServicesResponseModel({
    required this.hasSucceeded,
    required this.value,
  });

  factory StatusServicesResponseModel.fromJson(Map<String, dynamic> json) {
    return StatusServicesResponseModel(
      hasSucceeded: json['hasSucceeded'] as bool,
      value: Value.fromJson(json['value'] as Map<String, dynamic>),
    );
  }
}

class Value {
  final bool rptaBool;
  final List<Service> servicios;

  Value({
    required this.rptaBool,
    required this.servicios,
  });

  factory Value.fromJson(Map<String, dynamic> json) {
    final serviciosList = json['servicios'] as List;
    final servicios =
        serviciosList.map((service) => Service.fromJson(service as Map<String, dynamic>)).toList();

    return Value(
      rptaBool: json['rptaBool'] as bool,
      servicios: servicios,
    );
  }
}

class Service {
  final String servicio;
  final bool rptaBool;
  final String mensaje;

  Service({
    required this.servicio,
    required this.rptaBool,
    required this.mensaje,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      servicio: json['servicio'] as String,
      rptaBool: json['rptaBool'] as bool,
      mensaje: json['mensaje'] as String,
    );
  }
}
