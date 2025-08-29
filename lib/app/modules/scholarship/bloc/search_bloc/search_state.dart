part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {
  const SearchInitialState();

  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();

  @override
  List<Object> get props => [];
}

class SearchCompleteState extends SearchState {
  const SearchCompleteState(this.response, this.sliderValue, this.textSearch);

  final List<ModalidadEntity> response;
  final double? sliderValue;
  final String? textSearch;

  @override
  List<Object> get props => [response];
}

class ErrorSearchState extends SearchState {
  const ErrorSearchState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
