// search_bloc.dart

// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member, cascade_invocations, avoid_bool_literals_in_conditional_expressions, avoid_positional_boolean_parameters, avoid_function_literals_in_foreach_calls, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_documento_clave_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/palabras_clave_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitialState()) {
    on<SearchLoadEvent>(search);
  }

  Future<void> search(SearchLoadEvent event, Emitter<SearchState> emit) async {
    emit(const SearchLoadingState());

    // Abre las cajas de Hive de forma asíncrona
    final modalidadBox = await Hive.openBox<ModalidadEntity>('modalidadBox');
    final palabrasBox = await Hive.openBox<PalabraClaveEntity>('palabrasBox');
    final beneficiobox =
        await Hive.openBox<ModalidadBeneficioEntity>('beneficioBox');
    final requisitobox =
        await Hive.openBox<ModalidadRequisitoEntity>('requisitoBox');
    final impedimentobox =
        await Hive.openBox<ModalidadImpedimentoEntity>('impedimentoBox');
    final parametrosBox =
        await Hive.openBox<ParametroFiltroEntity>('parametrosFiltroBox');
    final parametrosFiltroOpcionBox =
        await Hive.openBox<ParametroFiltroOpcionesEntity>(
            'parametrosFiltroOpcionBox');
    final documentoClaveBox =
        await Hive.openBox<ModalidadDocumentoClaveEntity>('documentoClaveBox');

    // Obtiene todos los valores de las cajas
    var allModalidades = modalidadBox.values.toList();
    final allPalabras = palabrasBox.values.toList();
    final allParametros = parametrosBox.values.toList();
    final allParametrosOpciones = parametrosFiltroOpcionBox.values.toList();

    // Asocia palabras clave con sus modalidades correspondientes
    for (final modalidad in allModalidades) {
      modalidad.listPalabras = allPalabras
          .where((palabra) => palabra.modId == modalidad.modId)
          .toList();
      modalidad.listBeneficios = beneficiobox.values
          .where((element) => element.modId == modalidad.modId)
          .toList();
      modalidad.listRequisitos = requisitobox.values
          .where((element) => element.modId == modalidad.modId)
          .toList();
      modalidad.listImpedimentos = impedimentobox.values
          .where((element) => element.modId == modalidad.modId)
          .toList();
      modalidad.listDocumentoClave = documentoClaveBox.values
          .where((element) => element.modId == modalidad.modId)
          .toList();
    }

    for (final parametro in allParametros) {
      parametro.opciones = allParametrosOpciones
          .where((op) => op.filtroId == parametro.filtroId)
          .toList();
    }

// Listas de IDs para cada tipo de filtro  -- changes
    var listIdParametroOpcionesAge = <int?>[];
    var listIdParametroOpcionesNivel = <int?>[];
    var listIdParametroOpcionesRend = <int?>[];
    var listIdParametroOpcionesDisc = <int?>[];
    var listIdParametroOpcionesEspecial = <int?>[];

    if (allParametros.any((e) => e.filtroId == 1)) {
      listIdParametroOpcionesAge = allParametros
              .firstWhere((e) => e.filtroId == 1)
              .opciones
              ?.map((e) => e.filtroContenidoId)
              .toList() ??
          [];
    }
    if (allParametros.any((e) => e.filtroId == 2)) {
      listIdParametroOpcionesNivel = allParametros
              .firstWhere((e) => e.filtroId == 2)
              .opciones
              ?.map((e) => e.filtroContenidoId)
              .toList() ??
          [];
    }
    if (allParametros.any((e) => e.filtroId == 3)) {
      listIdParametroOpcionesRend = allParametros
              .firstWhere((e) => e.filtroId == 3)
              .opciones
              ?.map((e) => e.filtroContenidoId)
              .toList() ??
          [];
    }
    if (allParametros.any((e) => e.filtroId == 4)) {
      listIdParametroOpcionesDisc = allParametros
              .firstWhere((e) => e.filtroId == 4)
              .opciones
              ?.map((e) => e.filtroContenidoId)
              .toList() ??
          [];
    }
    if (allParametros.any((e) => e.filtroId == 5)) {
      listIdParametroOpcionesEspecial = allParametros
              .firstWhere((e) => e.filtroId == 5)
              .opciones
              ?.map((e) => e.filtroContenidoId)
              .toList() ??
          [];
    }
    // Si no hay filtros aplicados, mostrar todas las modalidades
    if (event.filter.isEmpty && event.sliderValue == null) {
      if (event.textSearch != null) {
        allModalidades = allModalidades
            .where((element) => element.nomCompleto!
                .toUpperCase()
                .contains(event.textSearch!.toUpperCase()))
            .toList();
      }

      emit(SearchCompleteState(
          allModalidades, event.sliderValue, event.textSearch));
      return;
    }

    var filteredModalidades = <ModalidadEntity>{};

    // Extraer IDs de discapacidad del evento
    final include14 = event.filter.any((f) => f.filtroContenidoId == 14);
    final exclude14 = event.filter.any((f) => f.filtroContenidoId == 15);
    final disabilitySelected = include14 || exclude14;

    // Extraer todos los filtros aplicados
    //final ageFilters = event.filter.where((f) => f.filtroId == 1).map((f) => f.filtroContenidoId).toList();
    final nivelFilters = event.filter
        .where((f) => f.filtroId == 2)
        .map((f) => f.filtroContenidoId)
        .toList();
    final rendFilters = event.filter
        .where((f) => f.filtroId == 3)
        .map((f) => f.filtroContenidoId)
        .toList();
    final discFilters = event.filter
        .where((f) => f.filtroId == 4)
        .map((f) => f.filtroContenidoId)
        .toList();
    final especialFilters = event.filter
        .where((f) => f.filtroId == 5)
        .map((f) => f.filtroContenidoId)
        .toList();

    // Aplicar filtros a las modalidades
    allModalidades.forEach((modalidad) {
      var ageMatch = event.sliderValue == null ||
          modalidad.listPalabras!.every((palabra) => !listIdParametroOpcionesAge
              .contains(palabra.filtroContenidoId)) ||
          filterMatchByAge(modalidad, listIdParametroOpcionesAge,
              event.sliderValue, allParametrosOpciones);
      final nivelMatch = nivelFilters.isEmpty ||
          modalidad.listPalabras!.any(
              (palabra) => nivelFilters.contains(palabra.filtroContenidoId));
      final rendMatch = rendFilters.isEmpty ||
          modalidad.listPalabras!.any(
              (palabra) => rendFilters.contains(palabra.filtroContenidoId));
      final discMatch = modalidad.listPalabras!.every((palabra) =>
              !listIdParametroOpcionesDisc
                  .contains(palabra.filtroContenidoId)) ||
          discFilters.isEmpty ||
          (disabilitySelected
              ? filterDisability(modalidad, include14, exclude14)
              : modalidad.listPalabras!.any((palabra) =>
                  discFilters.contains(palabra.filtroContenidoId)));
      final especialMatch = modalidad.listPalabras!.every((palabra) =>
              !listIdParametroOpcionesEspecial
                  .contains(palabra.filtroContenidoId)) ||
          especialFilters.isEmpty ||
          modalidad.listPalabras!.any(
              (palabra) => especialFilters.contains(palabra.filtroContenidoId));

      if (include14) {
        // Si el filtro 14 está seleccionado, se ignora la edad solo si `estadoConDiscapacidad` es true.
        if (modalidad.estadoConDiscapacidad!) {
          // si la edad es menor al valor menor del rango se toma la validacion de la edad
          // caso contrario  se sigue con lo mismo
          final isMinorRange = isAgeIsMayorInRange(
              modalidad,
              listIdParametroOpcionesAge,
              event.sliderValue,
              allParametrosOpciones);
          if (!isMinorRange) {
            ageMatch = filterMatchByAge(modalidad, listIdParametroOpcionesAge,
                event.sliderValue, allParametrosOpciones);
            if (ageMatch &&
                nivelMatch &&
                rendMatch &&
                discMatch &&
                especialMatch) {
              filteredModalidades.add(modalidad);
            }
          } else {
            if (nivelMatch && rendMatch && discMatch && especialMatch) {
              filteredModalidades.add(modalidad);
            }
          }
        } else {
          if (ageMatch &&
              nivelMatch &&
              rendMatch &&
              discMatch &&
              especialMatch) {
            filteredModalidades.add(modalidad);
          }
        }
      } else {
        // Si el filtro 14 no está seleccionado, aplicar todos los filtros incluyendo edad.
        if (ageMatch && nivelMatch && rendMatch && discMatch && especialMatch) {
          filteredModalidades.add(modalidad);
        }
      }
    });

    if (event.textSearch != null) {
      filteredModalidades = filteredModalidades
          .where((element) => element.nomCompleto!
              .toUpperCase()
              .contains(event.textSearch!.toUpperCase()))
          .toSet();
    }

    emit(SearchCompleteState(filteredModalidades.toSet().toList(),
        event.sliderValue, event.textSearch));
  }

  bool filterMatchByAge(
      ModalidadEntity modalidad,
      List<int?>? filtroIds,
      double? sliderValue,
      List<ParametroFiltroOpcionesEntity> allParametrosOpciones) {
    if (sliderValue != null && filtroIds != null && filtroIds.isNotEmpty) {
      final coincidencias = modalidad.listPalabras!
          .where((palabra) => filtroIds.contains(palabra.filtroContenidoId))
          .toList();

      if (coincidencias.length >= 2) {
        final rangos = coincidencias
            .map((palabra) {
              final opciones = allParametrosOpciones
                  .firstWhere((opcion) =>
                      opcion.filtroContenidoId == palabra.filtroContenidoId)
                  .opciones;
              return opciones != null ? int.parse(opciones) : null;
            })
            .whereType<int>()
            .toList();

        rangos.sort();
        if (rangos.isNotEmpty) {
          final start = rangos.first;
          final end = rangos.last;
          return sliderValue >= start && sliderValue <= end;
        }
      }
    }
    return true; // Si no hay filtro de edad aplicado, consideramos que la condición de edad se cumple.
  }

  bool isAgeIsMayorInRange(
      ModalidadEntity modalidad,
      List<int?>? filtroIds,
      double? sliderValue,
      List<ParametroFiltroOpcionesEntity> allParametrosOpciones) {
    if (sliderValue != null && filtroIds != null && filtroIds.isNotEmpty) {
      final coincidencias = modalidad.listPalabras!
          .where((palabra) => filtroIds.contains(palabra.filtroContenidoId))
          .toList();

      if (coincidencias.length >= 2) {
        final rangos = coincidencias
            .map((palabra) {
              final opciones = allParametrosOpciones
                  .firstWhere((opcion) =>
                      opcion.filtroContenidoId == palabra.filtroContenidoId)
                  .opciones;
              return opciones != null ? int.parse(opciones) : null;
            })
            .whereType<int>()
            .toList();

        rangos.sort();
        if (rangos.isNotEmpty) {
          final start = rangos.first;
          final end = rangos.last;
          if (sliderValue >= start) {
            return true; // esto es cuando es mayor o igual al menor valor del rango
          } else {
            return false; // esto es cuando no es mayor o igual  al menor valor del rango
          }
        }
      }
    }

    return true;
  }

  bool filterMatch(ModalidadEntity modalidad, SearchLoadEvent event,
      int filtroId, List<int?>? filtroIds) {
    final filtroContenidoIds = event.filter
        .where((f) => f.filtroId == filtroId)
        .map((e) => e.filtroContenidoId)
        .toList();

    if (filtroContenidoIds.isNotEmpty) {
      return modalidad.listPalabras!.any(
          (palabra) => filtroContenidoIds.contains(palabra.filtroContenidoId));
    }
    return true; // Si no hay filtro aplicado, consideramos que la condición se cumple.
  }

  bool filterDisability(
      ModalidadEntity modalidad, bool include14, bool exclude14) {
    if (include14) {
      return modalidad.listPalabras!
          .any((palabra) => palabra.filtroContenidoId == 14);
    }
    if (exclude14) {
      return modalidad.listPalabras!
              .any((palabra) => palabra.filtroContenidoId == 15) ||
          modalidad.listPalabras!
              .every((palabra) => palabra.filtroContenidoId != 14);
    }
    return true; // No aplicar filtro de discapacidad si no se especifica
  }

  void initialState() {
    emit(const SearchInitialState());
  }
}
