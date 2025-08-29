part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  const HistoryLoaded ({required this.histories, required this.dataLocal});
  final List<HistoryEntity> histories;
  final List<HistoryEntity> dataLocal;

}
