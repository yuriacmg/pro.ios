// ignore_for_file: sort_constructors_first, inference_failure_on_untyped_parameter, avoid_dynamic_calls, lines_longer_than_80_chars, prefer_null_aware_operators

class NewScholarshipResponseModel {
  NewScholarshipResponseModel({
    required this.value,
    required this.hasSucceeded,
  });
  late Value value;
  late bool hasSucceeded;

  NewScholarshipResponseModel.fromJson(Map<String, dynamic> json) {
    value = (json['value'] != null ? Value.fromJson(json['value'] as Map<String, dynamic>) : null)!;
    hasSucceeded = json['hasSucceeded'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value.toJson();
    data['hasSucceeded'] = hasSucceeded;
    return data;
  }
}

class Value {
  Value({
    required this.modalidad,
    required this.pregunta,
    required this.seccion,
    required this.contacto,
    required this.canalAtencion,
    required this.consultaSisfoh,
    required this.pais,
    required this.tipoTramite,
    required this.becasOtrosPaises,
    required this.preguntaFrecuente,
    required this.enlaceRelacionado,
  });

  late List<Modalidad> modalidad;
  late List<Pregunta> pregunta;
  late List<Seccion> seccion;
  late List<Contacto> contacto;
  late List<CanalAtencion> canalAtencion;
  late ConsultaSisfoh? consultaSisfoh;
  late List<DataCombo> pais;
  late List<DataCombo> tipoTramite;
  late List<Parametros>? parametros;
  List<ParametrosFiltro>? parametrosFiltro;
  List<BecasOtrosPaises>? becasOtrosPaises;
  List<PreguntaFrecuente>? preguntaFrecuente;
  List<EnlaceRelacionado>? enlaceRelacionado;

