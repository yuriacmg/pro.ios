// ignore_for_file: invalid_use_of_visible_for_testing_member, cascade_invocations, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/report_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/send_report_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/utils/methods.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(const ReportInitialState()) {
    on<ReportEvent>((event, emit) {});
  }
  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> downloadReport(SendReportModel send) async {
    emit(const ReportLoadingState());
    final response = await scholarshipRepository.downloadReport(send);
    if (response.status) {
      final model = response.data as ReportResponseModel;
      //descargando archivo de base 64
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final fileName = 'report$date.pdf';
      model.value = await createPdf(model.value!, fileName);
      //emit(const ReportInitialState());
      emit(ReportLoadCompleteState(model));
    } else {
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> downloadReportWeb(SendReportModel send) async {
    emit(const ReportLoadingState());
    final response = await scholarshipRepository.downloadReport(send);
    if (response.status) {
      final model = response.data as ReportResponseModel;
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final fileName = 'report$date.pdf';
      await downloadFileWeb(model.value!, fileName);
      emit(ReportLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  void initialState() {
    emit(const ReportInitialState());
  }
}
