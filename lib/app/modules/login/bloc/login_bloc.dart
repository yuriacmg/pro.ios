// ignore_for_file: invalid_use_of_visible_for_testing_member, cascade_invocations, lines_longer_than_80_chars, avoid_positional_boolean_parameters, sdk_version_since

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/modules/login/model/login_response_model.dart';
import 'package:perubeca/app/modules/login/model/login_send_model.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_response_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_response_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_response_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_response_model.dart';
import 'package:perubeca/app/modules/login/model/valid_code_email_send_model.dart';
import 'package:perubeca/app/modules/login/repository/i_login_repository.dart';
import 'package:uuid/uuid.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitEvent>((event, emit) => login(event.send));
    on<LogOutEvent>((event, emit) => logout());
    on<RegisterAccountEvent>((event, emit) => registerAccount(event.send, event.isResend));
    on<LoginInitialEvent>((event, emit) => reset());
    on<ValidAccountEvent>((event, emit) => validAccount(event.send));
    on<ValidAccountRecoveryEvent>((event, emit) => validAccountRecovery(event.send));
    on<LoginValidStatusEvent>((event, emit) => validLoginStatus());
    on<LoginRecoveryPasswordCodeEvent>((event, emit) => recoveryPasswordCode(event.send, event.isResend));
    on<UpdatePasswordProfileEvent>((event, emit) => updatePasswordProfile(event.send));
    on<UpdateProfileEvent>((event, emit) => updateProfile(event.send));
    on<RecodeEmailInitEvent>((event, emit) => recodeEmailInit(event.send));
    on<RecodeEmailEvent>((event, emit) => recodeEmail(event.send, event.isResend));
    on<ValidCodeEmailEvent>((event, emit) => validCodeEmail(event.send));
  }

  final repository = getItApp.get<IloginRepository>();
  final localRepository = getItApp.get<ILocalDataSecureDbRepository>();

  void reset() {
    emit(LoginInitialState());
  }

  Future<void> login(LoginSendModel send) async {
    try {
      emit(LoginLoadingState());
      final response = await repository.login(send);
      if (response.status) {
        final data = response.data as LoginResponseModel;
        await localRepository.setAuthTokenProfile(data.value!.vToken!);
        final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
        await profilebox.clear();
        await profilebox.add(
          ProfileEntity(
            iRegistroId: data.value!.iRegistroId,
            vApellidos: data.value!.vApellidos,
            vCelular: data.value!.vCelular,
            vDigitoVerificador: data.value!.vDigitoVerificador,
            vEmail: data.value!.vEmail,
            vFechaNacimiento: data.value!.vFechaNacimiento,
            vNombres: data.value!.vNombres,
            vNroDocumento: data.value!.vNroDocumento,
            vPrefijo: data.value!.vPrefijo,
            vUbigeo: data.value!.vUbigeo,
          ),
        );
        emit(LoginSuccessState());
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorState(error: error));
      }
    } catch (e) {
      //print(e);
      //emit(ErrorState());
    }
  }

  Future<void> setUserLocalLogin() async{
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    final profile = profilebox.values.toList().first;
    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    final user = PrepareUserEntity(
      apeMaterno: profile.vApellidos!.split(' ')[1],
      apePaterno: profile.vApellidos!.split(' ')[0],
      fecNacimiento: profile.vFechaNacimiento,
      nombre: profile.vNombres,
      nombreCompleto: '',
      numdoc: profile.vNroDocumento,
      sexo: '',
      status: true,
    );
    // Obtener todos los usuarios
    final listUsers = prepareUserBox.values.toList();

    // Verificar si el usuario ya existe
    final existingUser = listUsers.where((user) => user.numdoc == profile.vNroDocumento).firstOrNull;

    if (existingUser != null) {
      // Actualizar el usuario si ya existe
      final indexUser = listUsers.indexOf(existingUser);
      listUsers[indexUser] = user;
    } else {
      // Agregar el usuario si no existe
      listUsers.add(user);
    }

    // Guardar la lista actualizada en la caja
    await prepareUserBox.clear();
    await prepareUserBox.addAll(listUsers);
    await activatePrepareUserLogin();

  }

    Future<void> activatePrepareUserLogin() async {
      final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
      final profile = profilebox.values.toList().first;
      final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
      final users = prepareUserBox.values.toList();
      for (final user in users) {
        user.status = user.numdoc == profile.vNroDocumento;
      }

      await prepareUserBox.clear();
      await prepareUserBox.addAll(users);
  }

  Future<void> registerAccount(RegisterAccountSendModel send, bool isResend) async {
    try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vNroDocumento);
      final response = await repository.registerAccount(send);
      if (response.status) {
        emit(RegisterAccountSuccessState(send, isResend));
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorRegisterAccountState(error: error));
      }
    } catch (e) {
      //print('');
      //emit(ErrorState());
    }
  }

  Future<void> validAccount(ValidAccountSendModel send) async {
    try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vNroDocumento);
      final response = await repository.validAccount(send);
      if (response.status) {
        final data = response.data as ValidAccountResponseModel;
        if (data.value!.bValidacion!) {
          emit(ValidAccountSuccessState());
        } else {
          final valueError = ValueError(errorCode: 400, message: 'Código incorrecto');
          final list = <ValueError>[];
          list.add(valueError);
          final error = ErrorResponseModel(hasSucceeded: false, value: list, statusCode: 400);
          emit(ErrorValidAccountState(error: error));
        }
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorValidAccountState(error: error));
      }
    } catch (e) {
      //print();
    }
  }

  Future<void> validAccountRecovery(ValidAccountSendModel send) async {
    try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vNroDocumento);
      final response = await repository.validAccount(send);
      if (response.status) {
        final data = response.data as ValidAccountResponseModel;
        if (data.value!.bValidacion!) {
          emit(ValidAccountRecoverySuccessState(data.value!.iRegistroId!));
        } else {
          final valueError = ValueError(errorCode: 400, message: 'Código incorrecto');
          final list = <ValueError>[];
          list.add(valueError);
          final error = ErrorResponseModel(hasSucceeded: false, value: list, statusCode: 400);
          emit(ErrorValidAccountState(error: error));
        }
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorValidAccountState(error: error));
      }
    } catch (e) {
      //print();
    }
  }
  
  Future<void> validLoginStatus()async {
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    if(profilebox.values.isNotEmpty){
      emit(LoginSuccessState());
    } else{
      emit(LoginInitialState());
    }
  }

  Future<void> logout() async {
    emit(LoginLoadingState());
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    await localRepository.setAuthTokenProfile('');
    await profilebox.clear();
    emit(LogOutSuccessState());
  }
  
  Future<void> recoveryPasswordCode(RecoveryPasswordSendModel send, bool isResend) async {
    try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vNroDocumento);
      final response = await repository.recoveryPasswordCode(send);
      if(response.status){
        final data = response.data as RecoveryPasswordResponseModel;
        await localRepository.setAuthTokenProfile(data.value!.vToken!);
        emit(RecoveryPasswordCodeSuccessState(data, isResend));
      }else{
        final error = response.data as ErrorResponseModel;
        emit(ErrorRecoveryPasswordCodeState(error: error));
      }
    } catch (e) {
      //print();
    }
  }
  
 Future<void> updatePasswordProfile(PasswordProfileUpdateSendModel send) async  {
    emit(LoginLoadingState());
    send.vToken = await localRepository.getAuthTokenProfile();
    final response = await repository.updateProfile(send);
    if(response.status){
      emit(UpdatePasswordProfileSuccessState());
    }else{
      final error = response.data as ErrorResponseModel;
      emit(ErrorUpdatePasswordProfileState(error: error));
    }
  }

  Future<void> updateProfile(PasswordProfileUpdateSendModel send) async  {
    emit(LoginLoadingState());
    send.vToken = await localRepository.getAuthTokenProfile();
    final response = await repository.updateProfile(send);
    if(response.status){
      emit(UpdateProfileSuccessState(send.vPrefijo!, send.vTelefono!));
    }else{
      final error = response.data as ErrorResponseModel;
      emit(ErrorUpdatePasswordProfileState(error: error));
    }
  }

  Future<void> recodeEmailInit(RecodeAccountEmailSendModel send) async {
     try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vCorreo);
      final response = await repository.validEmailAccount(send);
      if (response.status) {
        emit(RecodeAccountEmailInitSuccessState());
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorRecodeAccountEmailState(error: error));
      }
    } catch (e) {
      //print(e);
      //emit(ErrorState());
    }
  }
  
  Future<void> recodeEmail(RecodeAccountEmailSendModel send, bool isResend) async {
     try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vCorreo);
      final response = await repository.validEmailAccount(send);
      if (response.status) {
        final data = response.data as RecodeAccountEmailResponseModel;
        emit(RecodeAccountEmailSuccessState( data, isResend));
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorRecodeAccountEmailState(error: error));
      }
    } catch (e) {
      //print(e);
      //emit(ErrorState());
    }
  }
  
  Future<void> validCodeEmail(ValidCodeEmailSendModel send) async {
     try {
      emit(LoginLoadingState());
      send.uiDTransacion = const Uuid().v5(Uuid.NAMESPACE_URL, send.vCorreo);
      final response = await repository.validEmailCode(send);
      if (response.status) {
        final data = response.data as ValidCodeEmailResponseModel;
        if (data.value!.bValidacion!) {
          emit(ValidCodeEmailSuccessState());
        } else {
          final valueError = ValueError(errorCode: 400, message: 'Código incorrecto');
          final list = <ValueError>[];
          list.add(valueError);
          final error = ErrorResponseModel(hasSucceeded: false, value: list, statusCode: 400);
          emit(ErrorValidCodeEmailState(error: error));
        }
      } else {
        final error = response.data as ErrorResponseModel;
        error.statusCode = response.statusCode;
        emit(ErrorValidCodeEmailState(error: error));
      }
    } catch (e) {
      //print(e);
      //emit(ErrorState());
    }
  }

}
