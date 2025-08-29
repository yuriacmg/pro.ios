// ignore_for_file: sort_constructors_first, must_be_immutable, lines_longer_than_80_chars, overridden_fields, annotate_overrides

part of 'option_bloc.dart';

abstract class OptionState extends Equatable {
  const OptionState();
}

class OptionInitialState extends OptionState {
  const OptionInitialState() : super();

  @override
  List<Object> get props => [];
}

class OptionCompleteState extends OptionState {
  List<SeccionEntity>? sections;
  List<PreguntaEntity>? questions;
  List<PreguntaOpcionesEntity>? options;
  List<RespuestaEntity>? respuestas;

  List<RespuestaProcesada>? respuestasProcesadas;
  List<DataMemory>? respuestaEnWidget;
  DataReniecEntity? user;

  List<int?>? sectionsId;
  OptionCompleteState({
    this.sections,
    this.questions,
    this.options,
    this.respuestas,
    this.respuestasProcesadas,
    this.respuestaEnWidget,
    this.user,
    this.sectionsId,
  });

  OptionCompleteState copyWith({
    List<SeccionEntity>? sections,
    List<PreguntaEntity>? questions,
    List<PreguntaOpcionesEntity>? options,
    List<RespuestaEntity>? respuestas,
    List<RespuestaProcesada>? respuestasProcesadas,
    List<DataMemory>? respuestaEnWidget,
    DataReniecEntity? user,
    List<int?>? sectionsId,
  }) {
    return OptionCompleteState(
      sections: sections ?? this.sections,
      questions: questions ?? this.questions,
      options: options ?? this.options,
      respuestas: respuestas ?? this.respuestas,
      respuestasProcesadas: respuestasProcesadas ?? this.respuestasProcesadas,
      respuestaEnWidget: respuestaEnWidget ?? this.respuestaEnWidget,
      user: user ?? this.user,
      sectionsId: sectionsId ?? this.sectionsId,
    );
  }

  @override
  List<Object?> get props => [
        sections,
        questions,
        options,
        respuestas,
        respuestasProcesadas,
        respuestaEnWidget,
        user,
        sectionsId,
      ];
}

class SetRespuestaEnWidgetState extends OptionState {
  List<DataMemory>? respuestaEnWidget;
  SetRespuestaEnWidgetState({
    required this.respuestaEnWidget,
  });

  @override
  List<Object> get props => [respuestaEnWidget!];
}
