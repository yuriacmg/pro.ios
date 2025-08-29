// ignore_for_file: lines_longer_than_80_chars

part of 'pregunta_frecuente_bloc.dart';

abstract class PreguntaFrecuenteState extends Equatable {
  const PreguntaFrecuenteState();
}

class PreguntaFrecuenteInitialState extends PreguntaFrecuenteState {
  @override
  List<Object> get props => [];
}


class PreguntaFrecuenteLoadLocalCompleteState extends PreguntaFrecuenteState {
  const PreguntaFrecuenteLoadLocalCompleteState(this.listPreguntaFrecuente);

  final List<PreguntaFrecuenteEntity> listPreguntaFrecuente;

  @override
  List<Object> get props => [listPreguntaFrecuente];
}
