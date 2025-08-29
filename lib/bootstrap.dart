// ignore_for_file: cascade_invocations, lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/app.dart';
//import 'package:perubeca/app/common/provider/push_notification_provider.dart';
import 'package:perubeca/app/config/Dependecy_injection.dart';
import 'package:perubeca/app/database/entities/apoderado_entity.dart';
import 'package:perubeca/app/database/entities/app_general_entity.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_entity.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_hijo_entity.dart';
import 'package:perubeca/app/database/entities/canal_atencion_entity.dart';
import 'package:perubeca/app/database/entities/combo_entity.dart';
import 'package:perubeca/app/database/entities/consulta_siage_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/data_reniec_review_sign_entity.dart';
import 'package:perubeca/app/database/entities/enlace_relacionado_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_documento_clave_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';
import 'package:perubeca/app/database/entities/palabras_clave_entity.dart';
import 'package:perubeca/app/database/entities/parametro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';
import 'package:perubeca/app/database/entities/parametro_funcion_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_frecuente_entity.dart';
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

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  FirebaseOptions options,
) async {

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      HttpOverrides.global = MyHttpOverrides();

      DependencyInjection().setup(getItApp);

      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(options: options);



      await Hive.initFlutter();

      Hive.registerAdapter(CanalAtencionEntityAdapter());
      Hive.registerAdapter(ContactoEntityAdapter());
      Hive.registerAdapter(DataReniecEntityAdapter());
      Hive.registerAdapter(DataReniecReviewSignEntityAdapter());
      Hive.registerAdapter(ModalidadEntityAdapter());
      Hive.registerAdapter(ModalidadRequisitoEntityAdapter());
      Hive.registerAdapter(ModalidadDocumentoClaveEntityAdapter());
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
      //search
      Hive.registerAdapter(PalabraClaveEntityAdapter());
      Hive.registerAdapter(ParametroFiltroEntityAdapter());
      Hive.registerAdapter(ParametroFiltroOpcionesEntityAdapter());
      //otro paises
      Hive.registerAdapter(BecaOtroPaisEntityAdapter());
      Hive.registerAdapter(BecaOtroPaisHijoEntityAdapter());

      Hive.registerAdapter(PreguntaFrecuenteEntityAdapter());
      Hive.registerAdapter(EnlaceRelacionadoEntityAdapter());

      Hive.registerAdapter(NotificationEntityAdapter());


      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      //para el isolate
      //initializeIsolateCommunication();

      //notification
      //final pushProvider = PushNotificationProvider();
      //await pushProvider.initNotifications();
      // pushProvider.initAwesomeNotification();
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };


      runApp(await builder());

    },
    (error, stackTrace) {

      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
