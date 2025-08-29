// ignore_for_file: lines_longer_than_80_chars, cascade_invocations

import 'dart:convert';
import 'dart:isolate';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/database/map_model_to_entity.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/version_response_model2.dart';
import 'package:perubeca/app/common/repository/local_json/i_local_data_json_repository.dart';
import 'package:perubeca/app/common/static_data_constants.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/database/entities/canal_atencion_entity.dart';
import 'package:perubeca/app/database/entities/combo_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_hijo_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/database/entities/version_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/new_scholarship_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/prepare_examen_init_data_response_model3.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/utils/constans.dart';

class MethodInitial {
  final scholarshiprepository = getItApp.get<IScholarshipRepository>();

  Future<APIResponseModel> loadDataLocalInital(VersionResponseModel2 version) async {
    final versionbox = await Hive.openBox<VersionEntity>('versionBox');
    await versionbox.clear();

    final versionModel = version.value!.registros!.first;
    await versionbox.add(
      VersionEntity(
        fechaVerApp: versionModel.fechaVerApp,
        fechaVerCont: versionModel.fechaVerApp,
        versionApp: versionModel.versionApp,
        versionCont: versionModel.versionCont,
        versionAppIOS: versionModel.versionAppIOS,
      ),
    );

     await versionbox.close();
     final response = await scholarshiprepository.getScholarship();
     if(response.status){
       await loadDataLocalInitalSave( response.data as NewScholarshipResponseModel);
     }

     return response;
  }


