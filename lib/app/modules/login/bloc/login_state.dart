// ignore_for_file: must_be_immutable, avoid_positional_boolean_parameters

part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LogOutSuccessState extends LoginState {}

class RegisterAccountSuccessState extends LoginState {
  RegisterAccountSuccessState(this.send, this.isResend);
  RegisterAccountSendModel send;
  bool isResend;
}

class ValidAccountSuccessState extends LoginState {}

class ValidAccountRecoverySuccessState extends LoginState {
  ValidAccountRecoverySuccessState(this.registerId);
  int registerId;
}

class ErrorState extends LoginState {
  const ErrorState({required this.error});
  final ErrorResponseModel error;
}

class ErrorRegisterAccountState extends LoginState {
  const ErrorRegisterAccountState({required this.error});
  final ErrorResponseModel error;
}

class ErrorValidAccountState extends LoginState {
  const ErrorValidAccountState({required this.error});
  final ErrorResponseModel error;
}

class RecoveryPasswordCodeSuccessState extends LoginState {
  RecoveryPasswordCodeSuccessState(this.data, this.isResend);
  RecoveryPasswordResponseModel data;
  bool isResend;
}

class ErrorRecoveryPasswordCodeState extends LoginState {
  const ErrorRecoveryPasswordCodeState({required this.error});
  final ErrorResponseModel error;
}

class UpdatePasswordProfileSuccessState extends LoginState {}

class UpdateProfileSuccessState extends LoginState {
  UpdateProfileSuccessState(this.prefix, this.num);
  String prefix;
  String num;
}

class ErrorUpdatePasswordProfileState extends LoginState {
  const ErrorUpdatePasswordProfileState({required this.error});
  final ErrorResponseModel error;
}

class RecodeAccountEmailInitSuccessState extends LoginState {}

class RecodeAccountEmailSuccessState extends LoginState {
  RecodeAccountEmailSuccessState(this.data, this.isResend);
  RecodeAccountEmailResponseModel data;
  bool isResend;
}

class ErrorRecodeAccountEmailState extends LoginState {
  const ErrorRecodeAccountEmailState({required this.error});
  final ErrorResponseModel error;
}

class ValidCodeEmailSuccessState extends LoginState {}

class ErrorValidCodeEmailState extends LoginState {
  const ErrorValidCodeEmailState({required this.error});
  final ErrorResponseModel error;
}
