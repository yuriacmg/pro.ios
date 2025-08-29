// ignore_for_file: invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars, cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/download_file_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/report_response_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/utils/methods.dart';

part 'download_file_event.dart';
part 'download_file_state.dart';

class DownloadFileBloc extends Bloc<DownloadFileEvent, DownloadFileState> {
  DownloadFileBloc() : super(const DownloadFileInitialState()) {
    on<DownloadFileEvent>((event, emit) {
      //
    });
  }
  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> downloadFile(ModalidadEntity mod, int consultaId) async {
    emit(const DownloadFileLoadingState());
    final sendFile = DownloadFileSendModel(id: mod.modId, nroDocumento: mod.beneficios, nroConsultaCiudadana: consultaId );
    final response = await scholarshipRepository.downloadFile(sendFile);
    if (response.status) {
      final model = response.data as FileResponseModel;
      //descargando archivo de base 64
      model.value!.path = await createPdf(model.value!.base64!, '${mod.nomCorto!}.pdf');
      emit(DownloadFileCompleteState(model));
    } else {
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> downloadFileBase64(ModalidadEntity mod) async {
    emit(const DownloadFileLoadingState());
      final model = FileResponseModel(
        hasSucceeded: true,
        value: ValueResponseFile(
          base64: '',
          nombrearchivo: '',
        ),
      );
      //descargando archivo de base 64
      model.value!.path = await createPdf(mod.base64!, '${mod.nomCorto!}.pdf');
      emit(DownloadFileCompleteState(model));
  }

  Future<void> downloadFileWb(ModalidadEntity mod, int consultaId) async {
    emit(const DownloadFileLoadingState());
    final sendFile = DownloadFileSendModel(id: mod.modId, nroDocumento: mod.beneficios, nroConsultaCiudadana: consultaId);
    final response = await scholarshipRepository.downloadFile(sendFile);
    if (response.status) {
      final model = response.data as FileResponseModel;
      //descargando archivo de base 64
      await downloadFileWeb(model.value!.base64!, '${mod.nomCorto!}.pdf');
      emit(DownloadFileCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> downloadFileSolution(int codeCourse) async {
    emit(const DownloadFileLoadingState());
    final response = await scholarshipRepository.downloadFileSolution(codeCourse);
    if (response.status) {
      final model = response.data as FileResponseModel;
      //descargando archivo de base 64
      model.value!.path = await createPdf(model.value!.base64!, '${model.value!.nombrearchivo}.pdf');
      emit(DownloadFileCompleteState(model));
    } else {
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> downloadFileSolutionOffline(int codeCourse, String courseName) async {
    emit(const DownloadFileLoadingState());

    try {
      final valuefile = ValueResponseFile(nombrearchivo: '', base64: '');
      final model = FileResponseModel(hasSucceeded: true, value: valuefile);

      model.value!.path = await createPdfLocal(codeCourse, courseName);
      emit(DownloadFileCompleteState(model));
    } catch (e) {
      emit(
        ErrorState(
          error: ErrorResponseModel(
            hasSucceeded: false,
            value: [ValueError(errorCode: 404, message: 'El área de $courseName no cuenta con un solucionario')],
            statusCode: 404,
          ),
        ),
      );
    }

    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> downloadFileWbSolution(int codeCourse) async {
    emit(const DownloadFileLoadingState());
    final response = await scholarshipRepository.downloadFileSolution(codeCourse);
    if (response.status) {
      final model = response.data as FileResponseModel;
      //descargando archivo de base 64
      await downloadFileWeb(model.value!.base64!, '${model.value!.nombrearchivo}.pdf');
      emit(DownloadFileCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

Future<void> downloadFileWbBase64(ModalidadEntity mod) async {
    emit(const DownloadFileLoadingState());
      final model = FileResponseModel(
        hasSucceeded: true,
        value: ValueResponseFile(
          base64: '',
          nombrearchivo: '',
        ),
      ); 
      //descargando archivo de base 64
      await downloadFileWeb(mod.base64!, '${mod.nomCorto!}.pdf');
      emit(DownloadFileCompleteState(model)); 
  }

  Future<void> downloadNewFileBase64(ModalidadEntity mod) async {
    emit(const DownloadFileLoadingState());
      final model = FileResponseModel(
        hasSucceeded: true,
        value: ValueResponseFile(
          base64: '',
          nombrearchivo: '',
        ),
      );       
      //descargando archivo de base 64
      model.value!.path = await createPdf(mod.base64!, '${mod.nomCorto!}.pdf');
      emit(DownloadFileCompleteState(model));
  }

  void initialState() {
    emit(const DownloadFileInitialState());
  }
}
