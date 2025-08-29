// ignore_for_file: must_be_immutable, avoid_positional_boolean_parameters

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LogOutEvent extends LoginEvent {}

class LoginInitEvent extends LoginEvent {
  LoginInitEvent(this.send);
  LoginSendModel send;
}

class RegisterAccountEvent extends LoginEvent {
  RegisterAccountEvent(this.send, this.isResend);
  RegisterAccountSendModel send;
  bool isResend;
}

class ValidAccountEvent extends LoginEvent {
  ValidAccountEvent(this.send);
  ValidAccountSendModel send;
}

class ValidAccountRecoveryEvent extends LoginEvent {
  ValidAccountRecoveryEvent(this.send);
  ValidAccountSendModel send;
}

class LoginValidStatusEvent extends LoginEvent {}

class LoginRecoveryPasswordCodeEvent extends LoginEvent {
  LoginRecoveryPasswordCodeEvent(this.send, this.isResend);
  RecoveryPasswordSendModel send;
  bool isResend;
}

class UpdatePasswordProfileEvent extends LoginEvent {
  UpdatePasswordProfileEvent(this.send);
  PasswordProfileUpdateSendModel send;
}

class UpdateProfileEvent extends LoginEvent {
  UpdateProfileEvent(this.send);
  PasswordProfileUpdateSendModel send;
}

class RecodeEmailInitEvent extends LoginEvent {
  RecodeEmailInitEvent(this.send);
  RecodeAccountEmailSendModel send;
}

class RecodeEmailEvent extends LoginEvent {
  RecodeEmailEvent(this.send, this.isResend);
  RecodeAccountEmailSendModel send;
  bool isResend;
}

class ValidCodeEmailEvent extends LoginEvent {
  ValidCodeEmailEvent(this.send);
  ValidCodeEmailSendModel send;
}
