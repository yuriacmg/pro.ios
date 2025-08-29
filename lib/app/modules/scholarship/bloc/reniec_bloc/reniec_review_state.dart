part of 'reniec_review_bloc.dart';

abstract class ReniecReviewState extends Equatable {
  const ReniecReviewState();

  @override
  List<Object> get props => [];
}

class ReniecReviewInitialState extends ReniecReviewState {
  const ReniecReviewInitialState();

  @override
  List<Object> get props => [];
}

class ReniecReviewLoadingState extends ReniecReviewState {
  const ReniecReviewLoadingState();

  @override
  List<Object> get props => [];
}

class ReniecReviewLoadCompleteState extends ReniecReviewState {
  const ReniecReviewLoadCompleteState(this.response);

  final ReniecReviewSignResponseModel response;

  @override
  List<Object> get props => [response];
}

class ReniecPerformanceLoadCompleteState extends ReniecReviewState {
  const ReniecPerformanceLoadCompleteState(this.response);

  final ReniecPerformanceResponseModel response;

  @override
  List<Object> get props => [response];
}

class ReniecPrepareExamLoadCompleteState extends ReniecReviewState {
  const ReniecPrepareExamLoadCompleteState(); //this.response

  // final ReniecPrepareExamResponseModel response;

  @override
  List<Object> get props => []; // response
}

class ErrorState extends ReniecReviewState {
  const ErrorState({required this.error, this.isSpecial = false});

  final ErrorResponseModel error;
  final bool isSpecial;

  @override
  List<Object> get props => [];
}
