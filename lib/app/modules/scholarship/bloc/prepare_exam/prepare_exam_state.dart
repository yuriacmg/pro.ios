// ignore_for_file: sort_constructors_first, must_be_immutable

part of 'prepare_exam_bloc.dart';

abstract class PrepareExamState extends Equatable {
  const PrepareExamState();
}

class PrepareExamInitialState extends PrepareExamState {
  const PrepareExamInitialState() : super();
  @override
  List<Object> get props => [];
}

class PrepareExamCompleteState extends PrepareExamState {
  List<PrepareAreaAdvanceEntity>? advances;
  List<PreparePreguntaEntity>? questions;
  int? seconds;
  PrepareExamCompleteState({
    this.advances,
    this.questions,
    this.seconds,
  });

  PrepareExamCompleteState copyWith({
    List<PrepareAreaAdvanceEntity>? advances,
    List<PreparePreguntaEntity>? questions,
    int? seconds,
  }) {
    return PrepareExamCompleteState(
      advances: advances ?? advances,
      questions: questions ?? questions,
      seconds: seconds ?? seconds,
    );
  }

  @override
  List<Object?> get props => [advances, questions];
}
