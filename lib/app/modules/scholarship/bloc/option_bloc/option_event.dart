// ignore_for_file: sort_constructors_first, must_be_immutable

part of 'option_bloc.dart';

abstract class OptionEvent extends Equatable {
  const OptionEvent();

  @override
  List<Object> get props => [];
}

class InitDataEvent extends OptionEvent {
  final List<SeccionEntity> sections;
  final List<PreguntaEntity> questions;
  final List<PreguntaOpcionesEntity> options;
  final List<RespuestaEntity> respuestas;
  final List<RespuestaProcesada> respuestasProcesadas;
  final List<DataMemory> respuestaEnWidget;
  final DataReniecEntity user;
  final List<int?> sectionsId;

  const InitDataEvent({
    required this.sections,
    required this.questions,
    required this.options,
    required this.respuestas,
    required this.respuestasProcesadas,
    required this.respuestaEnWidget,
    required this.user,
    required this.sectionsId,
  });
}

class SetRespuestaEnWidgetEvent extends OptionEvent {
  DataMemory respuesta;
  SetRespuestaEnWidgetEvent({
    required this.respuesta,
  });
}

class DeleteRespuestaEnWidgetEvent extends OptionEvent {}

class AddRespuestaProcesada extends OptionEvent {
  RespuestaProcesada respuesta;
  AddRespuestaProcesada({required this.respuesta});
}

class RemoveRespuestaProcesada extends OptionEvent {
  RespuestaProcesada respuesta;
  RemoveRespuestaProcesada({required this.respuesta});
}
