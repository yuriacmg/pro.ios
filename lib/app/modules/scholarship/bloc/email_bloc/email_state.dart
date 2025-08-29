part of 'email_bloc.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailInitialState extends EmailState {
  const EmailInitialState();

  @override
  List<Object> get props => [];
}

class EmailLoadingState extends EmailState {
  const EmailLoadingState();

  @override
  List<Object> get props => [];
}

class EmailSendCompleteState extends EmailState {
  const EmailSendCompleteState(this.response);

  final EmailResponseModel response;

  @override
  List<Object> get props => [response];
}

class ErrorEmailState extends EmailState {
  const ErrorEmailState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
