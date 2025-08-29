// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/pregunta_frecuente_entity.dart';

part 'pregunta_frecuente_event.dart';
part 'pregunta_frecuente_state.dart';

class PreguntaFrecuenteBloc extends Bloc<PreguntaFrecuenteEvent, PreguntaFrecuenteState> {
  PreguntaFrecuenteBloc() : super(PreguntaFrecuenteInitialState()) {
    on<GetPreguntaFrecuenteDataLocalEvent>(onGetLocalData);
  }

  Future<void> onGetLocalData(GetPreguntaFrecuenteDataLocalEvent event, Emitter<PreguntaFrecuenteState> emitter) async{
    final preguntaFrecuentebox = await Hive.openBox<PreguntaFrecuenteEntity>('preguntaFrecuenteBox');
    final listPreguntaFrecuente = preguntaFrecuentebox.values.toList();

     emit(PreguntaFrecuenteLoadLocalCompleteState(listPreguntaFrecuente));
  }
}
