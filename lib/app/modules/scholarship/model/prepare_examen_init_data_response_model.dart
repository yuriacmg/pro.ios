// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls, prefer_null_aware_operators

class PrepareExamInitDataResponseModel {
  Value? value;
  bool? hasSucceeded;

  PrepareExamInitDataResponseModel({this.value, this.hasSucceeded});

  PrepareExamInitDataResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value'] as Map<String, dynamic>) : null;
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
  List<AreasData>? areasComunes;
  List<AreasData>? areasInteres;

  Value({this.areasComunes, this.areasInteres});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['areasComunes'] != null) {
      areasComunes = <AreasData>[];
      json['areasComunes'].forEach((v) {
        areasComunes!.add(AreasData.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['areasInteres'] != null) {
      areasInteres = <AreasData>[];
      json['areasInteres'].forEach((v) {
        areasInteres!.add(AreasData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (areasComunes != null) {
      data['areasComunes'] = areasComunes!.map((v) => v.toJson()).toList();
    }
    if (areasInteres != null) {
      data['areasInteres'] = areasInteres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreasData {
  int? codigo;
  String? nombre;
  int? orden;
  int? nroPregunta;
  String? enlaceLogo;
  List<Preguntas>? preguntas;

  AreasData({this.codigo, this.nombre, this.orden, this.nroPregunta, this.enlaceLogo, this.preguntas});

  AreasData.fromJson(Map<String, dynamic> json) {
    codigo = int.parse(json['codigo'].toString());
    nombre = json['nombre'].toString();
    orden = int.parse(json['orden'].toString());
    nroPregunta = int.parse(json['nro_pregunta'].toString());
    enlaceLogo = json['enlace_Logo'].toString();
    if (json['preguntas'] != null) {
      preguntas = <Preguntas>[];
      json['preguntas'].forEach((v) {
        preguntas!.add(Preguntas.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nombre'] = nombre;
    data['orden'] = orden;
    data['nro_pregunta'] = nroPregunta;
    data['enlace_Logo'] = enlaceLogo;
    if (preguntas != null) {
      data['preguntas'] = preguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preguntas {
  int? preguntaId;
  String? pregunta;
  String? comentarios;
  String? enlaceImagen;
  int? orden;
  String? respuesta;
  List<Alternativas>? alternativas;

  Preguntas({this.preguntaId, this.pregunta, this.comentarios, this.enlaceImagen, this.orden, this.respuesta, this.alternativas});

  Preguntas.fromJson(Map<String, dynamic> json) {
    preguntaId = int.parse(json['pregunta_id'].toString());
    pregunta = json['pregunta'] == null ? null : json['pregunta'].toString();
    comentarios = json['comentarios'] == null ? null : json['comentarios'].toString();
    enlaceImagen = json['enlace_imagen'] == null ? null : json['enlace_imagen'].toString();
    orden = int.parse(json['orden'].toString());
    respuesta = json['respuesta'] == null ? null : json['respuesta'].toString();
    if (json['alternativas'] != null) {
      alternativas = <Alternativas>[];
      json['alternativas'].forEach((v) {
        alternativas!.add(Alternativas.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pregunta_id'] = preguntaId;
    data['pregunta'] = pregunta;
    data['comentarios'] = comentarios;
    data['enlace_imagen'] = enlaceImagen;
    data['orden'] = orden;
    data['respuesta'] = respuesta;
    if (alternativas != null) {
      data['alternativas'] = alternativas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alternativas {
  int? alternativaId;
  int? preguntaId;
  String? codigo;
  String? alternativa;
  String? enlaceImagen;

  Alternativas({this.alternativaId, this.preguntaId, this.codigo, this.alternativa, this.enlaceImagen});

  Alternativas.fromJson(Map<String, dynamic> json) {
    alternativaId = int.parse(json['alternativa_id'].toString());
    preguntaId = int.parse(json['pregunta_id'].toString());
    codigo = json['codigo'].toString();
    alternativa = json['alternativa'].toString();
    enlaceImagen = json['enlace_imagen'] == null ? null : json['enlace_imagen'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alternativa_id'] = alternativaId;
    data['pregunta_id'] = preguntaId;
    data['codigo'] = codigo;
    data['alternativa'] = alternativa;
    data['enlace_imagen'] = enlaceImagen;
    return data;
  }
}
