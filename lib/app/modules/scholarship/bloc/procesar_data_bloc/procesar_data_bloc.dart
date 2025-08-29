// ignore_for_file: invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars, cascade_invocations

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/reniec_send_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_no_data_entity.dart';
import 'package:perubeca/app/modules/history/model/history_sync_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/page/util/find_scholarship_util.dart';
// import 'package:perubeca/app/modules/scholarship/model/respuesta_procesada_response_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';

part 'procesar_data_event.dart';
part 'procesar_data_state.dart';

class ProcesarDataBloc extends Bloc<ProcesarDataEvent, ProcesarDataState> {
  ProcesarDataBloc() : super(const ProcesarDataInitialState()) {
    on<ProcesarDataEvent>((event, emit) {});
  }

  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> procesarRespuesta(ForeignProcessSendModel send) async {
    emit(const ProcesarDataLoadingState());
    final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    final sendReniec = boxSendReniec.values.first;
    send.dFechaNacimiento = sendReniec.dFechaNacimiento;
    send.vCodigoVerificacion = sendReniec.vCodigoVerificacion;
    send.vUbigeo = sendReniec.vUbigeo;

    final response = await scholarshipRepository.procesarRespuesta(send);
    if (response.status) {
      final model = response.data as ForeignProcessResponseModel;
      //guardar en base de datos
      final respuestaProcesadBox =
          await Hive.openBox<RespuestaProcesadaEntity>('respuestaProcesadaBox');
      final respuestaProcesaNoDataBox =
          await Hive.openBox<RespuestaProcesadaNoDataEntity>(
              'respuestaProcesadaNoDataBox',);
      await respuestaProcesadBox.clear();
      //si no hay modalidades
      if (model.value!.modalidadesId!.isEmpty) {
        await respuestaProcesaNoDataBox.clear();
        await respuestaProcesaNoDataBox.add(
          RespuestaProcesadaNoDataEntity(
            resultado: model.value!.resultado,
            rptaBool: model.value!.rptaBool,
          ),
        );
      }

      for (final element in model.value!.modalidadesId!) {
        await respuestaProcesadBox.add(
          RespuestaProcesadaEntity(
            modId: element,
            consultaId: model.value!.consultaId,
          ),
        );
      }

      if (model.value!.modalidadesId!.isNotEmpty) {
        //guardando informacion en historico local
        final reniecDatabox =
            await Hive.openBox<DataReniecEntity>('dataReniecBox');
        final historybox = await Hive.openBox<HistoryEntity>('historyBox');
        final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
        final sendDate = dateFormat.format(DateTime.now());
        await historybox.add(
          HistoryEntity(
            send: jsonEncode(send.toJson()), //tipo RespuestaProcesadaSendModel
            dateSend: sendDate,
            response: jsonEncode(
                model.toJson(),), //tipo RespuestaProcesadaResponseModel
            fullname: reniecDatabox.values.first.nombreCompleto,
            names: reniecDatabox.values.first.nombres,
            lastName: reniecDatabox.values.first.apellidoPaterno,
            numDocument: reniecDatabox.values.first.numDocumento,
            digitoVerificador: sendReniec.vCodigoVerificacion,
            ubigeo: sendReniec.vUbigeo,
            fechaNacimiento: sendReniec.dFechaNacimiento,
          ),
        );
      }
      emit(ProcesarDataLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel, isSpecial: true ));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> procesarRespuestaLocal(
      ForeignProcessSendModel send, String fechaNacimiento,) async {
    emit(const ProcesarDataLoadingState());
    final localRepository = getItApp.get<ILocalDataSecureDbRepository>();
    await localRepository.setIsLocal('true');
    final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    final sendReniec = boxSendReniec.values.first;

    final respuestasDataProcessLocal =
        await FindScholarshipUtil.getScholarhipProcess(send, fechaNacimiento);
    final respuestaProcesadBox =
        await Hive.openBox<RespuestaProcesadaEntity>('respuestaProcesadaBox');
    final respuestaProcesaNoDataBox =
        await Hive.openBox<RespuestaProcesadaNoDataEntity>(
            'respuestaProcesadaNoDataBox',);
    await respuestaProcesadBox.clear();

    final model = ForeignProcessResponseModel(
      hasSucceeded: true,
      value: ValueForeign(
        consultaId: 0,
        modalidadesId: respuestasDataProcessLocal.modalidadIds,
        resultado: 'procesado',
        rptaBool: true,
      ),
    );
    //si no hay modalidades
    if (respuestasDataProcessLocal.modalidadIds.isEmpty) {
      await respuestaProcesaNoDataBox.clear();
      await respuestaProcesaNoDataBox.add(
        RespuestaProcesadaNoDataEntity(
          resultado:
              "<span style='color: rgb(55, 62, 73); font-family: Open Sans; font-size: 16px;'><b>No calificas para ninguna de las Becas en curso.</b></span>",
          rptaBool: false,
        ),
      );
    }

    for (final element in respuestasDataProcessLocal.modalidadIds) {
      await respuestaProcesadBox.add(
        RespuestaProcesadaEntity(
          modId: element,
          consultaId: 0,
        ),
      );
    }

    if (respuestasDataProcessLocal.modalidadIds.isNotEmpty) {
      //guardando informacion en historico local
      final reniecDatabox =
          await Hive.openBox<DataReniecEntity>('dataReniecBox');
      final historybox = await Hive.openBox<HistoryEntity>('historyBox');
      final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
      final sendDate = dateFormat.format(DateTime.now());
      //armando el

      final fichas = respuestasDataProcessLocal.modalidadIds.map((mId) {
        final details = respuestasDataProcessLocal.listParameters
            .where((element) => element.modalidadId == mId)
            .map(
              (e) => DetalleSync(
                nombre: e.nombre,
                operador: e.operador,
                parametro: e.parametro,
                tipo: e.tipo,
                valorRespuesta: e.valorRespuesta,
              ),
            )
            .toList();
        return FichaTecnicaSync(
          idModalidad: mId,
          detalle: details,
        );
      });

      final detaillistaJson = fichas.map((ficha) => ficha.toJson()).toList();

      await historybox.add(
        HistoryEntity(
          localId: historybox.values.length + 1,
          isLocal: true,
          send: jsonEncode(send.toJson()), //tipo RespuestaProcesadaSendModel
          dateSend: sendDate,
          response:
              jsonEncode(model.toJson()), //tipo RespuestaProcesadaResponseModel
          dataSendLocal: jsonEncode(detaillistaJson),
          fullname: reniecDatabox.values.first.nombreCompleto,
          names: reniecDatabox.values.first.nombres,
          lastName: reniecDatabox.values.first.apellidoPaterno,
          numDocument: reniecDatabox.values.first.numDocumento,
          digitoVerificador: sendReniec.vCodigoVerificacion,
          ubigeo: sendReniec.vUbigeo,
          fechaNacimiento: sendReniec.dFechaNacimiento,
        ),
      );
    }
    emit(ProcesarDataLoadCompleteState(model));
  }

  void initialState() {
    emit(const ProcesarDataInitialState());
  }
}
