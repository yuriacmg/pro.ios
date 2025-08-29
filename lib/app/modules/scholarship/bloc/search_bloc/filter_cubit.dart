// ignore_for_file: cascade_invocations, lines_longer_than_80_chars

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';

class FilterCubit extends Cubit<Set<ParametroFiltroOpcionesEntity>> {
  FilterCubit() : super({});

  void toggleSelection(ParametroFiltroOpcionesEntity option) {
    final newState = Set<ParametroFiltroOpcionesEntity>.from(state);
    if (!newState.add(option)) {
      newState.remove(option);
    }
    emit(newState);
  }

  void toggleSingleSelection(ParametroFiltroOpcionesEntity option) {
    final newState = Set<ParametroFiltroOpcionesEntity>.from(state);
    newState.removeWhere((selectedOption) => selectedOption.filtroId == option.filtroId);
    newState.add(option);
    emit(newState);
  }

  void updateSliderValue(ParametroFiltroEntity parametro, double? value) {
    print('Valor del range');
    print(value);
  }

  void resetFilters() {
    emit({});
  }
}
