part of 'pregunta_frecuente_bloc.dart';

abstract class PreguntaFrecuenteEvent extends Equatable {
  const PreguntaFrecuenteEvent();
}

class GetPreguntaFrecuenteDataLocalEvent extends PreguntaFrecuenteEvent {
  @override
  List<Object> get props => [];
}
