// ignore_for_file: use_if_null_to_convert_nulls_to_bools, cascade_invocations, lines_longer_than_80_chars, inference_failure_on_function_invocation, inference_failure_on_function_return_type, type_annotate_public_apis, always_declare_return_types, invalid_use_of_visible_for_testing_member, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/config/Dependecy_injection.dart';
import 'package:perubeca/app/config/flavor_config.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/modules/history/model/hisrtoy_sync_response_model.dart';
import 'package:perubeca/app/modules/history/model/history_sync_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/respuesta_procesada_response_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/bootstrap.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<HistorySearchEvent>((event, emit) => search(event.searchText));
    on<HistorySyncEvent>((event, emit) => syncHistory());
  }

  final localSecureDbRepository = getItApp.get<ILocalDataSecureDbRepository>();
  final authRepository = getItApp.get<IAuthRepository>();

  Future<void> search(String searchText) async {
    emit(HistoryLoading());
    final historyBox = await Hive.openBox<HistoryEntity>('historyBox');
    var histories = historyBox.values.toList();

    if (searchText.isNotEmpty) {
      final lowercaseSearchText = searchText.toLowerCase();
      histories = histories
          .where(
            (element) =>
                element.numDocument!.contains(lowercaseSearchText) ||
                element.fullname!.toLowerCase().contains(lowercaseSearchText),
          )
          .toList();
    }

    histories = histories.reversed.toList();
    emit(HistoryLoaded(dataLocal: histories, histories: histories));
  }

  Future<void> syncHistory() async {
    final receivePort = ReceivePort();
    final authResponse = await authRepository.getTokenAutorization();
      final token = authResponse.data as String;
      await localSecureDbRepository.setAuthToken(token);

    final historyBox = await Hive.openBox<HistoryEntity>('historyBox');
    final histories = historyBox.values
        .where((element) => element.isSync == false && element.isLocal == true)
        .toList();
    final data = <String, dynamic>{
      'flavor': InitFlavorConfig.flavorApp.toString(),
      'histories': histories,
      'sendPort': receivePort.sendPort,
      'token': token,
    };

    await Isolate.spawn(startIsolate, data);
    receivePort.listen((data) {
      // Manejar mensajes recibidos del isolate
      final listSync = data['historiesSync'] as List<HistoryEntity>;
      for (final history in listSync) {
        //actualziando el history local
        history.syncErrorMessage = history.isSync! ? '': history.syncErrorMessage;
        final index = historyBox.values
            .toList()
            .indexWhere((e) => e.localId == history.localId);
        historyBox.put(index, history);
      }

    search('');
    });
  }
}

Future<void> startIsolate(Map<String, dynamic> message) async {
  //final receivePort = ReceivePort();
  final sendPort = message['sendPort'] as SendPort;

  final flavor = message['flavor'] as String;
  final histories = message['histories'] as List<HistoryEntity>;
  final token = message['token'] as String;
  final historySync = <HistoryEntity>[];

  final locator = GetIt.instance;
  final flavorConfig = flavor == 'Flavor.DEV'
      ? Flavor.DEV
      : (flavor == 'Flavor.STG' ? Flavor.STG : Flavor.PROD);

  HttpOverrides.global = MyHttpOverrides();
  InitFlavorConfig.appFlavor = flavorConfig;
  DependencyInjection().setup(locator);

  final scholarshipRepository = locator.get<IScholarshipRepository>();

  final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
  final dateFormatUTC = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

  for (final history in histories) {
    //envio de datos a sincronizar
    final send = HistorySyncSendModel();
    final person = ForeignProcessSendModel.fromJson(jsonDecode(history.send!) as Map<String, dynamic>);
    final dateTime = dateFormat.parse(history.dateSend!);
    final formattedDateTime = dateFormatUTC.format(dateTime.toUtc());

    send.nombres = person.nombres;
    send.apePaterno = person.apePaterno;
    send.apeMaterno = person.apeMaterno;
    send.consultaIdTemporal = history.localId;
    send.nroCelular = person.nroCelular;
    send.nroDocumento = person.nroDocumento;
    send.fechaNacimiento = history.fechaNacimiento;
    send.correo = '';
    send.digitoVerificador = history.digitoVerificador;
    send.fechaRegistro = formattedDateTime;
    send.ubigeo = history.ubigeo;
    send.declaracionInformacion = true;
    send.terminosCondiciones = true;

    //detailsds
    final data = jsonDecode(history.dataSendLocal!) as List;
    send.fichaTecnica = data
        .map((json) => FichaTecnicaSync.fromJson(json as Map<String, dynamic>))
        .toList();

    final result = await scholarshipRepository.syncHistory(send, token);
    try {
      final resultsync = result.data as HistorySyncResponseModel;
      var messageError = '';
      if (resultsync.value != null &&
          resultsync.value!.first.motivoError != null) {
        messageError = resultsync.value!.first.motivoError!.first.message!;
      }
      if (resultsync.value!.first.rptaBool!) {
        //history sync success
        final procesada = RespuestaProcesadaResponseModel.fromJson(
          jsonDecode(history.response!) as Map<String, dynamic>,
        );

        procesada.value!.consultaId = resultsync.value!.first.consultaId;
        history.response = jsonEncode(procesada.toJson());
        history.isSync = true;
        history.isLocal = true;
      } else {
        //los history sync error
        history.isSync = false;
        history.syncErrorMessage = messageError;
      }
    } catch (e) {
      history.isSync = false;
      history.syncErrorMessage = 'Error interno de la sincronizacion';
    }
    historySync.add(history);
  }

  sendPort.send({'historiesSync': historySync}); // Enviar el SendPort al hilo principal
}
