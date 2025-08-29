// ignore_for_file: invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/modules/login/model/profile_response_model.dart';
import 'package:perubeca/app/modules/login/repository/i_login_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileDataEvent>((event, emit) => initDataProfile());
    on<ProfileUpdateDataEvent>((event, emit) => updateDataProfile(event.prefix, event.num));
  }

  final repository = getItApp.get<IloginRepository>();
  
  Future<void> initDataProfile() async {
    emit(ProfileInitialState());
    //llamar a servicio de profile
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    final profile = profilebox.values.first;

    final response = await repository.getUser(profile.iRegistroId!);
    if(response.status) {
      //guardar los datos de profile mapeando la respuesta
      final data = response.data as ProfileResponseModel;
      final model = data.value!;
        await profilebox.clear();
        await profilebox.add(
          ProfileEntity(
            iRegistroId: model.iRegistroId,
            vApellidos: model.vApellidos,
            vCelular: model.vCelular,
            vDigitoVerificador: model.vDigitoVerificador,
            vEmail: model.vEmail,
            vFechaNacimiento: model.vFechaNacimiento,
            vNombres: model.vNombres,
            vNroDocumento: model.vNroDocumento,
            vPrefijo: model.vPrefijo,
            vUbigeo: model.vUbigeo,
          ),
        );
      final profile2 = profilebox.values.first;
      emit(ProfileDataState(profile2));
    }else{
      emit(ProfileDataState(profile));
    }

    
  }

  Future<void> updateDataProfile(String prefix, String num) async {
    emit(ProfileInitialState());
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    final profile = profilebox.values.first;
        await profilebox.clear();
        await profilebox.add(
          ProfileEntity(
            iRegistroId: profile.iRegistroId,
            vApellidos: profile.vApellidos,
            vCelular: num,
            vDigitoVerificador: profile.vDigitoVerificador,
            vEmail: profile.vEmail,
            vFechaNacimiento: profile.vFechaNacimiento,
            vNombres: profile.vNombres,
            vNroDocumento: profile.vNroDocumento,
            vPrefijo: prefix,
            vUbigeo: profile.vUbigeo,
          ),
        );

    final profile2 = profilebox.values.first;
    emit(ProfileDataState(profile2));
  }
}
