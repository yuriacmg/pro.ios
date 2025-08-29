part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();
  
  @override
  List<Object> get props => [];
}

class ReportInitialState extends ReportState {
  const ReportInitialState();

  @override
  List<Object> get props => [];
}

class ReportLoadingState extends ReportState {
  const ReportLoadingState();

  @override
  List<Object> get props => [];
}

class ReportLoadCompleteState extends ReportState {
  const ReportLoadCompleteState(this.response);

  final ReportResponseModel response;

  @override
  List<Object> get props => [response];
}


class ErrorState extends ReportState {
  const ErrorState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
