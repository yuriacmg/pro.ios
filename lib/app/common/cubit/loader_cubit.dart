// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<bool> {
  LoaderCubit() : super(false);

  void showLoader() {
    emit(true);
  }

  void hideLoader() {
    emit(false);
  }
}
