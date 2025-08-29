part of 'bottom_sheet_bloc.dart';

abstract class BottomSheetState extends Equatable {
  const BottomSheetState();

  @override
  List<Object> get props => [];
}

class BottomSheetInitialState extends BottomSheetState {
  const BottomSheetInitialState();

  @override
  List<Object> get props => [];
}

class BottomSheetLoadingState extends BottomSheetState {
  const BottomSheetLoadingState();

  @override
  List<Object> get props => [];
}

class BottomSheetCompleteState extends BottomSheetState {
  const BottomSheetCompleteState(this.response);

  final List<ParametroFiltroEntity> response;

  @override
  List<Object> get props => [response];
}

class ErrorBottomSheetState extends BottomSheetState {
  const ErrorBottomSheetState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
