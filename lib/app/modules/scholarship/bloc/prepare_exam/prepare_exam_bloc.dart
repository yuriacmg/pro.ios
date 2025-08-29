// ignore_for_file: invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars, omit_local_variable_types, prefer_final_locals, cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_advance_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_pregunta_entity.dart';

part 'prepare_exam_event.dart';
part 'prepare_exam_state.dart';

class PrepareExamBloc extends Bloc<PrepareExamEvent, PrepareExamState> {
  PrepareExamBloc() : super(const PrepareExamInitialState()) {
    on<InitDataEvent>((event, emit) => getDataInitial(event.courseCode, event.userDocument, event.areaCode, event.generalCode));
    on<AddRespuesta>((event, emit) => addRespuesta(event.history));
    on<AddRespuestaSimulacrum>((event, emit) => addRespuestaSimulacrum(event.history));
    on<SaveHistoryArea>((event, emit) => saveHistory(event.userDocument, event.areaCode, event.generalCode, event.courseCode));
  }

  List<PrepareAlternativeEntity> removeDuplicate(List<PrepareAlternativeEntity> lista) {
    final mapaUnico = <int, PrepareAlternativeEntity>{};

    for (final objeto in lista) {
      mapaUnico[objeto.alternativaId!] = objeto;
    }

    final listaUnica = mapaUnico.values.toList();

    return listaUnica;
  }

  Future<void> getDataInitial(int courseCode, String userDocument, int areaCode, int generalCode) async {
    final preparePreguntabox = await Hive.openBox<PreparePreguntaEntity>('preparePreguntaBox');
    final prepareAlternativebox = await Hive.openBox<PrepareAlternativeEntity>('prepareAlternativeBox');
    final prepareAreaAdvancebox = await Hive.openBox<PrepareAreaAdvanceEntity>('prepareAreaAdvanceBox');

    final questionsList = preparePreguntabox.values.toList();
    final questions = questionsList.where((element) => element.simulacroId == courseCode && element.codigoCourse == areaCode).toList();
    //final questions = questionsTotal.toSet().toList();

    final alternativesList = prepareAlternativebox.values.toList();

    for (final q in questions) {
      // print(q.preguntaId);
      q.alternatives = removeDuplicate(alternativesList.where((a) => a.preguntaId == q.preguntaId).toList());
    }

    //advance
    final listAdvance = prepareAreaAdvancebox.values.toList();
    final advances = listAdvance.where((element) => element.courseCode == courseCode && element.userDocument == userDocument && element.areaCode == areaCode  && element.generalCode == generalCode).toList();
    final uniqueAdvances = Set<PrepareAreaAdvanceEntity>.from(advances).toList();
    emit(PrepareExamCompleteState(advances: uniqueAdvances, questions: questions, seconds: 3600));
  }

  void addRespuesta(PrepareAreaAdvanceEntity history) {
    var list = (state as PrepareExamCompleteState).advances!.toList();
    final questions = (state as PrepareExamCompleteState).questions!.toList();
    list = list.where((element) => element.preguntaId != history.preguntaId && element.userDocument == history.userDocument && element.areaCode == history.areaCode && element.generalCode == history.generalCode).toList();
    if (history.respuestaMarcada != 999999999) {
      list.add(history);
    }
    final unique = Set<PrepareAreaAdvanceEntity>.from(list).toList();

    emit((state as PrepareExamCompleteState).copyWith(advances: unique, questions: questions));
  }

  Future<void> saveHistory(String userDocument, int areaCode, int generalCode, int courseCode) async {
    final prepareAreaAdvancebox = await Hive.openBox<PrepareAreaAdvanceEntity>('prepareAreaAdvanceBox');
    final oldlist = prepareAreaAdvancebox.values.toList();
    oldlist.removeWhere((element) => element.userDocument == userDocument && element.areaCode == areaCode && element.generalCode == generalCode && element.courseCode == courseCode);
    await prepareAreaAdvancebox.clear();
    await prepareAreaAdvancebox.addAll(oldlist);
    final list = (state as PrepareExamCompleteState).advances!.toList();
    final uniqueAdvances = Set<PrepareAreaAdvanceEntity>.from(list).toList();
    await prepareAreaAdvancebox.addAll(uniqueAdvances);
  }

  Future<void> deleteHistory(int codigo, String userDocument, int generalCode, int areaCode) async {
    final prepareAreaAdvancebox = await Hive.openBox<PrepareAreaAdvanceEntity>('prepareAreaAdvanceBox');
    final list = prepareAreaAdvancebox.values.toList();
    list.removeWhere((element) => element.courseCode == codigo && element.userDocument == userDocument && element.generalCode == generalCode && element.areaCode == areaCode);
    final uniqueAdvances = Set<PrepareAreaAdvanceEntity>.from(list).toList();
    await prepareAreaAdvancebox.clear();
    await prepareAreaAdvancebox.addAll(uniqueAdvances);
  }

  Future<void> deleteHistorySimulacrum(int codigo) async {
    final prepareAreaAdvancebox = await Hive.openBox<PrepareAreaAdvanceEntity>('prepareAreaAdvanceBox');
    final list = prepareAreaAdvancebox.values.toList();
    final listArea = list.where((element) => element.courseCode != codigo).toList();

    await prepareAreaAdvancebox.clear();
    await prepareAreaAdvancebox.addAll(listArea);
  }

  void addRespuestaSimulacrum(PrepareAreaAdvanceEntity history) {
    var list = (state as PrepareExamCompleteState).advances!.toList();
    final questions = (state as PrepareExamCompleteState).questions!.toList();
    list = list.where((element) => element.preguntaId != history.preguntaId).toList();
    if (history.respuestaMarcada != 999999999) {
      list.add(history);
    }

    emit((state as PrepareExamCompleteState).copyWith(advances: list, questions: questions));
  }
}
