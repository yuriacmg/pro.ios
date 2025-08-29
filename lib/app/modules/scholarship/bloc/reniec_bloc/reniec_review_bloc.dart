// ignore_for_file: invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars, cascade_invocations, sdk_version_since

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/database/entities/data_reniec_review_sign_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_hijo_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_pregunta_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/prepare_examen_init_data_response_model2.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_performance_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_prepare_exam_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_review_sign_response_model.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/repository/i_scholarship_repository.dart';
import 'package:perubeca/app/utils/constans.dart';

part 'reniec_review_event.dart';
part 'reniec_review_state.dart';

class ReniecReviewBloc extends Bloc<ReniecReviewEvent, ReniecReviewState> {
  ReniecReviewBloc() : super(const ReniecReviewInitialState()) {
    on<ReniecReviewEvent>((event, emit) {});
  }

  final scholarshipRepository = getItApp.get<IScholarshipRepository>();

  Future<void> getUserReniecFirma(ReniecSendModel send) async {
    emit(const ReniecReviewLoadingState());
    final response = await scholarshipRepository.searchUserReniecFirma(send);
    if (response.status) {
      final model = response.data as ReniecReviewSignResponseModel;
      //guardar en base de datos
      final reniecDatabox = await Hive.openBox<DataReniecReviewSignEntity>('dataReniecViewBox');

      await reniecDatabox.clear();
      await reniecDatabox.add(
        DataReniecReviewSignEntity(
          apeMaterno: model.value!.apeMaterno,
          apePaterno: model.value!.apePaterno,
          fecNacimiento: model.value!.fecNacimiento,
          nombre: model.value!.nombre,
          nombreCompleto: model.value!.nombreCompleto,
          sexo: model.value!.sexo,
          numdoc: model.value!.numdoc,
          concurso: model.value!.concurso,
          fecPostulacion: model.value!.fecPostulacion,
          modalidad: model.value!.modalidad,
        ),
      );
      //emit(const ReniecReviewInitialState());
      emit(ReniecReviewLoadCompleteState(model));
    } else {
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> getUserReniecPrepareExam(ReniecPrepareSendModel send) async {
    emit(const ReniecReviewLoadingState());
    final response = await scholarshipRepository.searchUserReniecPrepareExam(send);
    if (response.status) {
      final model = response.data as ReniecPrepareExamResponseModel;

      //guardar usuario que realiza la busqueda
      await addUpdatePrepareUserUser(model);

      //guardar en base de datos
      final prepareAreabox = await Hive.openBox<PrepareAreaEntity>('prepareAreaBox');
      final prepareAreaHijobox = await Hive.openBox<PrepareAreaHijoEntity>('prepareAreaHijoBox');
      // listado de informacion en array
      final list = <PrepareAreaEntity>[];
      final listHijos = <PrepareAreaHijoEntity>[];
      for (final s in model.value!.preparate!) {
        list.add(
          PrepareAreaEntity(
            codigo: s.codigo,
            enlaceLogo: s.enlaceLogo,
            nombre: s.nombre,
            orden: s.orden,
            enlaceLogoOffline: s.enlaceLogoOffline,
          ),
        );

        for(final h in s.preparateHijos!){
          listHijos.add(
          PrepareAreaHijoEntity(
            codigo: h.codigo,
            codigoPadre: s.codigo,
            enlaceLogo: h.enlaceLogo,
            nombre: h.nombre,
            orden: h.orden,
            enlaceLogoOffline: h.enlaceLogoOffline,
          ),
        );
        }
      }
      await prepareAreabox.clear();
      await prepareAreabox.addAll(list);

      await prepareAreaHijobox.clear();
      await prepareAreaHijobox.addAll(listHijos);

      //carga de datos iniciales para prepareExamn
      await getDataInitPrepareExam(model); // solo por ahora la carga se hace en aqui
      //emit(ReniecPrepareExamLoadCompleteState(model));
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel, isSpecial: true));
    }
    if (kDebugMode) {
      //print(data);
    }
  }

  Future<void> addUpdatePrepareUserUser(ReniecPrepareExamResponseModel model) async {
    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    final user = PrepareUserEntity(
      apeMaterno: model.value!.apeMaterno,
      apePaterno: model.value!.apePaterno,
      fecNacimiento: model.value!.fecNacimiento,
      nombre: model.value!.nombre,
      nombreCompleto: model.value!.nombreCompleto,
      numdoc: model.value!.numdoc,
      sexo: model.value!.sexo,
      status: true,
    );
    // Obtener todos los usuarios
    final listUsers = prepareUserBox.values.toList();

    // Verificar si el usuario ya existe
    final existingUser = listUsers.where((user) => user.numdoc == model.value!.numdoc).firstOrNull;

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

    await activatePrepareUser(model.value!.numdoc!);
  }

