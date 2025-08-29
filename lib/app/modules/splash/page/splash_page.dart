// ignore_for_file: use_super_parameters, lines_longer_than_80_chars, strict_raw_type, directives_ordering, unrelated_type_equality_checks, inference_failure_on_function_return_type, inference_failure_on_function_invocation, use_build_context_synchronously, cascade_invocations

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/model/api_response_model.dart';
import 'package:perubeca/app/common/model/notice_response_model.dart';
import 'package:perubeca/app/common/model/version_response_model2.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/service/util_service.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/common/widgets/version_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/database/entities/app_general_entity.dart';
import 'package:perubeca/app/database/entities/contacto_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/notification_entity.dart';
import 'package:perubeca/app/database/entities/prepare/notice_entity.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';
import 'package:perubeca/app/modules/splash/method_initial.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';

import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/utils/methods.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  final ILocalDataSecureDbRepository localSecureDbRepository = getItApp.get<ILocalDataSecureDbRepository>();
  final IAuthRepository authRepository = getItApp.get<IAuthRepository>();
  final internetConnection = CheckInternetConnection();
  late AnimationController animationController;
  late Animation<double> animation;
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    gotoPage();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
    context.read<LoginBloc>().add(LoginValidStatusEvent());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> isFirstInstalation() async {
    final tokenAuth = await localSecureDbRepository.getAuthToken();
    return tokenAuth.isEmpty;
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Future<APIResponseModel> getAuthToken() async {
    final response = await authRepository.getTokenAutorization();
    if (response.status) {
      final token = response.data as String;
      await localSecureDbRepository.setAuthToken(token);
    }
    return response;
  }


 Future<void> loadNotifications(BuildContext context) async {
    final bloc = getItApp<NotificationUpdateApiBloc>();
    final controller = StreamController<void>();
    // Crear la suscripción al stream
    final subscription = bloc.stream.listen((state) async {
      if (state is NotificationUpdateApiLoadedState) {
        print('Notificaciones cargadas exitosamente');
        
        final box = Hive.isBoxOpen('notificationBox')
            ? Hive.box<NotificationEntity>('notificationBox')
            : await Hive.openBox<NotificationEntity>('notificationBox');

        // Obtener las notificaciones y filtrar las no leídas
        final unreadNotifications = box.values
            .where((notification) => notification.isOpen != true)
            .toList();

        // Determinar el estado de las notificaciones
        getItApp<NotificationStatusCubit>().clearNotificationStatus();
        if (unreadNotifications.isNotEmpty) {
          getItApp<NotificationStatusCubit>().markAsNewNotification();
        }
        controller.add(null);
      } else if (state is NotificationUpdateApiErrorState) {
        print('Error al cargar las notificaciones');
        controller.add(null);
      }
    });

  bloc.add(const LoadNotificationsEvent());
  // Esperamos hasta que el flujo termine
  await controller.stream.first; // Esperamos el primer evento en el stream del controller

  // Finalmente, cerramos el controlador
  await controller.close();
  await subscription.cancel();
}

  Future<void> gotoPage() async {
    final modalidadbox = await Hive.openBox<ModalidadEntity>('modalidadBox');
    final internetStatus = await internetConnection.checkInternetConnectionInitApp();
    try {
       if (await isFirstInstalation()) {
        //eleminamos data que haya quedado pegado
        await localSecureDbRepository.deleteAllData();
        final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
        await profilebox.clear();
      }
    } catch (e) {
      final alert = DialogInformWidget(
        title: 'Información',
        message: e.toString(),
        ontap: () {
          Clipboard.setData(ClipboardData(text: e.toString()));
          Navigator.pop(context);
        },
      );

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    if (internetStatus == ConnectionStatus.offline && modalidadbox.values.isNotEmpty) {
      //lipiar las noticias
      final noticebox = await Hive.openBox<NoticeEntity>('noticeBox');
      await noticebox.clear();
      //Continuar con lo mismo de siempre
      await validFirstTimeAndRouting();
      return;
    }

    if (internetStatus == ConnectionStatus.offline && modalidadbox.values.isEmpty) {
      // carga de datos locales de los json
       await registerUpdateDataLocal();
      //mensaje de necesita conectarse a internet para poder continuar // mensaje de internet por primera vez
      //UtilCommon().noInternetNoDataModal(context: context, visibleMessage: true);
      //return;
    }else{

      final authResponse = await getAuthToken();
      final contactobox = await Hive.openBox<ContactoEntity>('contactBox');
      final listContact = contactobox.values.toList();
      final tokenAuth = await localSecureDbRepository.getAuthToken();

      if ((authResponse.status || tokenAuth.isNotEmpty) || listContact.isNotEmpty) {
        final utilService = getItApp.get<UtilService>();
        final send = await utilService.getDeviceInfo();
        final ptoke = await localSecureDbRepository.getPushToken();
        send.tokenPushNoti = ptoke.isEmpty ? 'EL TOKEN GENERADO DE FIREBASE NO EXISTE' : ptoke;
        //llamada al listado de notificaciones del api
        //getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
        await loadNotifications(context);

        if (internetStatus == ConnectionStatus.online) {
          await registerNoticeApp(utilService);
          final response = await utilService.getVersionApp(send);
          if (response.status) {
            final versionData = response.data as VersionResponseModel2;
            final currentVersion = await utilService.getAppCurrentVersion();
            final currentDataVersion = await utilService.getAppCurrentDataApp();

            //validacion de version del aplicativo
            if (Platform.isAndroid && !versionData.value!.registros!.first.versionApp!.contains(currentVersion)) {
              //llevar a la tienda correspondiente para actualizar la app
              versionModal();
              return;
            }

            if (Platform.isIOS && !versionData.value!.registros!.first.versionAppIOS!.contains(currentVersion)) {
              versionModal();
              return;
            }

            //validacion de si tenemos data actualizada

            if (listContact.isEmpty ||
                currentDataVersion == null ||
                currentDataVersion.versionCont != versionData.value!.registros!.first.versionCont) {
              //print('actualizar data o cargar data inicial');
              await registerUpdateData(versionData);
              return;
            }

            //continuar con lo de siempre
            await validFirstTimeAndRouting();
          } else {
            showErrors(response);
          }
        } else {
          await validFirstTimeAndRouting();
        }
      } else {
        showErrors(authResponse);
      }
    }
  }

  void showErrors(APIResponseModel response) {
    if (response.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
      // mosdtrar modal de no hay internet
      UtilCommon().noInternetNoDataModal(context: context, visibleMessage: true);
      return;
    }
    if (response.statusCode < 900) {
      //mostrar mensaje de servidor
      UtilCommon().erroServerModal(
        context: context,
        ontap: () async {
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      );
      return;
    }
  }

  Future<void> validFirstTimeAndRouting() async {
    final appGeneralbox = await Hive.openBox<AppGeneralEntity>('generalBox');
    final generalList = appGeneralbox.values.toList();
    if (generalList.isEmpty) {
      await appGeneralbox.add(AppGeneralEntity(firstTime: '1'));
      await appGeneralbox.close();
      if (mounted) await Navigator.pushReplacementNamed(context, RoutesApp.info);
    } else {
      await appGeneralbox.close();
      if (mounted) await Navigator.pushReplacementNamed(context, RoutesApp.home);
    }
  }

  Future<void> registerUpdateData(VersionResponseModel2 version) async {
    //ya tenemos el servicio creado, hacer un refactor
    final methodInitial =  MethodInitial();
    await loadDataLocalInitalPrepareExam();
    final response = await methodInitial.loadDataLocalInital(version);
    //continuar con lo de siempre
    if (response.status) {
      //await Navigator.pushReplacementNamed(context, RoutesApp.info);
      await validFirstTimeAndRouting();
    } else {
      showErrors(response);
    }
  }

  Future<void> registerUpdateDataLocal() async {
    //ya tenemos el servicio creado, hacer un refactor
    final methodInitial =  MethodInitial();
    await methodInitial.loadDataJsonLocal();
    await validFirstTimeAndRouting();
  }
  

  Future<void> registerNoticeApp(UtilService utilService) async {
    final noticebox = await Hive.openBox<NoticeEntity>('noticeBox');
    await noticebox.clear();
    final responseNotice = await utilService.getNoticeApp();
    if (responseNotice.status) {
      final dataNotice = responseNotice.data as NoticeResponseModel;
      final listEntity = <NoticeEntity>[];

      for (final model in dataNotice.value!) {
        final entity = NoticeEntity(
          codigo: model.codigo,
          contenido: model.contenido,
          estado: model.estado,
          titulo: model.titulo,
        );

        listEntity.add(entity);
      }
      await noticebox.addAll(listEntity);
    }
  }

  void versionModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const VersionWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: ConstantsApp.boxRadialDecorationPrimary,
            ),
            SizedBox.expand(
              child: Image.asset(
                ConstantsApp.backgroundIcon,
                fit: BoxFit.cover,
              ),
            ),
            // Center(
            //   child: SvgPicture.asset(
            //     ConstantsApp.logoIcon,
            //     height: 50,
            //   ),
            // ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: animation.value,
                  child: Center(
                    child: SvgPicture.asset(
                      ConstantsApp.logoIcon,
                      height: 50,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 80,
              child: Column(
                children: [
                  Text(
                    'Version ${packageInfo.version}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
