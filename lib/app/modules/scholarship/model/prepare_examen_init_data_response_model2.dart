// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_untyped_parameter, prefer_null_aware_operators

class PrepareExamInitDataResponseModel2 {
  Value? value;
  bool? hasSucceeded;

  PrepareExamInitDataResponseModel2({this.value, this.hasSucceeded});

  PrepareExamInitDataResponseModel2.fromJson(Map<String, dynamic> json) {
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
  List<Preparate>? preparate;

  Value({this.preparate});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['preparate'] != null) {
      preparate = <Preparate>[];
      json['preparate'].forEach((v) {
        preparate!.add(Preparate.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (preparate != null) {
      data['preparate'] = preparate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preparate {
  int? codigo;
  String? nombre;
  String? enlaceLogo;
  int? orden;
  List<Contenido>? contenido;
  String? enlaceLogoOffline;

  Preparate({
    this.codigo,
    this.nombre,
    this.enlaceLogo,
    this.orden,
    this.contenido,
    this.enlaceLogoOffline,
  });

  Preparate.fromJson(Map<String, dynamic> json) {
    codigo = int.parse(json['codigo'].toString());
    nombre = json['nombre'] == null ? null : json['nombre'].toString();
    enlaceLogo = json['enlace_Logo'] == null ? null : json['enlace_Logo'].toString();
    enlaceLogoOffline = json['enlace_Logo_offline'] == null ? null : json['enlace_Logo_offline'].toString();
    orden = int.parse(json['orden'].toString());
    if (json['contenido'] != null) {
      contenido = <Contenido>[];
      json['contenido'].forEach((v) {
        contenido!.add(Contenido.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nombre'] = nombre;
    data['enlace_Logo'] = enlaceLogo;
    data['enlace_Logo_offline'] = enlaceLogoOffline;
    data['orden'] = orden;
    if (contenido != null) {
      data['contenido'] = contenido!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contenido {
  int? codigo;
  String? nombre;
  int? orden;
  int? nroPregunta;
  String? enlaceLogo;
  String? enlaceLogoOffline;
  int? codigoPreparate;
  List<Preguntas>? preguntas;

  Contenido({
    this.codigo,
    this.nombre,
    this.orden,
    this.nroPregunta,
    this.enlaceLogo,
    this.enlaceLogoOffline,
    this.codigoPreparate,
    this.preguntas,
  });

  Contenido.fromJson(Map<String, dynamic> json) {
    codigo = int.parse(json['codigo'].toString());
    nombre = json['nombre'] == null ? null : json['nombre'].toString();
    orden = int.parse(json['orden'].toString());
    nroPregunta = int.parse(json['nro_pregunta'].toString());
    enlaceLogo = json['enlace_Logo'] == null ? null : json['enlace_Logo'].toString();
    enlaceLogoOffline = json['enlace_Logo_offline'] == null ? null : json['enlace_Logo_offline'].toString();
    codigoPreparate = int.parse(json['codigo_preparate'].toString());
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
    data['enlace_Logo_offline'] = enlaceLogoOffline;
    data['codigo_preparate'] = codigoPreparate;
    if (preguntas != null) {
      data['preguntas'] = preguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preguntas {
  int? simulacroId;
  int? preguntaId;
  String? pregunta;
  String? comentarios;
  String? enlaceImagen;
  int? orden;
  String? respuesta;
  String? tipo;
  int? preguntaPadreId;
  String? area;
  String? preguntaOffline;
  String? comentarioOffline;
  String? enlaceImagenOffline;
  List<Alternativas>? alternativas;

  Preguntas({
    this.simulacroId,
    this.preguntaId,
    this.pregunta,
    this.comentarios,
    this.enlaceImagen,
    this.preguntaOffline,
    this.comentarioOffline,
    this.enlaceImagenOffline,
    this.orden,
    this.respuesta,
    this.tipo,
    this.preguntaPadreId,
    this.area,
    this.alternativas,
  });

  Preguntas.fromJson(Map<String, dynamic> json) {
    // simulacroId = int.parse(json['simulacro_id'].toString());
    simulacroId = 0;
    preguntaId = int.parse(json['pregunta_id'].toString());
    pregunta = json['pregunta'] == null ? '' : json['pregunta'].toString();
    comentarios = json['comentarios'] == null ? '' : json['comentarios'].toString();
    enlaceImagen = json['enlace_imagen'] == null ? '' : json['enlace_imagen'].toString();
    preguntaOffline = json['pregunta_offline'] == null ? '' : json['pregunta_offline'].toString();
    comentarioOffline = json['comentario_offline'] == null ? '' : json['comentario_offline'].toString();
    enlaceImagenOffline = json['enlace_imagen_offline'] == null ? '' : json['enlace_imagen_offline'].toString();
    orden = int.parse(json['orden'].toString());
    respuesta = json['respuesta'] == null ? null : json['respuesta'].toString();
    tipo = json['tipo'] == null ? null : json['tipo'].toString();
    preguntaPadreId = json['pregunta_padre_id'] == null ? null : int.parse(json['pregunta_padre_id'].toString());
    area = json['area'] == null ? null : json['area'].toString();
    if (json['alternativas'] != null) {
      alternativas = <Alternativas>[];
      json['alternativas'].forEach((v) {
        alternativas!.add(Alternativas.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['simulacro_id'] = simulacroId;
    data['pregunta_id'] = preguntaId;
    data['pregunta'] = pregunta;
    data['comentarios'] = comentarios;
    data['enlace_imagen'] = enlaceImagen;
    data['pregunta_offline'] = preguntaOffline;
    data['comentario_offline'] = comentarioOffline;
    data['enlace_imagen_offline'] = enlaceImagenOffline;
    data['orden'] = orden;
    data['respuesta'] = respuesta;
    data['tipo'] = tipo;
    data['pregunta_padre_id'] = preguntaPadreId;
    data['area'] = area;
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
  String? type;
  String? typeAlternativa;
  String? alternativaOffline;
  String? enlaceImagenOffline;
  String? typeAlternativaOffline;

  Alternativas({
    this.alternativaId,
    this.preguntaId,
    this.codigo,
    this.alternativa,
    this.enlaceImagen,
    this.type,
    this.typeAlternativa,
    this.alternativaOffline,
    this.enlaceImagenOffline,
    this.typeAlternativaOffline,
  });

  Alternativas.fromJson(Map<String, dynamic> json) {
    alternativaId = int.parse(json['alternativa_id'].toString());
    preguntaId = int.parse(json['pregunta_id'].toString());
    codigo = json['codigo'] == null ? null : json['codigo'].toString();
    alternativa = json['alternativa'] == null ? '' : json['alternativa'].toString();
    enlaceImagen = json['enlace_imagen'] == null ? '' : json['enlace_imagen'].toString();
    alternativaOffline = json['alternativa_offline'] == null ? '' : json['alternativa_offline'].toString();
    enlaceImagenOffline = json['enlace_imagen_offline'] == null ? '' : json['enlace_imagen_offline'].toString();
    type = json['type'].toString();
    typeAlternativa = json['type_alternativa'] == null ? null : json['type_alternativa'].toString();
    typeAlternativaOffline = json['type_alternativa_offline'] == null ? null : json['type_alternativa_offline'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alternativa_id'] = alternativaId;
    data['pregunta_id'] = preguntaId;
    data['codigo'] = codigo;
    data['alternativa'] = alternativa;
    data['enlace_imagen'] = enlaceImagen;
    data['type'] = type;
    data['type_alternativa'] = typeAlternativa;
    data['alternativa_offline'] = alternativaOffline;
    data['enlace_imagen_offline'] = enlaceImagenOffline;
    data['type_alternativa_offline'] = typeAlternativaOffline;
    return data;
  }
}
