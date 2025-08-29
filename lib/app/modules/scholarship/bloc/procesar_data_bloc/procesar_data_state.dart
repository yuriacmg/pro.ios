part of 'procesar_data_bloc.dart';

abstract class ProcesarDataState extends Equatable {
  const ProcesarDataState();

  @override
  List<Object> get props => [];
}

class ProcesarDataInitialState extends ProcesarDataState {
  const ProcesarDataInitialState();

  @override
  List<Object> get props => [];
}

class ProcesarDataLoadingState extends ProcesarDataState {
  const ProcesarDataLoadingState();

  @override
  List<Object> get props => [];
}

class ProcesarDataLoadCompleteState extends ProcesarDataState {
  const ProcesarDataLoadCompleteState(this.response);

  final ForeignProcessResponseModel response;

  @override
  List<Object> get props => [response];
}

class ErrorState extends ProcesarDataState {
  const ErrorState({required this.error, this.isSpecial = false});

  final ErrorResponseModel error;
  final bool isSpecial;

  @override
  List<Object> get props => [];
}
