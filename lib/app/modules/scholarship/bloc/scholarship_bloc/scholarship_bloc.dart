// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member, cascade_invocations

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/database/map_model_to_entity.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/apoderado_entity.dart';
import 'package:perubeca/app/database/entities/consulta_siage_entity.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/reniec_performance_entity.dart';
import 'package:perubeca/app/database/entities/reniec_send_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_no_data_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_minor_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_performance_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_response_model2.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';

part 'scholarship_event.dart';
part 'scholarship_state.dart';

class ScholarshipBloc extends Bloc<ScholarshipEvent, ScholarshipState> {
  ScholarshipBloc() : super(const ScholarshipInitialState()) {
    on<ScholarshipEvent>((event, emit) async {
      //on<GetMovieDataEvent>(_getMovieDataEvent);
    });
  }
  // void addPage() => emit(ScholarshipChangePageState(pageIndex: 1));

  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> getUserReniec() async {
    final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    final sendReniec = boxSendReniec.values.first;
    final send = ReniecSendModel(
      vNroDocumento: sendReniec.vNroDocumento,
      vNombres:  sendReniec.vNombres,
      vApellidoPaterno: sendReniec.vApellidoPaterno,
      vApellidoMaterno: sendReniec.vApellidoMaterno,
      dFechaNacimiento: sendReniec.dFechaNacimiento,
      vCodigoVerificacion: sendReniec.vCodigoVerificacion,
      vUbigeo: sendReniec.vUbigeo,
      vNroCelular: sendReniec.vNroCelular,
      bDeclaracionInformacion: sendReniec.bDeclaracionInformacion,
      bTerminosCondiciones: sendReniec.bTerminosCondiciones,
    );
    emit(const ScholarshipLoadingState());
    final response = await scholarshipRepository.searchUserReniec(send);
    if (response.status) {
      final model = response.data as ReniecResponseModel2;
      //guardar en base de datos
      final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');

      await reniecDatabox.clear();
      await reniecDatabox.add(
        DataReniecEntity(
          apellidoMaterno: model.value!.apellidoMaterno,
          apellidoPaterno: model.value!.apellidoPaterno,
          fechaNacimiento: model.value!.fechaNacimiento,
          nombres: model.value!.nombres,
          nombreCompleto: '${model.value!.nombres!} ${model.value!.apellidoPaterno!} ${model.value!.apellidoMaterno!}',
          sexo: model.value!.sexo,
          numDocumento: model.value!.numDocumento,
          numCelular: model.value!.numCelular,
        ),
      );

      //guardar respuestas
      final respuestaBox = await Hive.openBox<RespuestaEntity>('respuestaBox');
      await respuestaBox.clear();
      if (model.value!.respuesta != null) {
        final listRespuestaEntity = MapModelToEntity().listRespuesta(model.value!.respuesta!);
        await respuestaBox.addAll(listRespuestaEntity);
      }

      emit(ScholarshipLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: error, isSpecial:  true));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> getUserReniecIsMinor(ReniecSendModel send) async {
    final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    await boxSendReniec.clear();
    await boxSendReniec.add(
      ReniecSendEntity(
        vNroDocumento: send.vNroDocumento,
        dFechaNacimiento: send.dFechaNacimiento,
        vCodigoVerificacion: send.vCodigoVerificacion,
        vUbigeo: send.vUbigeo,
        vNroCelular: send.vNroCelular,
        bDeclaracionInformacion: send.bDeclaracionInformacion,
        bTerminosCondiciones: send.bTerminosCondiciones,
        vNombres: send.vNombres,
        vApellidoPaterno: send.vApellidoPaterno,
        vApellidoMaterno: send.vApellidoMaterno,
      ),
    );

    emit(const ScholarshipLoadingState());
    final response = await scholarshipRepository.searchUserReniecIsMinor(send);
    if (response.status) {
      final model = response.data as ReniecMinorResponseModel;
      if (model.value!.esMenor!) {
        //cargamos la informacion de los apoderados
        final boxApoderado = await Hive.openBox<ApoderadoEntity>('boxApoderado');

        final list = <ApoderadoEntity>[];
        for (final apo in model.value!.apoderados!) {
          list.add(ApoderadoEntity(name: apo.nombre, respuesta: model.value!.respuesta));
        }

        await boxApoderado.clear();
        await boxApoderado.addAll(list);

        emit(ScholarshipMinorLoadCompleteState(model));
      } else {
        await getUserReniecPerformance(send);
      }
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: error, isSpecial: true));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> getForeignSearch(ForeignSendModel send) async {
    emit(const ScholarshipLoadingState());
    final response = await scholarshipRepository.foreignSearch(send);
    if (response.status) {
      final model = response.data as ForeignResponseModel;

      final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
      //final person = parseStringFullName(send.vNombreCompleto!);
      final nombres = send.vNombres!.split(' ');
      // final apellidos = send.vApellidos!.split(' ');
      await reniecDatabox.clear();
      await reniecDatabox.add(
        DataReniecEntity(
          apellidoMaterno: send.vApellidoMaterno,
          apellidoPaterno: send.vApellidoPaterno,
          fechaNacimiento: '',
          nombres: nombres[0],
          nombreCompleto: '${model.value!.nombres!} ${model.value!.apellidoPaterno!} ${model.value!.apellidoMaterno!}',
          sexo: '',
          numDocumento: send.vNroDocumento,
        ),
      );

      if (model.hasSucceeded!) {
        final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
        final sendReniec = boxSendReniec.values.first;
        final send2 = ForeignProcessSendModel();
        send2.extranjero = true;
        send2.nroDocumento = send.vNroDocumento;
        send2.pais = send.vPais;
        send2.nombres = send.vNombres;
        send2.apePaterno = send.vApellidoPaterno;
        send2.apeMaterno = send.vApellidoMaterno;
        send2.respuestas = [];
        send2.nroCelular = send.numCelular;
        send2.bDeclaracionInformacion = send.bDeclaracionInformacion;
        send2.bTerminosCondiciones = send.bTerminosCondiciones;
        send2.dFechaNacimiento = sendReniec.dFechaNacimiento;
        send2.vUbigeo = sendReniec.vUbigeo;
        send2.vCodigoVerificacion = sendReniec.vCodigoVerificacion;
        await sendForeignProcess(send2);
      }
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: error));
    }
  }

  Future<void> sendForeignProcess(ForeignProcessSendModel send) async {
    final response = await scholarshipRepository.foreignProcess(send);
    if (response.status) {
      final model = response.data as ForeignProcessResponseModel;
      final respuestaProcesadBox = await Hive.openBox<RespuestaProcesadaEntity>('respuestaProcesadaBox');
      final respuestaProcesaNoDataBox = await Hive.openBox<RespuestaProcesadaNoDataEntity>('respuestaProcesadaNoDataBox');
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
        //final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
        final historybox = await Hive.openBox<HistoryEntity>('historyBox');
        final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
        final sendDate = dateFormat.format(DateTime.now());
        await historybox.add(
          HistoryEntity(
            send: jsonEncode(send.toJson()), //tipo RespuestaProcesadaSendModel
            dateSend: sendDate,
            response: jsonEncode(model.toJson()), //tipo RespuestaProcesadaResponseModel
            fullname: '${send.nombres} ${send.apePaterno} ${send.apeMaterno}',
            names: send.nombres!.split(' ').first,
            lastName: send.apePaterno,
            numDocument: send.nroDocumento,
            isForeign: true,
          ),
        );
      }

      emit(ScholarshipForeignLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: error, isSpecial: true));
    }
  }

  Future<void> getUserReniecIsMinorTutorValid() async {
    final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    final sendReniec = boxSendReniec.values.first;
    final send = ReniecSendModel(
      vNroDocumento: sendReniec.vNroDocumento,
      dFechaNacimiento: sendReniec.dFechaNacimiento,
      vCodigoVerificacion: sendReniec.vCodigoVerificacion,
      vUbigeo: sendReniec.vUbigeo,
      bDeclaracionInformacion: sendReniec.bDeclaracionInformacion,
      bTerminosCondiciones: sendReniec.bTerminosCondiciones,
      vApellidoMaterno: sendReniec.vApellidoMaterno,
      vApellidoPaterno: sendReniec.vApellidoPaterno,
      vNombres: sendReniec.vNombres,
    );

    emit(const ScholarshipLoadingState());
    await getUserReniecPerformance(send);
  }

  Future<void> getUserReniecPerformance(ReniecSendModel send) async {
    // emit(const ReniecReviewLoadingState());
    final response = await scholarshipRepository.searchUserReniecPerformance(send);
    if (response.status) {
      final model = response.data as ReniecPerformanceResponseModel;
      //guardar en base de datos
      final reniecPerformancebox = await Hive.openBox<ReniecPerformanceEntity>('dataReniecPerformanceBox');

      await reniecPerformancebox.clear();
      await reniecPerformancebox.add(
        ReniecPerformanceEntity(
          apeMaterno: model.value!.apeMaterno, 
          apePaterno: model.value!.apePaterno, 
          fecNacimiento: model.value!.fecNacimiento, 
          nombre: model.value!.nombre, 
          nombreCompleto: model.value!.nombreCompleto,
          sexo: model.value!.sexo,
          numdoc: model.value!.numdoc,
          resultadoSiagie: model.value!.resultadoSiagie,
          rptaSiagieBool: model.value!.rptaSiagieBool,
          notara: model.value!.notara,
        ),
      );
      //listado de informacion en array
      final siagebox = await Hive.openBox<ConsultaSiageEntity>('siageBox');
      final list = <ConsultaSiageEntity>[];
      for (final s in model.value!.consultaSiagie!) {
        list.add(
          ConsultaSiageEntity(
            condicion: s.condicion,
            grado: s.grado,
          ),
        );
      }
      await siagebox.clear();
      await siagebox.addAll(list);

      emit(ReniecPerformanceLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

 Future<void>  setLocalUserReniec(ReniecSendModel send, String name, String lastName, String lastName2 ) async{
  final boxSendReniec = await Hive.openBox<ReniecSendEntity>('boxSendReniec');
    await boxSendReniec.clear();
    await boxSendReniec.add(
      ReniecSendEntity(
        vNroDocumento: send.vNroDocumento,
        vNombres:  send.vNombres,
        vApellidoPaterno: send.vApellidoPaterno,
        vApellidoMaterno: send.vApellidoMaterno,
        dFechaNacimiento: send.dFechaNacimiento,
        vCodigoVerificacion: send.vCodigoVerificacion,
        vUbigeo: send.vUbigeo,
        vNroCelular: send.vNroCelular,
        bDeclaracionInformacion: send.bDeclaracionInformacion,
        bTerminosCondiciones: send.bTerminosCondiciones,
      ),
    );

     final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');

      await reniecDatabox.clear();
      await reniecDatabox.add(
        DataReniecEntity(
          apellidoMaterno: lastName2,
          apellidoPaterno:lastName,
          fechaNacimiento: send.dFechaNacimiento,
          nombres: name,
          nombreCompleto: '$name $lastName $lastName2',
          sexo: '',
          numDocumento: send.vNroDocumento,
          numCelular: send.vNroCelular,
        ),
      );

      //guardar respuestas
      final respuestaBox = await Hive.openBox<RespuestaEntity>('respuestaBox');
      await respuestaBox.clear();
      emit(const ScholarshipLocalSetState());
  }

  void initialState() {
    emit(const ScholarshipInitialState());
  }
}
