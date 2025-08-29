// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/database/entities/enlace_relacionado_entity.dart';

part 'enlace_relacionado_event.dart';
part 'enlace_relacionado_state.dart';

class EnlaceRelacionadoBloc extends Bloc<EnlaceRelacionadoEvent, EnlaceRelacionadoState> {
  EnlaceRelacionadoBloc() : super(EnlaceRelacionadoInitialState()) {
    on<GetEnlaceRelacionadoDataLocalEvent>(onGetLocalData);
  }

  Future<void> onGetLocalData(GetEnlaceRelacionadoDataLocalEvent event, Emitter<EnlaceRelacionadoState> emitter) async{
    final enlaceRelacionadoobox = await Hive.openBox<EnlaceRelacionadoEntity>('enlaceRelacionadoBox');
    final listEnlaceRelacionadoo = enlaceRelacionadoobox.values.toList();

     emit(EnlaceRelacionadoLoadLocalCompleteState(listEnlaceRelacionadoo));
  }
}
