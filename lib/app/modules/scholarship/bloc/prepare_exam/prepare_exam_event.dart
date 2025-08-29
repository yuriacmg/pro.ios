// ignore_for_file: sort_constructors_first, must_be_immutable, lines_longer_than_80_chars

part of 'prepare_exam_bloc.dart';

abstract class PrepareExamEvent extends Equatable {
  const PrepareExamEvent();

  @override
  List<Object> get props => [];
}

class InitDataEvent extends PrepareExamEvent {
  List<PrepareAreaAdvanceEntity> advances;
  int courseCode;
  String userDocument;
  int areaCode;
  int generalCode;
  InitDataEvent({
    required this.advances,
    required this.userDocument,
    required this.courseCode,
    required this.areaCode,
    required this.generalCode,
  });
}

class SetRespuestaEnWidgetEvent extends PrepareExamEvent {
  PrepareAreaAdvanceEntity history;
  SetRespuestaEnWidgetEvent({
    required this.history,
  });
}

class AddRespuesta extends PrepareExamEvent {
  PrepareAreaAdvanceEntity history;
  AddRespuesta({
    required this.history,
  });
}

class AddRespuestaSimulacrum extends PrepareExamEvent {
  PrepareAreaAdvanceEntity history;
  AddRespuestaSimulacrum({
    required this.history,
  });
}

class SaveHistoryArea extends PrepareExamEvent {
  SaveHistoryArea({required this.userDocument, required this.areaCode, required this.generalCode, required this.courseCode});
  String userDocument;
  int areaCode;
  int generalCode;
  int courseCode;
}
