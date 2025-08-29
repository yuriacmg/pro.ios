// ignore_for_file: lines_longer_than_80_chars, await_only_futures
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/common/static_data_constants.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_entity.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_hijo_entity.dart';
import 'package:perubeca/app/database/entities/canal_atencion_entity.dart';
import 'package:perubeca/app/database/entities/combo_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/database/entities/enlace_relacionado_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_documento_clave_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/palabras_clave_entity.dart';
import 'package:perubeca/app/database/entities/parametro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';
import 'package:perubeca/app/database/entities/parametro_funcion_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_frecuente_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/new_scholarship_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_response_model2.dart';

class MapModelToEntity {
  Future<void> saveBecaOtrosPaises(List<BecasOtrosPaises> list) async {
    final becaOtroPaisBox =
        await Hive.openBox<BecaOtroPaisEntity>('becaOtroPaisBox');
    await becaOtroPaisBox.clear();

    final becaOtroPaisHijoBox =
        await Hive.openBox<BecaOtroPaisHijoEntity>('becaOtroPaisHijoBox');
    await becaOtroPaisHijoBox.clear();

    for (final beca in list) {
      final hijos = <BecaOtroPaisHijoEntity>[];

      final entity = BecaOtroPaisEntity(
        iBopId: beca.iBopId,
        bPadreBop: beca.bPadreBop,
        dFechaPostulacion: beca.dFechaPostulacion,
        iBopIdPadre: beca.iBopIdPadre,
        vCodigo: beca.vCodigo,
        vDescripcionNombreBop: beca.vDescripcionNombreBop,
        vDescripcionTituloBop: beca.vDescripcionTituloBop,
        vEnlaceBop: beca.vEnlaceBop,
        vEnlaceInformacionBop: beca.vEnlaceInformacionBop,
        vEnlaceLogoBop: beca.vEnlaceLogoBop,
        vEnlaceLogoBopOffline: beca.vEnlaceLogoBopOffline,
        vFechaPostulacion: beca.vFechaPostulacion,
        vNombreBop: beca.vNombreBop,
        vTituloBop: beca.vTituloBop,
      );

      for (final hijo in beca.becasOtrosPaisesHijos!) {
        hijos.add(
          BecaOtroPaisHijoEntity(
            iBopId: hijo.iBopId,
            bPadreBop: hijo.bPadreBop,
            dFechaPostulacion: hijo.dFechaPostulacion,
            iBopIdPadre: hijo.iBopIdPadre,
            vCodigo: hijo.vCodigo,
            vDescripcionNombreBop: hijo.vDescripcionNombreBop,
            vDescripcionTituloBop: hijo.vDescripcionTituloBop,
            vEnlaceBop: hijo.vEnlaceBop,
            vEnlaceInformacionBop: hijo.vEnlaceInformacionBop,
            vEnlaceLogoBop: hijo.vEnlaceLogoBop,
            vEnlaceLogoBopOffline: hijo.vEnlaceLogoBopOffline,
            vFechaPostulacion: hijo.vFechaPostulacion,
            vNombreBop: hijo.vNombreBop,
            vTituloBop: hijo.vTituloBop,
          ),
        );
      }

      //guardando los registros
      await becaOtroPaisBox.add(entity);
      await becaOtroPaisHijoBox.addAll(hijos);
    }

    await becaOtroPaisBox.close();
    await becaOtroPaisHijoBox.close();
  }

  Future<void> saveEnlaceRelacionado(List<EnlaceRelacionado> list) async {
    final enlaceRelacionadoBox =
        await Hive.openBox<EnlaceRelacionadoEntity>('enlaceRelacionadoBox');
    await enlaceRelacionadoBox.clear();

    for (final enlace in list) {
      final entity = EnlaceRelacionadoEntity(
        estado: enlace.estado,
        iEnlaceRelacionadoId: enlace.iEnlaceRelacionadoId,
        iOrden: enlace.iOrden,
        vEnlace: enlace.vEnlace,
        vEnlaceImagen: enlace.vEnlaceImagen,
        vEnlaceImagenOffline: enlace.vEnlaceImagenOffline,
        vNombre: enlace.vNombre,
      );

      //guardando los registros
      await enlaceRelacionadoBox.add(entity);
    }

    await enlaceRelacionadoBox.close();
  }