  Future<void> activatePrepareUser(String doc) async {
    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    final users = prepareUserBox.values.toList();
    for (final user in users) {
      user.status = user.numdoc == doc;
    }

    await prepareUserBox.clear();
    await prepareUserBox.addAll(users);
  }

  Future<void> validUserPrepareExist(String doc) async {
    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    // Obtener todos los usuarios
    final listUsers = prepareUserBox.values.toList();

    // Verificar si el usuario ya existe
    final existingUser = listUsers.where((user) => user.numdoc == doc).firstOrNull;

    if (existingUser != null) {
      //actualizar
      await activatePrepareUser(doc);
      emit(const ReniecPrepareExamLoadCompleteState());
    } else {
      final value = ValueError(
        errorCode: 707,
        message: 'Si estás ingresando por primera vez, debes de conectarte a Internet para que puedas descargar el contenido de Prepárate.',
      );
      final error = ErrorResponseModel(
        hasSucceeded: false,
        statusCode: 707,
        value: [value],
      );
      emit(ErrorState(error: error));
    }
  }

  Future<void> getDataInitPrepareExam(ReniecPrepareExamResponseModel data) async {
    final response = await scholarshipRepository.getDataInitPrepareExam();
    if (response.status) {
      final model = response.data as PrepareExamInitDataResponseModel2;
      //guardar en base de datos

      final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
      // final prepareAreaInterestbox = await Hive.openBox<PrepareAreaInterestEntity>('prepareAreaInterestBox');
      final preparePreguntabox = await Hive.openBox<PreparePreguntaEntity>('preparePreguntaBox');
      final prepareAlternativebox = await Hive.openBox<PrepareAlternativeEntity>('prepareAlternativeBox');
      // listado de informacion en array
      final listQuestion = <PreparePreguntaEntity>[];
      final listalternative = <PrepareAlternativeEntity>[];
      final listCommon = <PrepareAreaCommonEntity>[];
      // final listInterest = <PrepareAreaInterestEntity>[];

      for (final s in model.value!.preparate!) {
        for (final c in s.contenido!) {
          //area
          listCommon.add(
            PrepareAreaCommonEntity(
              codigo: c.codigo,
              enlaceLogo: c.enlaceLogo,
              nombre: c.nombre,
              orden: c.orden,
              nroPregunta: c.nroPregunta,
              status: ConstantsApp.areaInitial,
              codigoPreparate: c.codigoPreparate,
              enlaceLogoOffline: c.enlaceLogoOffline,
            ),
          );
          //question
          for (final q in c.preguntas!) {
            //questions
            listQuestion.add(
              PreparePreguntaEntity(
                preguntaId: q.preguntaId,
                pregunta: q.pregunta,
                comentarios: q.comentarios,
                enlaceImagen: q.enlaceImagen,
                orden: q.orden,
                respuesta: q.respuesta,
                codigoCourse: c.codigoPreparate,
                simulacroId: c.codigo,
                tipo: q.tipo,
                preguntaPadreId: q.preguntaPadreId,
                area: q.area,
                comentarioOffline: q.comentarioOffline,
                enlaceImagenOffline: q.enlaceImagenOffline,
                preguntaOffline: q.preguntaOffline,
              ),
            );

            if (q.alternativas != null) {
              //alternative
              for (final a in q.alternativas!) {
                listalternative.add(
                  PrepareAlternativeEntity(
                    alternativa: a.alternativa,
                    alternativaId: a.alternativaId,
                    codigo: a.codigo,
                    enlaceImagen: a.enlaceImagen,
                    preguntaId: a.preguntaId,
                    type: a.type,
                    typeAlternativa: a.typeAlternativa,
                    alternativaOffline: a.alternativaOffline,
                    enlaceImagenOffline: a.enlaceImagenOffline,
                    typeAlternativaOffline: a.typeAlternativaOffline,
                  ),
                );
              }
            }
          }
        }
      }

      //common
      await prepareAreaCommonbox.clear();
      await prepareAreaCommonbox.addAll(listCommon);

      //question
      await preparePreguntabox.clear();
      await preparePreguntabox.addAll(listQuestion);
      //alternative
      await prepareAlternativebox.clear();
      await prepareAlternativebox.addAll(listalternative);

      //esta parte se debe quitar cuando se valide en que momento se hace la carga de la informacion
      emit(const ReniecPrepareExamLoadCompleteState()); //data
    } else {
      final error = response.data as ErrorResponseModel;
      error.statusCode = response.statusCode;
      emit(ErrorState(error: response.data as ErrorResponseModel));
    }
  }

  void initialState() {
    emit(const ReniecReviewInitialState());
  }
}
