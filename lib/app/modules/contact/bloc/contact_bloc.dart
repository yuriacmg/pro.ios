// ignore_for_file: lines_longer_than_80_chars, invalid_use_of_visible_for_testing_member
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/local_json/i_local_data_json_repository.dart';
import 'package:perubeca/app/common/static_data_constants.dart';
import 'package:perubeca/app/database/entities/canal_atencion_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/modules/contact/model/contac_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitialState()) {
    on<GetContactDataEvent>(onGetData);
    on<GetContactDataLocalEvent>(onGetLocalData);
  }

  final ILocalDataJsonRepository _localRepository = getItApp.get<ILocalDataJsonRepository>();

  //methods
  Future<void> onGetData( GetContactDataEvent event, Emitter<ContactState> emitter) async {
    //emitter(const MovieLoadingState());
    final chanel = await _localRepository.getDataJson(StaticDataConstants().pathContactChanel);
    final social = await _localRepository.getDataJson(StaticDataConstants().pathContactSocial);
    final chanelJson = json.decode(chanel);
    final socialJson = json.decode(social);
    emit(
      ContactLoadCompleteState(
        ContactDataModel.fromJson(chanelJson as Map<String, dynamic>),
        ContactDataModel.fromJson(socialJson as Map<String, dynamic>),
      ),
    );
  }

  Future<void> onGetLocalData(GetContactDataLocalEvent event, Emitter<ContactState> emitter) async{
    final canalbox = await Hive.openBox<CanalAtencionEntity>('canalBox');
    final contactobox = await Hive.openBox<ContactoEntity>('contactBox');
    final listCanal = canalbox.values.toList();
    final schedule = listCanal.last;
    final listContacto = contactobox.values.toList();

     emit(ContactLoadLocalCompleteState(listCanal, listContacto, schedule));
  }
}