  Future<void> savePreguntaFrecuente(List<PreguntaFrecuente> list) async {
    final preguntaFrecuenteBox =
        await Hive.openBox<PreguntaFrecuenteEntity>('preguntaFrecuenteBox');
    await preguntaFrecuenteBox.clear();

    for (final enlace in list) {
      final entity = PreguntaFrecuenteEntity(
        estado: enlace.estado,
        iOrden: enlace.iOrden,
        iPreguntaFrecuenteId: enlace.iPreguntaFrecuenteId,
        vContenido: enlace.vContenido,
        vTitulo: enlace.vTitulo,
      );

      //guardando los registros
      await preguntaFrecuenteBox.add(entity);
    }

    await preguntaFrecuenteBox.close();
  }

  Future<void> saveModalidad(List<Modalidad> list) async {
    final modalidadBox = await Hive.openBox<ModalidadEntity>('modalidadBox');
    final requisitoBox =
        await Hive.openBox<ModalidadRequisitoEntity>('requisitoBox');
    final beneficioBox =
        await Hive.openBox<ModalidadBeneficioEntity>('beneficioBox');
    final impedimentoBox =
        await Hive.openBox<ModalidadImpedimentoEntity>('impedimentoBox');
    final palabrasBox = await Hive.openBox<PalabraClaveEntity>('palabrasBox');
    final documentoClaveBox =
        await Hive.openBox<ModalidadDocumentoClaveEntity>('documentoClaveBox');

    // limpiar cajas
    await modalidadBox.clear();
    await requisitoBox.clear();
    await beneficioBox.clear();
    await impedimentoBox.clear();
    await palabrasBox.clear();
    await documentoClaveBox.clear();

    // listas acumuladas
    final allModalidades = <ModalidadEntity>[];
    final allRequisitos = <ModalidadRequisitoEntity>[];
    final allBeneficios = <ModalidadBeneficioEntity>[];
    final allImpedimentos = <ModalidadImpedimentoEntity>[];
    final allPalabras = <PalabraClaveEntity>[];
    final allDocumentos = <ModalidadDocumentoClaveEntity>[];

    for (final model in list) {
      // modalidad
      allModalidades.add(
        ModalidadEntity(
          modId: model.modId,
          nomCompleto: model.nomCompleto,
          nomCorto: model.nomCorto,
          codigo: model.codigo,
          enlaceMod: model.enlaceMod,
          enlaceInform: model.enlaceInform,
          enlaceLog: model.enlaceLog,
          beneficios: model.beneficios,
          impedimentos: model.impedimentos,
          vFecPostu: model.vFecPostu,
          dFecPostu: model.dFecPostu,
          publicada: model.publicada,
          estado: model.estado,
          fecRegistro: model.fecRegistro,
          usrRegistro: model.usrRegistro,
          fecModific: model.fecModific,
          ursModific: model.ursModific,
          base64: model.base64,
          enlaceLogOffline: model.enlaceLogOffline,
          estadoConDiscapacidad: model.estadoConDiscapacidad,
          colorDegradadoFin: model.colorDegradadoFin,
          colorDegradadoInicio: model.colorDegradadoInicio,
          grupo: model.grupo,
          grupoColorDegradadoFin: model.grupoColorDegradadoFin,
          grupoColorDegradadoInicio: model.grupoColorDegradadoInicio,
          grupoEnlaceLogoGrupo: model.grupoEnlaceLogoGrupo,
          grupoEnlaceLogoGrupoOffline: model.grupoEnlaceLogoGrupoOffline
        ),
      );

      // requisitos
      for (final r in model.modalidadRequisito) {
        allRequisitos.add(
          ModalidadRequisitoEntity(
            modRequisId: r.modRequisId,
            requisId: r.requisId,
            modId: r.modId,
            descripc: r.descripc,
            enlaceImg: r.enlaceImg,
            orden: r.orden,
            estado: r.estado,
            fecRegistro: r.fecRegistro,
            usrRegistro: r.usrRegistro,
            fecModific: r.fecModific,
            ursModific: r.ursModific,
          ),
        );
      }

      // beneficios
      for (final r in model.modalidadBeneficio) {
        allBeneficios.add(
          ModalidadBeneficioEntity(
            modBeneficiotId: r.modBeneficioId,
            beneficioId: r.beneficioId,
            modId: r.modId,
            descripc: r.descripc,
            enlaceImg: r.enlaceImg,
            orden: r.orden,
            estado: r.estado,
          ),
        );
      }

      // impedimentos
      for (final r in model.modalidadImpedimento) {
        allImpedimentos.add(
          ModalidadImpedimentoEntity(
            modImpedId: r.modImpedId,
            impedId: r.impedId,
            modId: r.modId,
            descripc: r.descripc,
            enlaceImg: r.enlaceImg,
            orden: r.orden,
            estado: r.estado,
          ),
        );
      }

      // palabras clave (con null safety)
      for (final p in (model.palabrasClave ?? []) as List<PalabrasClave>) {
        allPalabras.add(
          PalabraClaveEntity(
            filtroContenidoId: p.filtroContenidoId,
            modId: model.modId,
          ),
        );
      }

      // documentos clave
      for (final r in model.modalidadDocumentoClave) {
        allDocumentos.add(
          ModalidadDocumentoClaveEntity(
            modDocClaveId: r.modDocClaveId,
            modId: r.modId,
            descripc: r.descripc,
            orden: r.orden,
            estado: r.estado,
          ),
        );
      }
    }

    // guardar en lote
    await modalidadBox.addAll(allModalidades);
    await requisitoBox.addAll(allRequisitos);
    await beneficioBox.addAll(allBeneficios);
    await impedimentoBox.addAll(allImpedimentos);
    await palabrasBox.addAll(allPalabras);
    await documentoClaveBox.addAll(allDocumentos);

    // cerrar todas las cajas
    await modalidadBox.close();
    await requisitoBox.close();
    await beneficioBox.close();
    await impedimentoBox.close();
    await palabrasBox.close();
    await documentoClaveBox.close();
  }

