// search_bloc.dart

// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member, cascade_invocations, avoid_bool_literals_in_conditional_expressions, avoid_positional_boolean_parameters, avoid_function_literals_in_foreach_calls, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_entity.dart';
import 'package:perubeca/app/database/entities/beca_otro_pais_hijo_entity.dart';

part 'other_country_event.dart';
part 'other_country_state.dart';

class OtherCountryBloc extends Bloc<OtherCountryEvent, OtherCountryState> {
  OtherCountryBloc() : super(const OtherCountryInitialState()) {
    on<OtherCountryLoadEvent>(search);
  }

  Future<void> search(OtherCountryLoadEvent event, Emitter<OtherCountryState> emit) async {
    emit(const OtherCountryLoadingState());

    // Abre las cajas de Hive de forma asíncrona
    final becaOtroPaisBox = await Hive.openBox<BecaOtroPaisEntity>('becaOtroPaisBox');
    final becaOtroPaisHijoBox = await Hive.openBox<BecaOtroPaisHijoEntity>('becaOtroPaisHijoBox');

    final list = becaOtroPaisBox.values.toList();
    final hijos = becaOtroPaisHijoBox.values.toList();

    for (final beca in list) {
       beca.becasOtrosPaisesHijos = hijos.where((element) => element.iBopIdPadre! == beca.iBopId!).toList();
    }

    emit(OtherCountryCompleteState(list));
  }


  void initialState() {
    emit(const OtherCountryInitialState());
  }
}
