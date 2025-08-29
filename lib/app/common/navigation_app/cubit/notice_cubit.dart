import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notice_state.dart';

class NoticeCubit extends Cubit<bool> {
  NoticeCubit() : super(true);

  void visible() => emit(true);
  void invisible() => emit(false);
}
