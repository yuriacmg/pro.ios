part of 'other_country_bloc.dart';

abstract class OtherCountryState extends Equatable {
  const OtherCountryState();

  @override
  List<Object> get props => [];
}

class OtherCountryInitialState extends OtherCountryState {
  const OtherCountryInitialState();

  @override
  List<Object> get props => [];
}

class OtherCountryLoadingState extends OtherCountryState {
  const OtherCountryLoadingState();

  @override
  List<Object> get props => [];
}

class OtherCountryCompleteState extends OtherCountryState {
  const OtherCountryCompleteState(this.response);

  final List<BecaOtroPaisEntity> response;

  @override
  List<Object> get props => [response];
}

class OtherCountryErrorState extends OtherCountryState {
  const OtherCountryErrorState({required this.error});

  final ErrorResponseModel error;

  @override
  List<Object> get props => [];
}
