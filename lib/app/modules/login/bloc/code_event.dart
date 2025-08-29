// ignore_for_file: must_be_immutable

part of 'code_bloc.dart';

abstract class CodeEvent extends Equatable {
  const CodeEvent();

  @override
  List<Object> get props => [];
}

class CodeChangeEvent extends CodeEvent {
  CodeChangeEvent(this.code);
  String code;
}

class CodeCleanEvent extends CodeEvent {
}
