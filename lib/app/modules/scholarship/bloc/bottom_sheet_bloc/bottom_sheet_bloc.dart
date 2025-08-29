// ignore_for_file: invalid_use_of_visible_for_testing_member, cascade_invocations, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(const BottomSheetInitialState()) {
    on<BottomSheetLoadEvent>(search);
  }


  Future<void> search(BottomSheetLoadEvent event, Emitter<BottomSheetState> emit) async {
    emit(const BottomSheetLoadingState());
    final parametros = await Hive.openBox<ParametroFiltroEntity>('parametrosFiltroBox');
    final parametrosOpciones = await Hive.openBox<ParametroFiltroOpcionesEntity>('parametrosFiltroOpcionBox');
    
    final entities = parametros.values.toList();
    for (var i = 0; i < entities.length; i++) {
      final parametro = entities[i];
      parametro.opciones = parametrosOpciones.values.where((element) => element.filtroId == parametro.filtroId).toList();
    }
    emit(BottomSheetCompleteState(entities));
  }

  void initialState() {
    emit(const BottomSheetInitialState());
  }
}
