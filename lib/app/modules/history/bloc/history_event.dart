// ignore_for_file: must_be_immutable

part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistorySyncEvent extends HistoryEvent {}
class HistorySearchEvent extends HistoryEvent {
  HistorySearchEvent({required this.searchText});
  String searchText;
}
class HistoryLoadedEvent extends HistoryEvent {}
