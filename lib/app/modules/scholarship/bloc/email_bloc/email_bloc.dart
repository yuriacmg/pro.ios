// ignore_for_file: invalid_use_of_visible_for_testing_member, cascade_invocations, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_model.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_search_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(const EmailInitialState()) {
    on<EmailEvent>((event, emit) {
      //
    });
  }

  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> sendEmail(EmailSendModel send) async {
    emit(const EmailLoadingState());
    final response = await scholarshipRepository.sendEmailRegister(send);
    if (response.status) {
      final model = response.data as EmailResponseModel;
      emit(EmailSendCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorEmailState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> sendEmailSearch(EmailSendSearchModel send) async {
    emit(const EmailLoadingState());
    final response = await scholarshipRepository.sendEmailSearch(send);
    if (response.status) {
      final model = response.data as EmailResponseModel;
      emit(EmailSendCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorEmailState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  void initialState() {
    emit(const EmailInitialState());
  }
}