  Future<void> loadDataJsonLocal() async{
    try {
      final contenidoJson =  await getDataJson(StaticDataConstants().pathGetContenidoApp);
      final contedidoModel = NewScholarshipResponseModel.fromJson(json.decode(contenidoJson) as Map<String, dynamic>);
      await loadDataLocalInitalSave(contedidoModel);

      final prepareJson = await getDataJson(StaticDataConstants().pathGetPreparateApp2);
      final prepareModel = PrepareExamInitDataResponseModel3.fromJson(json.decode(prepareJson) as Map<String, dynamic>);
      await loadDataLocalInitalPrepareExamLocal(prepareModel);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDataJson(String path) async {
    final localRepository = getItApp.get<ILocalDataJsonRepository>();
    var data = '';

    if(InitFlavorConfig.appFlavor == Flavor.DEV) {
     data = await localRepository.getDataJsonDev(path);
    }
    if(InitFlavorConfig.appFlavor == Flavor.STG){
      data = await  localRepository.getDataJsonStg(path);
    }
    if(InitFlavorConfig.appFlavor == Flavor.PROD){
      data = await  localRepository.getDataJsonProd(path);
    }

    return data;
  }

  Future<void> loadDataLocalInitalSave( NewScholarshipResponseModel data) async {
    // cargando data de registro de becas
    //guardado de modalidad
    await MapModelToEntity().saveModalidad(data.value.modalidad);

    //guardado pregunta
    await MapModelToEntity().savePregunta(data.value.pregunta);

    //guardado parametros
    await MapModelToEntity().saveParamater(data.value.parametros!);

    //guardado parametros filtro
    await MapModelToEntity().saveParamaterFilter(data.value.parametrosFiltro!);

    //guardado de seccion
    final seccionBox = await Hive.openBox<SeccionEntity>('seccionBox');
    final listSeccionEntity = MapModelToEntity().listSeccion(data.value.seccion);
    await seccionBox.clear();
    await seccionBox.addAll(listSeccionEntity);

    //guardado de canal
    final canalbox = await Hive.openBox<CanalAtencionEntity>('canalBox');
    final listCanalEntity = MapModelToEntity().listCanal(data.value.canalAtencion);
    await canalbox.clear();
    await canalbox.addAll(listCanalEntity);

    //guardado de contacto
    final contactobox = await Hive.openBox<ContactoEntity>('contactBox');
    final listContactoEntity = MapModelToEntity().listContacto(data.value.contacto);
    await contactobox.clear();
    await contactobox.addAll(listContactoEntity);

    // guardado de paises ipo tramite
    final combobox = await Hive.openBox<ComboEntity>('comboBox');
    final listComboEntity = MapModelToEntity().listCombo(data.value.pais, data.value.tipoTramite);

    //guardado de becas otros paises
    await MapModelToEntity().saveBecaOtrosPaises(data.value.becasOtrosPaises ?? []);

    //guardado de preguntas frecuentes
    await MapModelToEntity().savePreguntaFrecuente(data.value.preguntaFrecuente ?? []);

    //guardado de enlace relacionado
    await MapModelToEntity().saveEnlaceRelacionado(data.value.enlaceRelacionado ?? []);

    await combobox.clear();
    await combobox.addAll(listComboEntity);
    await canalbox.close();
    await seccionBox.close();
    await contactobox.close();
    await combobox.close();
  }
   
  void callIsolate() {
    //final receivePort = ReceivePort();
    //final params = IsoletParrams(flavor: InitFlavorConfig.flavorApp, sendPort: receivePort.sendPort);
    //Isolate.spawn(loadDataLocalInitalPrepareExam , params );
    //FlutterIsolate.spawn(loadDataLocalInitalPrepareExam, receivePort.sendPort);
  }
 
}

class IsoletParrams {
  IsoletParrams({required this.sendPort, required this.flavor});
  SendPort sendPort;
  Flavor flavor;
}


Future<void> loadDataLocalInitalPrepareExam() async {
  //InitFlavorConfig.appFlavor  = params.flavor;
  final scholarshiprepository = getItApp.get<IScholarshipRepository>();
  //cargando data init prepare
  final response = await scholarshiprepository.getDataInitPrepareExam2();
  if (response.status) {
    final model = response.data as PrepareExamInitDataResponseModel3;
    //guardar en base de datos
    await loadPrepare(model);
    await loadPrepare2(model);
  }

  //port.send('Result finished');
  //Future.delayed(const Duration(seconds: 1), () {
  //  params.sendPort.send('Result 3');
  //});
}

Future<void> loadDataLocalInitalPrepareExamLocal(PrepareExamInitDataResponseModel3 model) async {
    //guardar en base de datos
    await loadPrepare(model);
    await loadPrepare2(model);
}

Future<void> loadPrepare(PrepareExamInitDataResponseModel3 model) async {
  final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
  // final prepareAreaInterestbox = await Hive.openBox<PrepareAreaInterestEntity>('prepareAreaInterestBox');
  final preparePreguntabox = await Hive.openBox<PreparePreguntaEntity>('preparePreguntaBox');
  final prepareAlternativebox = await Hive.openBox<PrepareAlternativeEntity>('prepareAlternativeBox');
  // listado de informacion en array
  final listQuestion = <PreparePreguntaEntity>[];
  final listalternative = <PrepareAlternativeEntity>[];
  final listCommon = <PrepareAreaCommonEntity>[];
  // final listInterest = <PrepareAreaInterestEntity>[];

  for (final s in model.value!.preparate!) {
    for (final c in s.contenido!) {
      //area
      listCommon.add(
        PrepareAreaCommonEntity(
          codigo: c.codigo,
          enlaceLogo: c.enlaceLogo,
          nombre: c.nombre,
          orden: c.orden,
          nroPregunta: c.nroPregunta,
          status: ConstantsApp.areaInitial,
          codigoPreparate: c.codigoPreparate,
          enlaceLogoOffline: c.enlaceLogoOffline,
        ),
      );
      //question
      for (final q in c.preguntas!) {
        //questions
        listQuestion.add(
          PreparePreguntaEntity(
            preguntaId: q.preguntaId,
            pregunta: q.pregunta,
            comentarios: q.comentarios,
            enlaceImagen: q.enlaceImagen,
            orden: q.orden,
            respuesta: q.respuesta,
            codigoCourse: c.codigoPreparate,
            simulacroId: c.codigo,
            tipo: q.tipo,
            preguntaPadreId: q.preguntaPadreId,
            area: q.area,
            comentarioOffline: q.comentarioOffline,
            enlaceImagenOffline: q.enlaceImagenOffline,
            preguntaOffline: q.preguntaOffline,
          ),
        );

        if (q.alternativas != null) {
          //alternative
          for (final a in q.alternativas!) {
            listalternative.add(
              PrepareAlternativeEntity(
                alternativa: a.alternativa,
                alternativaId: a.alternativaId,
                codigo: a.codigo,
                enlaceImagen: a.enlaceImagen,
                preguntaId: a.preguntaId,
                type: a.type,
                typeAlternativa: a.typeAlternativa,
                alternativaOffline: a.alternativaOffline,
                enlaceImagenOffline: a.enlaceImagenOffline,
                typeAlternativaOffline: a.typeAlternativaOffline,
              ),
            );
          }
        }
      }
    }
  }

  //common
  await prepareAreaCommonbox.clear();
  await prepareAreaCommonbox.addAll(listCommon);

  //question
  await preparePreguntabox.clear();
  await preparePreguntabox.addAll(listQuestion);
  //alternative
  await prepareAlternativebox.clear();
  await prepareAlternativebox.addAll(listalternative);
}

Future<void> loadPrepare2(PrepareExamInitDataResponseModel3 model) async {
  final prepareAreabox =
      await Hive.openBox<PrepareAreaEntity>('prepareAreaBox');
  final prepareAreaHijobox =
      await Hive.openBox<PrepareAreaHijoEntity>('prepareAreaHijoBox');
  // listado de informacion en array
  final list = <PrepareAreaEntity>[];
  final listHijos = <PrepareAreaHijoEntity>[];
  for (final s in model.value!.preparate2!) {
    list.add(
      PrepareAreaEntity(
        codigo: s.codigo,
        enlaceLogo: s.enlaceLogo,
        nombre: s.nombre,
        orden: s.orden,
        enlaceLogoOffline: s.enlaceLogoOffline,
      ),
    );

    for (final h in s.preparateHijos!) {
      listHijos.add(
        PrepareAreaHijoEntity(
          codigo: h.codigo,
          codigoPadre: s.codigo,
          enlaceLogo: h.enlaceLogo,
          nombre: h.nombre,
          orden: h.orden,
          enlaceLogoOffline: h.enlaceLogoOffline,
        ),
      );
    }
  }
  await prepareAreabox.clear();
  await prepareAreabox.addAll(list);

  await prepareAreaHijobox.clear();
  await prepareAreaHijobox.addAll(listHijos);
}
