// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls

class NotificationResponseModel {
  Value? value;
  bool? hasSucceeded;

  NotificationResponseModel({this.value, this.hasSucceeded});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value'] as Map<String, dynamic>) : null;
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
  List<Notification>? notificaciones;

  Value({this.notificaciones});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['notificaciones'] != null) {
      notificaciones = <Notification>[];
      json['notificaciones'].forEach((v) {
        notificaciones!.add(Notification.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notificaciones != null) {
      data['notificaciones'] = notificaciones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  int? id;
  String? titulo;
  String? contenido;
  String? fecha;
  String? estadoTiempo;
  bool? estadoLectura;
  String? icono;

  Notification({
    this.id,
    this.titulo,
    this.contenido,
    this.fecha,
    this.estadoTiempo,
    this.estadoLectura,
    this.icono,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    titulo = json['titulo'] as String;
    contenido = json['contenido'] as String;
    fecha = json['fecha'] as String;
    estadoTiempo = json['estadoTiempo'] as String;
    estadoLectura = json['estadoLectura'] as bool;
    icono = json['icono'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = titulo;
    data['contenido'] = contenido;
    data['fecha'] = fecha;
    data['estadoTiempo'] = estadoTiempo;
    data['estadoLectura'] = estadoLectura;
    data['icono'] = icono;
    return data;
  }
}
