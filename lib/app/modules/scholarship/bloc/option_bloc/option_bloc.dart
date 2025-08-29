// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member, cascade_invocations, inference_failure_on_function_return_type, type_annotate_public_apis, override_on_non_overriding_member, always_declare_return_types, sdk_version_since

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_two.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {
  OptionBloc() : super(const OptionInitialState()) {
    on<InitDataEvent>((event, emit) => getDataInitial());
    on<AddRespuestaProcesada>((event, emit) => addRespuestaProcesada(event.respuesta));
    on<RemoveRespuestaProcesada>((event, emit) => removeRespuestaProcesada(event.respuesta));
  }

  Future<void> getDataInitial() async {
    final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
    final user = reniecDatabox.values.firstOrNull;

    final sectionbox = await Hive.openBox<SeccionEntity>('seccionBox');
    final sections = sectionbox.values.toList();
    sections.sort((a, b) => a.orden!.compareTo(b.orden!));
    final sectionsId = sections.map((element) => element.seccionId).toList();

    final respuestaBox = await Hive.openBox<RespuestaEntity>('respuestaBox');
    final respuestas = respuestaBox.values.toList();

    final preguntabox = await Hive.openBox<PreguntaEntity>('preguntaBox');
    final questions = preguntabox.values.toList();

    final preguntaOpcionesBox = await Hive.openBox<PreguntaOpcionesEntity>('opcionBox');
    final options = preguntaOpcionesBox.values.toList();

    for (final q in questions) {
      q.opciones = options.where((o) => o.preguntaId == q.preguntaId).toList();
    }
    emit(
      OptionCompleteState(
        sections: sections,
        questions: questions,
        options: options,
        respuestas: respuestas,
        respuestasProcesadas: const [],
        respuestaEnWidget: const [],
        user: user,
        sectionsId: sectionsId,
      ),
    );
  }

  void addRespuestaProcesada(RespuestaProcesada respuesta) {
    var list = (state as OptionCompleteState).respuestasProcesadas!.toList();
    list = list.where((element) => element.idPregunta != respuesta.idPregunta).toList();
    if (respuesta.valorRespuesta != 99999999) {
      list.add(respuesta);
    }

    emit((state as OptionCompleteState).copyWith(respuestasProcesadas: list));
  }

  void removeRespuestaProcesada(RespuestaProcesada respuesta) {
    var list = (state as OptionCompleteState).respuestasProcesadas!.toList();
    list = list.where((element) => element.idPregunta != respuesta.idPregunta).toList();

    emit((state as OptionCompleteState).copyWith(respuestasProcesadas: list));
  }
}