  Value.fromJson(Map<String, dynamic> json) {
    if (json['modalidad'] != null) {
      modalidad = [];
      json['modalidad'].forEach((v) {
        modalidad.add(Modalidad.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['pregunta'] != null) {
      pregunta = [];
      json['pregunta'].forEach((v) {
        pregunta.add(Pregunta.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['seccion'] != null) {
      seccion = [];
      json['seccion'].forEach((v) {
        seccion.add(Seccion.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['contacto'] != null) {
      contacto = [];
      json['contacto'].forEach((v) {
        contacto.add(Contacto.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['canal_atencion'] != null) {
      canalAtencion = [];
      json['canal_atencion'].forEach((v) {
        canalAtencion.add(CanalAtencion.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['consulta_sisfoh'] != null) {
      consultaSisfoh = (json['consulta_sisfoh'] != null
          ? ConsultaSisfoh.fromJson(
              json['consulta_sisfoh'] as Map<String, dynamic>,
            )
          : null);
    }

    if (json['paises'] != null) {
      pais = [];
      json['paises'].forEach((v) {
        pais.add(DataCombo.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['tipotramite'] != null) {
      tipoTramite = [];
      json['tipotramite'].forEach((v) {
        tipoTramite.add(DataCombo.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['parametros'] != null) {
      parametros = <Parametros>[];
      json['parametros'].forEach((v) {
        parametros!.add(Parametros.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['parametros_filtro'] != null) {
      parametrosFiltro = <ParametrosFiltro>[];
      json['parametros_filtro'].forEach((v) {
        parametrosFiltro!.add(ParametrosFiltro.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['becas_otros_paises'] != null) {
      becasOtrosPaises = <BecasOtrosPaises>[];
      json['becas_otros_paises'].forEach((v) {
        becasOtrosPaises!.add(BecasOtrosPaises.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['becas_otros_paises'] != null) {
      becasOtrosPaises = <BecasOtrosPaises>[];
      json['becas_otros_paises'].forEach((v) {
        becasOtrosPaises!.add(BecasOtrosPaises.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['pregunta_frecuente'] != null) {
      preguntaFrecuente = <PreguntaFrecuente>[];
      json['pregunta_frecuente'].forEach((v) {
        preguntaFrecuente!.add(PreguntaFrecuente.fromJson(v as Map<String, dynamic>));
      });
    }

    if (json['enlace_relacionado'] != null) {
      enlaceRelacionado = <EnlaceRelacionado>[];
      json['enlace_relacionado'].forEach((v) {
        enlaceRelacionado!.add(EnlaceRelacionado.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modalidad'] = modalidad.map((v) => v.toJson()).toList();
    data['pregunta'] = pregunta.map((v) => v.toJson()).toList();
    data['seccion'] = seccion.map((v) => v.toJson()).toList();
    data['contacto'] = contacto.map((v) => v.toJson()).toList();
    data['canal_atencion'] = canalAtencion.map((v) => v.toJson()).toList();
    data['consulta_sisfoh'] = consultaSisfoh!.toJson();
    data['parametros'] = parametros!.map((v) => v.toJson()).toList();
    data['parametros_filtro'] = parametrosFiltro!.map((v) => v.toJson()).toList();
    data['becas_otros_paises'] = becasOtrosPaises!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Modalidad {
  late int modId;
  late String nomCompleto;
  late String nomCorto;
  late String codigo;
  late String enlaceMod;
  late String enlaceInform;
  late String enlaceLog;
  late String beneficios;
  late String impedimentos;
  late String vFecPostu;
  late String dFecPostu;
  late bool publicada;
  late bool estado;
  late String fecRegistro;
  late String usrRegistro;
  late String fecModific;
  late String ursModific;
  late List<ModalidadRequisito> modalidadRequisito;
  late List<ModalidadBeneficio> modalidadBeneficio;
  late List<ModalidadImpedimento> modalidadImpedimento;
  late String base64;
  late String enlaceLogOffline;
  late bool estadoConDiscapacidad;
  List<PalabrasClave>? palabrasClave;
  late List<ModalidadDocumentoClave> modalidadDocumentoClave;
  late String colorDegradadoInicio;
  late String colorDegradadoFin;
  late String grupo;
  late String grupoEnlaceLogoGrupo;
  late String grupoEnlaceLogoGrupoOffline;
  late String grupoColorDegradadoInicio;
  late String grupoColorDegradadoFin;

  Modalidad({
    required this.modId,
    required this.nomCompleto,
    required this.nomCorto,
    required this.codigo,
    required this.enlaceMod,
    required this.enlaceInform,
    required this.enlaceLog,
    required this.beneficios,
    required this.impedimentos,
    required this.vFecPostu,
    required this.dFecPostu,
    required this.publicada,
    required this.estado,
    required this.fecRegistro,
    required this.usrRegistro,
    required this.fecModific,
    required this.ursModific,
    required this.modalidadRequisito,
    required this.modalidadBeneficio,
    required this.modalidadImpedimento,
    required this.base64,
    required this.enlaceLogOffline,
    required this.palabrasClave,
    required this.estadoConDiscapacidad,
    required this.modalidadDocumentoClave,
    required this.colorDegradadoInicio,
    required this.colorDegradadoFin,
    required this.grupo,
    required this.grupoEnlaceLogoGrupo,
    required this.grupoEnlaceLogoGrupoOffline,
    required this.grupoColorDegradadoInicio,
    required this.grupoColorDegradadoFin,
  });

  Modalidad.fromJson(Map<String, dynamic> json) {
    modId = int.parse(json['modId'].toString());
    nomCompleto = json['nomCompleto'].toString();
    nomCorto = json['nomCorto'].toString();
    codigo = json['codigo'].toString();
    enlaceMod = json['enlaceMod'].toString();
    enlaceInform = json['enlaceInform'].toString();
    enlaceLog = json['enlaceLog'].toString();
    enlaceLogOffline = json['enlaceLogOffline'].toString();
    beneficios = json['beneficios'].toString();
    impedimentos = json['impedimentos'].toString();
    vFecPostu = json['vFecPostu'].toString();
    dFecPostu = json['dFecPostu'].toString();
    publicada = json['publicada'].toString() == 'true';
    estado = json['estado'].toString() == 'true';
    fecRegistro = json['fecRegistro'].toString();
    usrRegistro = json['usrRegistro'].toString();
    fecModific = json['fecModific'].toString();
    ursModific = json['ursModific'].toString();
    estadoConDiscapacidad = json['estadoConDiscapacidad'] as bool;

    colorDegradadoInicio = json['colorDegradadoInicio'].toString();
    colorDegradadoFin = json['colorDegradadoFin'].toString();
    grupo = json['grupo'].toString();
    grupoEnlaceLogoGrupo = json['grupoEnlaceLogoGrupo'].toString();
    grupoEnlaceLogoGrupoOffline = json['grupoEnlaceLogoGrupoOffline'].toString();
    grupoColorDegradadoInicio = json['grupoColorDegradadoInicio'].toString();
    grupoColorDegradadoFin = json['grupoColorDegradadoFin'].toString();

    base64 = json['base64'].toString();
    if (json['modalidad_requisito'] != null) {
      modalidadRequisito = [];
      json['modalidad_requisito'].forEach((v) {
        modalidadRequisito.add(ModalidadRequisito.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['modalidad_beneficio'] != null) {
      modalidadBeneficio = [];
      json['modalidad_beneficio'].forEach((v) {
        modalidadBeneficio.add(ModalidadBeneficio.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['modalidad_impedimento'] != null) {
      modalidadImpedimento = [];
      json['modalidad_impedimento'].forEach((v) {
        modalidadImpedimento.add(ModalidadImpedimento.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['palabras_clave'] != null) {
      palabrasClave = <PalabrasClave>[];
      json['palabras_clave'].forEach((v) {
        palabrasClave!.add(PalabrasClave.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['modalidad_documento_clave'] != null) {
      modalidadDocumentoClave = [];
      json['modalidad_documento_clave'].forEach((v) {
        modalidadDocumentoClave.add(ModalidadDocumentoClave.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modId'] = modId;
    data['nomCompleto'] = nomCompleto;
    data['nomCorto'] = nomCorto;
    data['codigo'] = codigo;
    data['enlaceMod'] = enlaceMod;
    data['enlaceInform'] = enlaceInform;
    data['enlaceLog'] = enlaceLog;
    data['enlaceLogOffline'] = enlaceLogOffline;
    data['beneficios'] = beneficios;
    data['impedimentos'] = impedimentos;
    data['vFecPostu'] = vFecPostu;
    data['dFecPostu'] = dFecPostu;
    data['publicada'] = publicada;
    data['estado'] = estado;
    data['fecRegistro'] = fecRegistro;
    data['usrRegistro'] = usrRegistro;
    data['fecModific'] = fecModific;
    data['ursModific'] = ursModific;
    data['estadoConDiscapacidad'] = estadoConDiscapacidad;

    data['colorDegradadoInicio'] = colorDegradadoInicio;
    data['colorDegradadoFin'] = colorDegradadoFin;
    data['grupo'] = grupo;
    data['grupoEnlaceLogoGrupo'] = grupoEnlaceLogoGrupo;
    data['grupoEnlaceLogoGrupoOffline'] = grupoEnlaceLogoGrupoOffline;
    data['grupoColorDegradadoInicio'] = grupoColorDegradadoInicio;
    data['grupoColorDegradadoFin'] = grupoColorDegradadoFin;

    data['base64'] = base64;
    data['modalidad_requisito'] = modalidadRequisito.map((v) => v.toJson()).toList();
    data['modalidad_beneficio'] = modalidadBeneficio.map((v) => v.toJson()).toList();
    data['modalidad_impedimento'] = modalidadImpedimento.map((v) => v.toJson()).toList();
    data['palabras_clave'] = palabrasClave!.map((v) => v.toJson()).toList();

    return data;
  }
}

class PalabrasClave {
  int? filtroContenidoId;

  PalabrasClave({this.filtroContenidoId});

  PalabrasClave.fromJson(Map<String, dynamic> json) {
    filtroContenidoId = json['filtro_contenido_id'] as int?;
  }
 
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filtro_contenido_id'] = filtroContenidoId;
    return data;
  }
}

class ModalidadRequisito {
  late int modRequisId;
  late int requisId;
  late int modId;
  late String descripc;
  late String enlaceImg;
  late int orden;
  late bool estado;
  late String fecRegistro;
  late String usrRegistro;
  late String fecModific;
  late String ursModific;

  ModalidadRequisito({
    required this.modRequisId,
    required this.requisId,
    required this.modId,
    required this.descripc,
    required this.enlaceImg,
    required this.orden,
    required this.estado,
    required this.fecRegistro,
    required this.usrRegistro,
    required this.fecModific,
    required this.ursModific,
  });

  ModalidadRequisito.fromJson(Map<String, dynamic> json) {
    modRequisId = int.parse(json['modRequisId'].toString());
    requisId = int.parse(json['requisId'].toString());
    modId = int.parse(json['modId'].toString());
    descripc = json['descripc'].toString();
    enlaceImg = json['enlaceImg'].toString();
    orden = int.parse(json['orden'].toString());
    estado = json['estado'].toString() == 'true';
    fecRegistro = json['fecRegistro'].toString();
    usrRegistro = json['usrRegistro'].toString();
    fecModific = json['fecModific'].toString();
    ursModific = json['ursModific'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modRequisId'] = modRequisId;
    data['requisId'] = requisId;
    data['modId'] = modId;
    data['descripc'] = descripc;
    data['enlaceImg'] = enlaceImg;
    data['orden'] = orden;
    data['estado'] = estado;
    data['fecRegistro'] = fecRegistro;
    data['usrRegistro'] = usrRegistro;
    data['fecModific'] = fecModific;
    data['ursModific'] = ursModific;
    return data;
  }
}

class ModalidadDocumentoClave {
  late int modDocClaveId;
  late int modId;
  late String descripc;
  late int orden;
  late bool estado;

  ModalidadDocumentoClave({
    required this.modDocClaveId,
    required this.modId,
    required this.descripc,
    required this.orden,
    required this.estado,
  });

  ModalidadDocumentoClave.fromJson(Map<String, dynamic> json) {
    modDocClaveId = int.parse(json['modDocClaveId'].toString());
    modId = int.parse(json['modId'].toString());
    descripc = json['descripc'].toString();
    orden = int.parse(json['orden'].toString());
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modDocClaveId'] = modDocClaveId;
    data['modId'] = modId;
    data['descripc'] = descripc;
    data['orden'] = orden;
    data['estado'] = estado;
    return data;
  }
}

class ModalidadBeneficio {
  late int? modBeneficioId;
  late int? beneficioId;
  late int? modId;
  late String? descripc;
  late String? enlaceImg;
  late int? orden;
  late bool? estado;

  ModalidadBeneficio({
    this.modBeneficioId,
    this.beneficioId,
    this.modId,
    this.descripc,
    this.enlaceImg,
    this.orden,
    this.estado,
  });

  ModalidadBeneficio.fromJson(Map<String, dynamic> json) {
    modBeneficioId = int.parse(json['modBeneficioId'].toString());
    beneficioId = int.parse(json['beneficioId'].toString());
    modId = int.parse(json['modId'].toString());
    descripc = json['descripc'].toString();
    enlaceImg = json['enlaceImg'].toString();
    orden = int.parse(json['orden'].toString());
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modBeneficioId'] = modBeneficioId;
    data['beneficioId'] = beneficioId;
    data['modId'] = modId;
    data['descripc'] = descripc;
    data['enlaceImg'] = enlaceImg;
    data['orden'] = orden;
    data['estado'] = estado;
    return data;
  }
}

class ModalidadImpedimento {
  int? modImpedId;
  int? impedId;
  int? modId;
  String? descripc;
  String? enlaceImg;
  int? orden;
  bool? estado;

  ModalidadImpedimento({
    this.modImpedId,
    this.impedId,
    this.modId,
    this.descripc,
    this.enlaceImg,
    this.orden,
    this.estado,
  });

  ModalidadImpedimento.fromJson(Map<String, dynamic> json) {
    modImpedId = int.parse(json['modImpedId'].toString());
    impedId = int.parse(json['impedId'].toString());
    modId = int.parse(json['modId'].toString());
    descripc = json['descripc'].toString();
    enlaceImg = json['enlaceImg'].toString();
    orden = int.parse(json['orden'].toString());
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modImpedId'] = modImpedId;
    data['impedId'] = impedId;
    data['modId'] = modId;
    data['descripc'] = descripc;
    data['enlaceImg'] = enlaceImg;
    data['orden'] = orden;
    data['estado'] = estado;
    return data;
  }
}

class Pregunta {
  late int preguntaId;
  late int seccionId;
  late String codigo;
  late String enunciado;
  late String detalle;
  late String enlaceImg;
  late String enlaceImgOffline;
  late int tipoId;
  late bool estado;
  late String fecRegistro;
  late String usrRegistro;
  late String fecModific;
  late String ursModific;
  late int? orden;
  late String? titulolista;
  late List<Opciones>? opciones;

  Pregunta({
    required this.preguntaId,
    required this.seccionId,
    required this.codigo,
    required this.enunciado,
    required this.detalle,
    required this.enlaceImg,
    required this.enlaceImgOffline,
    required this.tipoId,
    required this.estado,
    required this.fecRegistro,
    required this.usrRegistro,
    required this.fecModific,
    required this.ursModific,
    required this.orden,
    required this.titulolista,
    required this.opciones,
  });

  Pregunta.fromJson(Map<String, dynamic> json) {
    preguntaId = int.parse(json['preguntaId'].toString());
    seccionId = int.parse(json['seccionId'].toString());
    codigo = json['codigo'].toString();
    enunciado = json['enunciado'].toString();
    detalle = json['detalle'].toString();
    enlaceImg = json['enlaceImg'].toString();
    enlaceImgOffline = json['enlaceImgOffline'].toString();
    tipoId = int.parse(json['tipoId'].toString());
    estado = json['estado'].toString() == 'true';
    fecRegistro = json['fecRegistro'].toString();
    usrRegistro = json['usrRegistro'].toString();
    fecModific = json['fecModific'].toString();
    ursModific = json['ursModific'].toString();
    orden = int.parse(json['orden'].toString());
    titulolista = json['titulolista'] == null ? null : json['titulolista'].toString();
    if (json['opciones'] != null) {
      opciones = [];
      json['opciones'].forEach((v) {
        opciones!.add(Opciones.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['preguntaId'] = preguntaId;
    data['seccionId'] = seccionId;
    data['codigo'] = codigo;
    data['enunciado'] = enunciado;
    data['detalle'] = detalle;
    data['enlaceImg'] = enlaceImg;
    data['enlaceImgOffline'] = enlaceImgOffline;
    data['tipoId'] = tipoId;
    data['estado'] = estado;
    data['fecRegistro'] = fecRegistro;
    data['usrRegistro'] = usrRegistro;
    data['fecModific'] = fecModific;
    data['ursModific'] = ursModific;
    data['orden'] = orden;
    data['titulolista'] = titulolista;
    if (opciones != null) {
      data['opciones'] = opciones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Opciones {
  int? alternativaId;
  String? nombre;
  String? valor;

  Opciones({this.alternativaId, this.nombre, this.valor});

  Opciones.fromJson(Map<String, dynamic> json) {
    alternativaId = int.parse(json['alternativaId'].toString());
    nombre = json['nombre'].toString();
    valor = json['valor'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alternativaId'] = alternativaId;
    data['nombre'] = nombre;
    data['valor'] = valor;
    return data;
  }
}

class Seccion {
  int? seccionId;
  String? codigo;
  String? nombre;
  String? descripcion;
  int? orden;
  bool? estado;

  Seccion({
    this.seccionId,
    this.codigo,
    this.nombre,
    this.descripcion,
    this.orden,
    this.estado,
  });

  Seccion.fromJson(Map<String, dynamic> json) {
    seccionId = int.parse(json['seccionId'].toString());
    codigo = json['codigo'].toString();
    nombre = json['nombre'].toString();
    descripcion = json['descripcion'].toString();
    orden = int.parse(json['orden'].toString());
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['seccionId'] = seccionId;
    data['codigo'] = codigo;
    data['nombre'] = nombre;
    data['descripcion'] = descripcion;
    data['orden'] = orden;
    data['estado'] = estado;
    return data;
  }
}

class Contacto {
  late int contactoId;
  late String nombre;
  late int tipo;
  late String detalle;
  late String enlaceImg;
  late String enlaceCont;
  late bool estado;

  Contacto({
    required this.contactoId,
    required this.nombre,
    required this.tipo,
    required this.detalle,
    required this.enlaceImg,
    required this.enlaceCont,
    required this.estado,
  });

  Contacto.fromJson(Map<String, dynamic> json) {
    contactoId = int.parse(json['contactoId'].toString());
    nombre = json['nombre'].toString();
    tipo = int.parse(json['tipo'].toString());
    detalle = json['detalle'].toString();
    enlaceImg = json['enlaceImg'].toString();
    enlaceCont = json['enlaceCont'].toString();
    estado = json['estado'].toString() == 'true';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['contactoId'] = contactoId;
    data['nombre'] = nombre;
    data['tipo'] = tipo;
    data['detalle'] = detalle;
    data['enlaceImg'] = enlaceImg;
    data['enlaceCont'] = enlaceCont;
    data['estado'] = estado;
    return data;
  }
}

class CanalAtencion {
  late int canalId;
  late String nombreCanal;
  late String detalleCanal;
  late String enlaceImg;
  late String enlaceCanAte;

  CanalAtencion({
    required this.canalId,
    required this.nombreCanal,
    required this.detalleCanal,
    required this.enlaceImg,
    required this.enlaceCanAte,
  });

  CanalAtencion.fromJson(Map<String, dynamic> json) {
    canalId = int.parse(json['canalId'].toString());
    nombreCanal = json['nombreCanal'].toString();
    detalleCanal = json['detalleCanal'].toString();
    enlaceImg = json['enlaceImg'].toString();
    enlaceCanAte = json['enlaceCanAte'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['canalId'] = canalId;
    data['nombreCanal'] = nombreCanal;
    data['detalleCanal'] = detalleCanal;
    data['enlaceImg'] = enlaceImg;
    data['enlaceCanAte'] = enlaceCanAte;
    return data;
  }
}

class ConsultaSisfoh {
  late int idPersona;
  late int coHogar;
  late String coUbigeo;
  late String inCseNivpobreza;
  late String inDocNacimiento;
  late String deGenero;
  late int codSisfoh;
  late String descripcion;

  ConsultaSisfoh({
    required this.idPersona,
    required this.coHogar,
    required this.coUbigeo,
    required this.inCseNivpobreza,
    required this.inDocNacimiento,
    required this.deGenero,
    required this.codSisfoh,
    required this.descripcion,
  });

  ConsultaSisfoh.fromJson(Map<String, dynamic> json) {
    idPersona = int.parse(json['idPersona'].toString());
    coHogar = int.parse(json['coHogar'].toString());
    coUbigeo = json['coUbigeo'].toString();
    inCseNivpobreza = json['inCseNivpobreza'].toString();
    inDocNacimiento = json['inDocNacimiento'].toString();
    deGenero = json['deGenero'].toString();
    codSisfoh = int.parse(json['codSisfoh'].toString());
    descripcion = json['descripcion'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idPersona'] = idPersona;
    data['coHogar'] = coHogar;
    data['coUbigeo'] = coUbigeo;
    data['inCseNivpobreza'] = inCseNivpobreza;
    data['inDocNacimiento'] = inDocNacimiento;
    data['deGenero'] = deGenero;
    data['codSisfoh'] = codSisfoh;
    data['descripcion'] = descripcion;
    return data;
  }
}

class DataCombo {
  int? generalId;
  String? nombre;

  DataCombo({this.generalId, this.nombre});

  DataCombo.fromJson(Map<String, dynamic> json) {
    generalId = int.parse(json['generalId'].toString());
    nombre = json['nombre'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['generalId'] = generalId;
    data['nombre'] = nombre;
    return data;
  }
}

class Parametros {
  int? modalidadId;
  List<FuncionPregunta>? funcionPregunta;

  Parametros({this.modalidadId, this.funcionPregunta});

  Parametros.fromJson(Map<String, dynamic> json) {
    modalidadId = json['modalidadId'] as int?;
    if (json['funcion_pregunta'] != null) {
      funcionPregunta = <FuncionPregunta>[];
      json['funcion_pregunta'].forEach((v) {
        funcionPregunta!.add(FuncionPregunta.fromJson(v as Map<String, dynamic> ));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['modalidadId'] = modalidadId;
    if (funcionPregunta != null) {
      data['funcion_pregunta'] =
          funcionPregunta!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FuncionPregunta {
  String? tipo;
  String? nombre;
  List<String>? parametro;
  String? operador;

  FuncionPregunta({this.tipo, this.nombre, this.parametro, this.operador});

  FuncionPregunta.fromJson(Map<String, dynamic> json) {
    tipo = json['tipo'] as String?;
    nombre = json['nombre'] as String ?;
    if (json['parametro'] != null) {
      parametro = <String>[];
      json['parametro'].forEach((v) {
        parametro!.add(v as String);
      });
    }
    operador = json['operador'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tipo'] = tipo;
    data['nombre'] = nombre;
    data['parametro'] = parametro;
    data['operador'] = operador;
    return data;
  }
}

class ParametrosFiltro {
  int? filtroId;
  String? tipo;
  String? objeto;
  String? titulo;
  List<OpcionesFiltro>? opciones;
  int? orden;

  ParametrosFiltro(
      {this.filtroId,
      this.tipo,
      this.objeto,
      this.titulo,
      this.opciones,
      this.orden,
      });

  ParametrosFiltro.fromJson(Map<String, dynamic> json) {
    filtroId = json['filtro_id'] as int?;
    tipo = json['tipo'] as String?;
    objeto = json['objeto'] as String?;
    titulo = json['titulo'] as String?;
    if (json['opciones'] != null) {
      opciones = <OpcionesFiltro>[];
      json['opciones'].forEach((v) {
        opciones!.add( OpcionesFiltro.fromJson(v as Map<String, dynamic> ));
      });
    }
    orden = json['orden'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filtro_id'] = filtroId;
    data['tipo'] = tipo;
    data['objeto'] = objeto;
    data['titulo'] = titulo;
    if (opciones != null) {
      data['opciones'] = opciones!.map((v) => v.toJson()).toList();
    }
    data['orden'] = orden;
    return data;
  }
}

class OpcionesFiltro {
  int? filtroContenidoId;
  String? opciones;
  int? orden;

  OpcionesFiltro({this.filtroContenidoId, this.opciones, this.orden});

  OpcionesFiltro.fromJson(Map<String, dynamic> json) {
    filtroContenidoId = json['filtro_contenido_id'] as int?;
    opciones = json['opciones'] as String?;
    orden = json['orden'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filtro_contenido_id'] = filtroContenidoId;
    data['opciones'] = opciones;
    data['orden'] = orden;
    return data;
  }
}

class BecasOtrosPaises {
  int? iBopId;
  String? vTituloBop;
  String? vDescripcionTituloBop;
  bool? bPadreBop;
  int? iBopIdPadre;
  String? vNombreBop;
  String? vDescripcionNombreBop;
  String? vCodigo;
  String? vEnlaceBop;
  String? vEnlaceInformacionBop;
  String? vEnlaceLogoBop;
  String? vEnlaceLogoBopOffline;
  String? vFechaPostulacion;
  String? dFechaPostulacion;
  List<BecasOtrosPaisesHijos>? becasOtrosPaisesHijos;

  BecasOtrosPaises(
      {this.iBopId,
      this.vTituloBop,
      this.vDescripcionTituloBop,
      this.bPadreBop,
      this.iBopIdPadre,
      this.vNombreBop,
      this.vDescripcionNombreBop,
      this.vCodigo,
      this.vEnlaceBop,
      this.vEnlaceInformacionBop,
      this.vEnlaceLogoBop,
      this.vEnlaceLogoBopOffline,
      this.vFechaPostulacion,
      this.dFechaPostulacion,
      this.becasOtrosPaisesHijos,
      });

  BecasOtrosPaises.fromJson(Map<String, dynamic> json) {
    iBopId = json['i_bop_id'] as int?;
    vTituloBop = json['v_titulo_bop'] as String?;
    vDescripcionTituloBop = json['v_descripcion_titulo_bop'] as String?;
    bPadreBop = json['b_padre_bop'] as bool?;
    iBopIdPadre = json['i_bop_id_padre'] as int?;
    vNombreBop = json['v_nombre_bop'] as String?;
    vDescripcionNombreBop = json['v_descripcion_nombre_bop'] as String?;
    vCodigo = json['v_codigo'] as String?;
    vEnlaceBop = json['v_enlace_bop'] as String?;
    vEnlaceInformacionBop = json['v_enlace_informacion_bop'] as String?;
    vEnlaceLogoBop = json['v_enlace_logo_bop'] as String?;
    vEnlaceLogoBopOffline = json['v_enlace_logo_bop_offline'] as String?;
    vFechaPostulacion = json['v_fecha_postulacion'] as String?;
    dFechaPostulacion = json['d_fecha_postulacion'] as String?;
    if (json['becasOtrosPaisesHijos'] != null) {
      becasOtrosPaisesHijos = <BecasOtrosPaisesHijos>[];
      json['becasOtrosPaisesHijos'].forEach((v) {
        becasOtrosPaisesHijos!.add(BecasOtrosPaisesHijos.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_bop_id'] = iBopId;
    data['v_titulo_bop'] = vTituloBop;
    data['v_descripcion_titulo_bop'] = vDescripcionTituloBop;
    data['b_padre_bop'] = bPadreBop;
    data['i_bop_id_padre'] = iBopIdPadre;
    data['v_nombre_bop'] = vNombreBop;
    data['v_descripcion_nombre_bop'] = vDescripcionNombreBop;
    data['v_codigo'] = vCodigo;
    data['v_enlace_bop'] = vEnlaceBop;
    data['v_enlace_informacion_bop'] = vEnlaceInformacionBop;
    data['v_enlace_logo_bop'] = vEnlaceLogoBop;
    data['v_enlace_logo_bop_offline'] = vEnlaceLogoBopOffline;
    data['v_fecha_postulacion'] = vFechaPostulacion;
    data['d_fecha_postulacion'] = dFechaPostulacion;
    if (becasOtrosPaisesHijos != null) {
      data['becasOtrosPaisesHijos'] = becasOtrosPaisesHijos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BecasOtrosPaisesHijos {
  int? iBopId;
  String? vTituloBop;
  String? vDescripcionTituloBop;
  bool? bPadreBop;
  int? iBopIdPadre;
  String? vNombreBop;
  String? vDescripcionNombreBop;
  String? vCodigo;
  String? vEnlaceBop;
  String? vEnlaceInformacionBop;
  String? vEnlaceLogoBop;
  String? vEnlaceLogoBopOffline;
  String? vFechaPostulacion;
  String? dFechaPostulacion;
  List<BecasOtrosPaisesHijos>? becasOtrosPaisesHijos;

  BecasOtrosPaisesHijos(
      {this.iBopId,
      this.vTituloBop,
      this.vDescripcionTituloBop,
      this.bPadreBop,
      this.iBopIdPadre,
      this.vNombreBop,
      this.vDescripcionNombreBop,
      this.vCodigo,
      this.vEnlaceBop,
      this.vEnlaceInformacionBop,
      this.vEnlaceLogoBop,
      this.vEnlaceLogoBopOffline,
      this.vFechaPostulacion,
      this.dFechaPostulacion,
      this.becasOtrosPaisesHijos,
      });

  BecasOtrosPaisesHijos.fromJson(Map<String, dynamic> json) {
    iBopId = json['i_bop_id'] as int?;
    vTituloBop = json['v_titulo_bop'] as String?;
    vDescripcionTituloBop = json['v_descripcion_titulo_bop'] as String?; 
    bPadreBop = json['b_padre_bop'] as bool?;
    iBopIdPadre = json['i_bop_id_padre'] as int?;
    vNombreBop = json['v_nombre_bop'] as String?;
    vDescripcionNombreBop = json['v_descripcion_nombre_bop'] as String?;
    vCodigo = json['v_codigo'] as String?; 
    vEnlaceBop = json['v_enlace_bop'] as String?;
    vEnlaceInformacionBop = json['v_enlace_informacion_bop'] as String?;
    vEnlaceLogoBop = json['v_enlace_logo_bop'] as String?;
    vEnlaceLogoBopOffline = json['v_enlace_logo_bop_offline'] as String?;
    vFechaPostulacion = json['v_fecha_postulacion'] as String?;
    dFechaPostulacion = json['d_fecha_postulacion'] as String?;
    becasOtrosPaisesHijos = json['becasOtrosPaisesHijos'] as List<BecasOtrosPaisesHijos>?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_bop_id'] = iBopId;
    data['v_titulo_bop'] = vTituloBop;
    data['v_descripcion_titulo_bop'] = vDescripcionTituloBop;
    data['b_padre_bop'] = bPadreBop;
    data['i_bop_id_padre'] = iBopIdPadre;
    data['v_nombre_bop'] = vNombreBop;
    data['v_descripcion_nombre_bop'] = vDescripcionNombreBop;
    data['v_codigo'] = vCodigo;
    data['v_enlace_bop'] = vEnlaceBop;
    data['v_enlace_informacion_bop'] = vEnlaceInformacionBop;
    data['v_enlace_logo_bop'] = vEnlaceLogoBop;
    data['v_enlace_logo_bop_offline'] = vEnlaceLogoBopOffline;
    data['v_fecha_postulacion'] = vFechaPostulacion;
    data['d_fecha_postulacion'] = dFechaPostulacion;
    data['becasOtrosPaisesHijos'] = becasOtrosPaisesHijos;
    return data;
  }
}

class PreguntaFrecuente {
  int iPreguntaFrecuenteId;
  int iOrden;
  String vTitulo;
  String vContenido;
  bool estado;

  PreguntaFrecuente({
    required this.iPreguntaFrecuenteId,
    required this.iOrden,
    required this.vTitulo,
    required this.vContenido,
    required this.estado,
  });

  factory PreguntaFrecuente.fromJson(Map<String, dynamic> json) {
    return PreguntaFrecuente(
      iPreguntaFrecuenteId: json['i_pregunta_frecuente_id'] as int,
      iOrden: json['i_orden'] as int,
      vTitulo: json['v_titulo'] as String,
      vContenido: json['v_contenido'] as String,
      estado: json['estado'] as bool,
    );
  }
}


class EnlaceRelacionado {
  int iEnlaceRelacionadoId;
  int iOrden;
  String vNombre;
  String vEnlace;
  String vEnlaceImagen;
  String vEnlaceImagenOffline;
  bool estado;

  EnlaceRelacionado({
    required this.iEnlaceRelacionadoId,
    required this.iOrden,
    required this.vNombre,
    required this.vEnlace,
    required this.vEnlaceImagen,
    required this.vEnlaceImagenOffline,
    required this.estado,
  });

  factory EnlaceRelacionado.fromJson(Map<String, dynamic> json) {
    return EnlaceRelacionado(
      iEnlaceRelacionadoId: json['i_enlace_relacionado_id'] as int,
      iOrden: json['i_orden'] as int,
      vNombre: json['v_nombre'] as String,
      vEnlace: json['v_enlace_relacionado'] as String,
      vEnlaceImagen: json['v_enlace_imagen'] as String,
      vEnlaceImagenOffline: json['v_enlace_imagen_offline'] as String,
      estado: json['estado'] as bool,
    );
  }
}
