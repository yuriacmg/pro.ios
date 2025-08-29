// ignore_for_file: use_if_null_to_convert_nulls_to_bools, cascade_invocations, lines_longer_than_80_chars, inference_failure_on_function_invocation, inference_failure_on_function_return_type, type_annotate_public_apis, always_declare_return_types

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/config/Dependecy_injection.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/database/entities/apoderado_entity.dart';
import 'package:perubeca/app/database/entities/app_general_entity.dart';
import 'package:perubeca/app/database/entities/canal_atencion_entity.dart';
import 'package:perubeca/app/database/entities/combo_entity.dart';
import 'package:perubeca/app/database/entities/consulta_siage_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/data_reniec_review_sign_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/parametro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_funcion_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/database/entities/prepare/area_user_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/notice_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_advance_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_hijo_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/database/entities/reniec_performance_entity.dart';
import 'package:perubeca/app/database/entities/reniec_send_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_no_data_entity.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/database/entities/version_entity.dart';
import 'package:perubeca/bootstrap.dart';

Future<void> cargandoDataInicial(GetIt getItApp, Flavor flavor) async {
  HttpOverrides.global = MyHttpOverrides();
  InitFlavorConfig.appFlavor = flavor;
  DependencyInjection().setup(getItApp);
  //WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CanalAtencionEntityAdapter());
  Hive.registerAdapter(ContactoEntityAdapter());
  Hive.registerAdapter(DataReniecEntityAdapter());
  Hive.registerAdapter(DataReniecReviewSignEntityAdapter());
  Hive.registerAdapter(ModalidadEntityAdapter());
  Hive.registerAdapter(ModalidadRequisitoEntityAdapter());
  Hive.registerAdapter(ModalidadBeneficioEntityAdapter());
  Hive.registerAdapter(ModalidadImpedimentoEntityAdapter());
  Hive.registerAdapter(SeccionEntityAdapter());
  Hive.registerAdapter(PreguntaEntityAdapter());
  Hive.registerAdapter(PreguntaOpcionesEntityAdapter());
  Hive.registerAdapter(VersionEntityAdapter());
  Hive.registerAdapter(RespuestaEntityAdapter());
  Hive.registerAdapter(RespuestaProcesadaEntityAdapter());
  Hive.registerAdapter(HistoryEntityAdapter());
  Hive.registerAdapter(ReniecPerformanceEntityAdapter());
  Hive.registerAdapter(ConsultaSiageEntityAdapter());
  Hive.registerAdapter(AppGeneralEntityAdapter());
  Hive.registerAdapter(ComboEntityAdapter());
  Hive.registerAdapter(ParametroEntityAdapter());
  Hive.registerAdapter(ParametroFuncionPreguntaEntityAdapter());
  //prepareExamn
  Hive.registerAdapter(PrepareAreaEntityAdapter());
  Hive.registerAdapter(PrepareAreaCommonEntityAdapter());
  Hive.registerAdapter(PreparePreguntaEntityAdapter());
  Hive.registerAdapter(PrepareAlternativeEntityAdapter());
  Hive.registerAdapter(RespuestaProcesadaNoDataEntityAdapter());
  Hive.registerAdapter(PrepareHistoryEntityAdapter());
  Hive.registerAdapter(PrepareAreaAdvanceEntityAdapter());
  Hive.registerAdapter(PrepareUserEntityAdapter());
  Hive.registerAdapter(AreaUserHistoryEntityAdapter());
  //notice
  Hive.registerAdapter(NoticeEntityAdapter());
  //new flowwchart find scholarship
  Hive.registerAdapter(ApoderadoEntityAdapter());
  Hive.registerAdapter(ReniecSendEntityAdapter());
  //login
  Hive.registerAdapter(ProfileEntityAdapter());
  //new
  Hive.registerAdapter(PrepareAreaHijoEntityAdapter());

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
