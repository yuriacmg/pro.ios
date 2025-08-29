// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars

class PrepareExamInitDataResponseModel3 {
  Value? value;
  bool? hasSucceeded;

  PrepareExamInitDataResponseModel3({this.value, this.hasSucceeded});

  PrepareExamInitDataResponseModel3.fromJson(Map<String, dynamic> json) {
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
  List<Preparate2>? preparate2;
  List<Preparate>? preparate;

  Value({this.preparate2, this.preparate});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['preparate2'] != null) {
      preparate2 = <Preparate2>[];
      json['preparate2'].forEach((v) {
        preparate2!.add(Preparate2.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['preparate'] != null) {
      preparate = <Preparate>[];
      json['preparate'].forEach((v) {
        preparate!.add(Preparate.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (preparate2 != null) {
      data['preparate2'] = preparate2!.map((v) => v.toJson()).toList();
    }
    if (preparate != null) {
      data['preparate'] = preparate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preparate2 {
  String? codigo;
  String? nombre;
  String? enlaceLogo;
  String? enlaceLogoOffline;
  int? orden;
  List<PreparateHijos>? preparateHijos;

  Preparate2(
      {this.codigo,
      this.nombre,
      this.enlaceLogo,
      this.enlaceLogoOffline,
      this.orden,
      this.preparateHijos,
      });

  Preparate2.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] as String?;
    nombre = json['nombre'] as String?;
    enlaceLogo = json['enlace_Logo'] as String?;
    enlaceLogoOffline = json['enlace_Logo_offline'] as String?;
    orden = json['orden'] as int?;
    if (json['preparateHijos'] != null) {
      preparateHijos = <PreparateHijos>[];
      json['preparateHijos'].forEach((v) {
        preparateHijos!.add(PreparateHijos.fromJson(v as Map<String, dynamic> ));
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
    if (preparateHijos != null) {
      data['preparateHijos'] =
          preparateHijos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreparateHijos {
  String? codigo;
  String? nombre;
  String? enlaceLogo;
  String? enlaceLogoOffline;
  int? orden;
  List<PreparateHijos>? preparateHijos;

  PreparateHijos(
      {this.codigo,
      this.nombre,
      this.enlaceLogo,
      this.enlaceLogoOffline,
      this.orden,
      this.preparateHijos,
      });

  PreparateHijos.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] as String?;
    nombre = json['nombre'] as String?;
    enlaceLogo = json['enlace_Logo'] as String?;
    enlaceLogoOffline = json['enlace_Logo_offline'] as String?;
    orden = json['orden'] as int?;
     if (json['preparateHijos'] != null) {
      preparateHijos = <PreparateHijos>[];
      json['preparateHijos'].forEach((v) {
        preparateHijos!.add(PreparateHijos.fromJson(v as Map<String, dynamic> ));
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
    data['preparateHijos'] = preparateHijos;
    return data;
  }
}

class Preparate {
  int? codigo;
  String? nombre;
  String? enlaceLogo;
  String? enlaceLogoOffline;
  int? orden;
  List<Contenido>? contenido;

  Preparate(
      {this.codigo,
      this.nombre,
      this.enlaceLogo,
      this.enlaceLogoOffline,
      this.orden,
      this.contenido,
      });

  Preparate.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] as int?;
    nombre = json['nombre'] as String?;
    enlaceLogo = json['enlace_Logo'] as String?;
    enlaceLogoOffline = json['enlace_Logo_offline'] as String?;
    orden = json['orden'] as int?;
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

  Contenido(
      {this.codigo,
      this.nombre,
      this.orden,
      this.nroPregunta,
      this.enlaceLogo,
      this.enlaceLogoOffline,
      this.codigoPreparate,
      this.preguntas,
      });

  Contenido.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'] as int?;
    nombre = json['nombre'] as String?;
    orden = json['orden'] as int?;
    nroPregunta = json['nro_pregunta'] as int?;
    enlaceLogo = json['enlace_Logo'] as String?;
    enlaceLogoOffline = json['enlace_Logo_offline'] as String?;
    codigoPreparate = json['codigo_preparate'] as int?;
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
  bool? modoOffline;
  List<Alternativas>? alternativas;

  Preguntas(
      {this.simulacroId,
      this.preguntaId,
      this.pregunta,
      this.comentarios,
      this.enlaceImagen,
      this.orden,
      this.respuesta,
      this.tipo,
      this.preguntaPadreId,
      this.area,
      this.preguntaOffline,
      this.comentarioOffline,
      this.enlaceImagenOffline,
      this.modoOffline,
      this.alternativas,
      });

  Preguntas.fromJson(Map<String, dynamic> json) {
    simulacroId = json['simulacro_id'] as int?;
    preguntaId = json['pregunta_id'] as int?;
    pregunta = json['pregunta'] as String?;
    comentarios = json['comentarios'] as String?;
    enlaceImagen = json['enlace_imagen'] as String?;
    orden = json['orden'] as int?;
    respuesta = json['respuesta'] as String?;
    tipo = json['tipo'] as String?;
    preguntaPadreId = json['pregunta_padre_id'] as int?;
    area = json['area'] as String?;
    preguntaOffline = json['pregunta_offline'] as String?;
    comentarioOffline = json['comentario_offline'] as String?;
    enlaceImagenOffline = json['enlace_imagen_offline'] as String?;
    modoOffline = json['modo_offline'] as bool;
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
    data['orden'] = orden;
    data['respuesta'] = respuesta;
    data['tipo'] = tipo;
    data['pregunta_padre_id'] = preguntaPadreId;
    data['area'] = area;
    data['pregunta_offline'] = preguntaOffline;
    data['comentario_offline'] = comentarioOffline;
    data['enlace_imagen_offline'] = enlaceImagenOffline;
    data['modo_offline'] = modoOffline;
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

  Alternativas(
      {this.alternativaId,
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
    alternativaId = json['alternativa_id'] as int?;
    preguntaId = json['pregunta_id'] as int?;
    codigo = json['codigo'] as String?;
    alternativa = json['alternativa'] as String?;
    enlaceImagen = json['enlace_imagen'] as String?;
    type = json['type'] as String?;
    typeAlternativa = json['type_alternativa'] as String?;
    alternativaOffline = json['alternativa_offline'] as String?;
    enlaceImagenOffline = json['enlace_imagen_offline'] as String?;
    typeAlternativaOffline = json['type_alternativa_offline'] as String?;
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
