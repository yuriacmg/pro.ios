// ignore_for_file: must_be_immutable, avoid_positional_boolean_parameters

part of 'scholarship_bloc.dart';

abstract class ScholarshipState extends Equatable {
  const ScholarshipState();
}

class ScholarshipInitialState extends ScholarshipState {
  const ScholarshipInitialState();

  @override
  List<Object> get props => [];
}

class ScholarshipLoadingState extends ScholarshipState {
  const ScholarshipLoadingState();

  @override
  List<Object> get props => [];
}

class ScholarshipLoadCompleteState extends ScholarshipState {
  const ScholarshipLoadCompleteState(this.response);

  final ReniecResponseModel2 response;

  @override
  List<Object> get props => [response];
}

class ScholarshipMinorLoadCompleteState extends ScholarshipState {
  const ScholarshipMinorLoadCompleteState(this.response);

  final ReniecMinorResponseModel response;

  @override
  List<Object> get props => [response];
}

class ScholarshipForeignLoadCompleteState extends ScholarshipState {
  const ScholarshipForeignLoadCompleteState(this.response);

  final ForeignProcessResponseModel response;

  @override
  List<Object> get props => [response];
}

class ScholarshipMinorValidLoadCompleteState extends ScholarshipState {
  const ScholarshipMinorValidLoadCompleteState(this.response);

  final ReniecMinorResponseModel response;

  @override
  List<Object> get props => [response];
}

class ReniecPerformanceLoadCompleteState extends ScholarshipState {
  const ReniecPerformanceLoadCompleteState(this.response);

  final ReniecPerformanceResponseModel response;

  @override
  List<Object> get props => [response];
}

class ScholarshipChangePageState extends ScholarshipState {
  ScholarshipChangePageState({
    required this.pageIndex,
  });

  int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}

class ScholarshipLocalSetState extends ScholarshipState {
  const ScholarshipLocalSetState();

  @override
  List<Object> get props => [];
}


class ErrorState extends ScholarshipState {
  const ErrorState({required this.error, this.isSpecial = false});

  final ErrorResponseModel error;
  final bool isSpecial;

  @override
  List<Object> get props => [];
}
