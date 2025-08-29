// ignore_for_file: lines_longer_than_80_chars

part of 'enlace_relacionado_bloc.dart';

abstract class EnlaceRelacionadoState extends Equatable {
  const EnlaceRelacionadoState();
}

class EnlaceRelacionadoInitialState extends EnlaceRelacionadoState {
  @override
  List<Object> get props => [];
}


class EnlaceRelacionadoLoadLocalCompleteState extends EnlaceRelacionadoState {
  const EnlaceRelacionadoLoadLocalCompleteState(this.listEnlaceRelacionadoo);

  final List<EnlaceRelacionadoEntity> listEnlaceRelacionadoo;

  @override
  List<Object> get props => [listEnlaceRelacionadoo];
}
