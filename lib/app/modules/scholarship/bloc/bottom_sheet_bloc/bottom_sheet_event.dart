part of 'bottom_sheet_bloc.dart';

abstract class BottomSheetEvent extends Equatable {
  const BottomSheetEvent();

  @override
  List<Object> get props => [];
}

class BottomSheetLoadEvent extends BottomSheetEvent {
  const BottomSheetLoadEvent();

  @override
  List<Object> get props => [];
}
