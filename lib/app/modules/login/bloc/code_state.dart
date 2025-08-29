// ignore_for_file: must_be_immutable

part of 'code_bloc.dart';

abstract class CodeState extends Equatable {
  const CodeState();
  
  @override
  List<Object> get props => [];
}

class CodeInitialState extends CodeState {}
class CodeCleanState extends CodeState {}

class CodeChangeState extends CodeState {
  CodeChangeState(this.code);
  String code;
}
