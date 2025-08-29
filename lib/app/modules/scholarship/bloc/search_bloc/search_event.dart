part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchLoadEvent extends SearchEvent {
  const SearchLoadEvent(this.filter, this.sliderValue, this.textSearch);

  final List<ParametroFiltroOpcionesEntity> filter;
  final double? sliderValue;
  final String? textSearch;
  @override
  List<Object> get props => [];
}