  Future<void> savePregunta(List<Pregunta> list) async {
    final preguntabox = await Hive.openBox<PreguntaEntity>('preguntaBox');
    await preguntabox.clear();
    final preguntaOpcionesBox =
        await Hive.openBox<PreguntaOpcionesEntity>('opcionBox');
    await preguntaOpcionesBox.clear();
    for (final model in list) {
      final listOpciones = <PreguntaOpcionesEntity>[];

      final entity = PreguntaEntity(
        preguntaId: model.preguntaId,
        seccionId: model.seccionId,
        codigo: model.codigo,
        enunciado: model.enunciado,
        detalle: model.detalle,
        enlaceImg: model.enlaceImg,
        enlaceImgOffline: model.enlaceImgOffline,
        tipoId: model.tipoId,
        estado: model.estado,
        fecRegistro: model.fecRegistro,
        usrRegistro: model.usrRegistro,
        fecModific: model.fecModific,
        ursModific: model.ursModific,
        orden: model.orden,
        titulolista: model.titulolista,
      );

      for (final r in model.opciones!) {
        listOpciones.add(
          PreguntaOpcionesEntity(
            alternativaId: r.alternativaId,
            nombre: r.nombre,
            preguntaId: model.preguntaId,
            valor: r.valor!,
          ),
        );
      }
      //guardado de preguntas y sus opciones
      await preguntabox.add(entity);
      await preguntaOpcionesBox.addAll(listOpciones);
      //entity.opciones!.addAll(listOpciones);
    }

    await preguntabox.close();
    await preguntaOpcionesBox.close();
  }

  Future<void> saveParamater(List<Parametros> list) async {
    final parametrosBox = await Hive.openBox<ParametroEntity>('parametrosBox');
    await parametrosBox.clear();

    final parametrosFunctionBox =
        await Hive.openBox<ParametroFuncionPreguntaEntity>(
            'parametrosFunctionBox');
    await parametrosFunctionBox.clear();

    for (final model in list) {
      final entity = ParametroEntity(
        modalidadId: model.modalidadId,
      );
      await parametrosBox.add(entity);

      for (final fun in model.funcionPregunta!) {
        final entityFunction = ParametroFuncionPreguntaEntity(
          modalidadId: model.modalidadId,
          nombre: fun.nombre,
          operador: fun.operador,
          parametro: fun.parametro,
          tipo: fun.tipo,
        );
        await parametrosFunctionBox.add(entityFunction);
      }
    }

    await parametrosBox.close();
    await parametrosFunctionBox.close();
  }

