// ignore_for_file: avoid_unused_constructor_parameters, sort_constructors_first, lines_longer_than_80_chars, inference_failure_on_untyped_parameter, avoid_dynamic_calls

class ScholarshipResponseModel {
  Value? value;
  bool? hasSucceeded;

  ScholarshipResponseModel({value, hasSucceeded});

  ScholarshipResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Modalidad>? modalidad;
  List<Modalidadrequisito>? modalidadrequisito;

  Value({modalidad, modalidadrequisito});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['modalidad'] != null) {
      modalidad = <Modalidad>[];
      json['modalidad'].forEach((v) {
        modalidad!.add(Modalidad.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['modalidadrequisito'] != null) {
      modalidadrequisito = <Modalidadrequisito>[];
      json['modalidadrequisito'].forEach((v) {
        modalidadrequisito!.add(Modalidadrequisito.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (modalidad != null) {
      data['modalidad'] = modalidad!.map((v) => v.toJson()).toList();
    }
    if (modalidadrequisito != null) {
      data['modalidadrequisito'] = modalidadrequisito!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modalidad {
  int? iMODALIDADID;
  String? vNOMBRECOMPLETO;
  String? vNOMBRECORTO;
  String? vCODIGO;
  String? vENLACEMODALIDAD;
  String? vENLACEINFORMACION;
  String? vENLACELOGO;
  String? vBENEFICIOS;
  String? vIMPEDIMENTOS;
  String? vFECHAPOSTULACION;
  DateTime? dFECHAPOSTULACION;
  bool? bPUBLICADA;
  bool? bESTADO;
  DateTime? dFECREGISTRO;
  String? vUSRREGISTRO;
  DateTime? dFECMODIFICACION;
  String? vUSRMODIFICACION;

  Modalidad({
    iMODALIDADID,
    vNOMBRECOMPLETO,
    vNOMBRECORTO,
    vCODIGO,
    vENLACEMODALIDAD,
    vENLACEINFORMACION,
    vENLACELOGO,
    vBENEFICIOS,
    vIMPEDIMENTOS,
    vFECHAPOSTULACION,
    dFECHAPOSTULACION,
    bPUBLICADA,
    bESTADO,
    dFECREGISTRO,
    vUSRREGISTRO,
    dFECMODIFICACION,
    vUSRMODIFICACION,
  });

  Modalidad.fromJson(Map<String, dynamic> json) {
    iMODALIDADID = int.parse(json['i_MODALIDAD_ID'].toString());
    vNOMBRECOMPLETO = json['v_NOMBRE_COMPLETO'].toString();
    vNOMBRECORTO = json['v_NOMBRE_CORTO'].toString();
    vCODIGO = json['v_CODIGO'].toString();
    vENLACEMODALIDAD = json['v_ENLACE_MODALIDAD'].toString();
    vENLACEINFORMACION = json['v_ENLACE_INFORMACION'].toString();
    vENLACELOGO = json['v_ENLACE_LOGO'].toString();
    vBENEFICIOS = json['v_BENEFICIOS'].toString();
    vIMPEDIMENTOS = json['v_IMPEDIMENTOS'].toString();
    vFECHAPOSTULACION = json['v_FECHA_POSTULACION'].toString();
    dFECHAPOSTULACION = DateTime.parse(json['d_FECHA_POSTULACION'].toString());
    bPUBLICADA = json['b_PUBLICADA'].toString() == 'true';
    bESTADO = json['b_ESTADO'].toString() == 'true';
    dFECREGISTRO = DateTime.parse(json['d_FEC_REGISTRO'].toString());
    vUSRREGISTRO = json['v_USR_REGISTRO'].toString();
    dFECMODIFICACION = json['d_FEC_MODIFICACION'] == null ? null : DateTime.parse(json['d_FEC_MODIFICACION'].toString());
    vUSRMODIFICACION = json['v_USR_MODIFICACION'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_MODALIDAD_ID'] = iMODALIDADID;
    data['v_NOMBRE_COMPLETO'] = vNOMBRECOMPLETO;
    data['v_NOMBRE_CORTO'] = vNOMBRECORTO;
    data['v_CODIGO'] = vCODIGO;
    data['v_ENLACE_MODALIDAD'] = vENLACEMODALIDAD;
    data['v_ENLACE_INFORMACION'] = vENLACEINFORMACION;
    data['v_ENLACE_LOGO'] = vENLACELOGO;
    data['v_BENEFICIOS'] = vBENEFICIOS;
    data['v_IMPEDIMENTOS'] = vIMPEDIMENTOS;
    data['v_FECHA_POSTULACION'] = vFECHAPOSTULACION;
    data['d_FECHA_POSTULACION'] = dFECHAPOSTULACION;
    data['b_PUBLICADA'] = bPUBLICADA;
    data['b_ESTADO'] = bESTADO;
    data['d_FEC_REGISTRO'] = dFECREGISTRO;
    data['v_USR_REGISTRO'] = vUSRREGISTRO;
    data['d_FEC_MODIFICACION'] = dFECMODIFICACION;
    data['v_USR_MODIFICACION'] = vUSRMODIFICACION;
    return data;
  }
}

class Modalidadrequisito {
  int? iMODREQUISITOID;
  int? iREQUISITOID;
  int? iMODALIDADID;
  String? vDESCRIPCION;
  String? vENLACEIMAGEN;
  int? iORDEN;
  bool? bESTADO;
  DateTime? dFECREGISTRO;
  String? vUSRREGISTRO;
  DateTime? dFECMODIFICACION;
  String? vUSRMODIFICACION;

  Modalidadrequisito({
    iMODREQUISITOID,
    iREQUISITOID,
    iMODALIDADID,
    vDESCRIPCION,
    vENLACEIMAGEN,
    iORDEN,
    bESTADO,
    dFECREGISTRO,
    vUSRREGISTRO,
    dFECMODIFICACION,
    vUSRMODIFICACION,
  });

  Modalidadrequisito.fromJson(Map<String, dynamic> json) {
    iMODREQUISITOID = int.parse(json['i_MOD_REQUISITO_ID'].toString());
    iREQUISITOID = int.parse(json['i_REQUISITO_ID'].toString());
    iMODALIDADID = int.parse(json['i_MODALIDAD_ID'].toString());
    vDESCRIPCION = json['v_DESCRIPCION'].toString();
    vENLACEIMAGEN = json['v_ENLACE_IMAGEN'].toString();
    iORDEN = int.parse(json['i_ORDEN'].toString());
    bESTADO = json['b_ESTADO'].toString() == 'true';
    dFECREGISTRO = DateTime.parse(json['d_FEC_REGISTRO'].toString());
    vUSRREGISTRO = json['v_USR_REGISTRO'].toString();
    dFECMODIFICACION = json['d_FEC_MODIFICACION'] == null ? null : DateTime.parse(json['d_FEC_MODIFICACION'].toString());
    vUSRMODIFICACION = json['v_USR_MODIFICACION'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['i_MOD_REQUISITO_ID'] = iMODREQUISITOID;
    data['i_REQUISITO_ID'] = iREQUISITOID;
    data['i_MODALIDAD_ID'] = iMODALIDADID;
    data['v_DESCRIPCION'] = vDESCRIPCION;
    data['v_ENLACE_IMAGEN'] = vENLACEIMAGEN;
    data['i_ORDEN'] = iORDEN;
    data['b_ESTADO'] = bESTADO;
    data['d_FEC_REGISTRO'] = dFECREGISTRO;
    data['v_USR_REGISTRO'] = vUSRREGISTRO;
    data['d_FEC_MODIFICACION'] = dFECMODIFICACION;
    data['v_USR_MODIFICACION'] = vUSRMODIFICACION;
    return data;
  }
}
