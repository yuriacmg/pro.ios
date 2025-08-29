// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  CodeBloc() : super(CodeInitialState()) {
    on<CodeEvent>((event, emit) {});
    on<CodeChangeEvent>((event, emit) => codeChange(event.code));
    on<CodeCleanEvent>((event, emit) => codeClean());
  }

  void codeChange(String code) {
    if (code.length == 6) {
      emit(CodeChangeState(code));
    } else {
      emit(CodeInitialState());
    }
  }

  void codeClean() {
    emit(CodeCleanState());
  }
}