  Future<void> saveParamaterFilter(List<ParametrosFiltro> list) async {
    final parametrosBox =
        await Hive.openBox<ParametroFiltroEntity>('parametrosFiltroBox');
    await parametrosBox.clear();

    final parametrosFiltroOpcionBox =
        await Hive.openBox<ParametroFiltroOpcionesEntity>(
            'parametrosFiltroOpcionBox');
    await parametrosFiltroOpcionBox.clear();

    for (final model in list) {
      final parameterEntity = ParametroFiltroEntity(
        filtroId: model.filtroId,
        objeto: model.objeto,
        orden: model.orden,
        tipo: model.tipo,
        titulo: model.titulo,
      );
      await parametrosBox.add(parameterEntity);

      final listOptions = <ParametroFiltroOpcionesEntity>[];
      for (final filter in model.opciones!) {
        listOptions.add(
          ParametroFiltroOpcionesEntity(
            filtroId: model.filtroId,
            filtroContenidoId: filter.filtroContenidoId,
            orden: filter.orden,
            opciones: filter.opciones,
          ),
        );
      }

      await parametrosFiltroOpcionBox.addAll(listOptions);
    }

    await parametrosBox.close();
    await parametrosFiltroOpcionBox.close();
  }

  List<SeccionEntity> listSeccion(List<Seccion> list) {
    final listEntity = <SeccionEntity>[];

    for (final model in list) {
      final entity = SeccionEntity(
        seccionId: model.seccionId,
        codigo: model.codigo,
        descripcion: model.descripcion,
        estado: model.estado,
        nombre: model.nombre,
        orden: model.orden,
      );

      listEntity.add(entity);
    }

    return listEntity;
  }

  List<CanalAtencionEntity> listCanal(List<CanalAtencion> list) {
    final listEntity = <CanalAtencionEntity>[];

    for (final model in list) {
      final entity = CanalAtencionEntity(
        canalId: model.canalId,
        nombreCanal: model.nombreCanal,
        detalleCanal: model.detalleCanal,
        enlaceImg: model.enlaceImg,
        enlaceCanAte: model.enlaceCanAte,
      );

      listEntity.add(entity);
    }

    return listEntity;
  }

  List<ContactoEntity> listContacto(List<Contacto> list) {
    final listEntity = <ContactoEntity>[];

    for (final model in list) {
      final entity = ContactoEntity(
        contactoId: model.contactoId,
        nombre: model.nombre,
        tipo: model.tipo,
        detalle: model.detalle,
        enlaceImg: model.enlaceImg,
        enlaceCont: model.enlaceCont,
        estado: model.estado,
      );

      listEntity.add(entity);
    }

    return listEntity;
  }

  List<ComboEntity> listCombo(List<DataCombo> list, List<DataCombo> list2) {
    final listEntity = <ComboEntity>[];

    //paises
    for (final model in list) {
      final entity = ComboEntity(
        generalId: model.generalId,
        nombre: model.nombre,
        type: StaticDataConstants().typeCountry,
      );

      listEntity.add(entity);
    }
    //tipo tramite
    for (final model in list2) {
      final entity = ComboEntity(
        generalId: model.generalId,
        nombre: model.nombre,
        type: StaticDataConstants().typeTramite,
      );

      listEntity.add(entity);
    }

    return listEntity;
  }

  List<RespuestaEntity> listRespuesta(List<Respuesta> list) {
    final listEntity = <RespuestaEntity>[];

    for (final model in list) {
      final entity = RespuestaEntity(
        alternativaRespuesta: model.alternativaRespuesta,
        preguntaId: model.preguntaId,
        respuestaAutomatica: model.respuestaAutomatica,
        texto: model.texto,
        rptIcono: model.rptaIcono,
      );

      listEntity.add(entity);
    }

    return listEntity;
  }
}
