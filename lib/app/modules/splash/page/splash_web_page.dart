// ignore_for_file: inference_failure_on_function_invocation, use_build_context_synchronously, lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/notice_response_model.dart';
import 'package:perubeca/app/common/model/version_response_model2.dart';
import 'package:perubeca/app/common/repository/auth/i_auth_repository.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/service/util_service.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/prepare/notice_entity.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/splash/method_initial.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashWebPage extends StatefulWidget {
  const SplashWebPage({super.key});

  @override
  State<SplashWebPage> createState() => _SplashWebPageState();
}

class _SplashWebPageState extends State<SplashWebPage> with SingleTickerProviderStateMixin {
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

  // OverlayEntry? _overlayEntry;

  @override
  void initState() {
    gotoPage();
    super.initState();
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

  Future<bool> getAuthToken() async {
    final localToken = await localSecureDbRepository.getAuthToken();
    if (localToken.isEmpty) {
      final authResponse = await authRepository.getTokenAutorization();
      final token = authResponse.data as String;
      await localSecureDbRepository.setAuthToken(token);
      return true;
    } else {
      //validamos si el token es valido

      //validamos si tenemos internet

      //si no es valido lo volvemos a llamar y lo cargamos
      return true;
    }
  }

  Future<void> gotoPage() async {
    final modalidadbox = await Hive.openBox<ModalidadEntity>('modalidadBox');
    final internetStatus = await internetConnection.checkInternetConnectionInitApp();

    if(await isFirstInstalation()){
      //eleminamos data que haya quedado pegado
      final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
      await profilebox.clear();
    }

    if (internetStatus == ConnectionStatus.offline && modalidadbox.values.isEmpty) {
      //mensaje de necesita conectarse a internet para poder continuar
      UtilCommon().noInternetNoDataModal(context: context);
      return;
    }

    await getAuthToken();

    final utilService = getItApp.get<UtilService>();
    final send = await utilService.getDeviceInfo();

    if (internetStatus == ConnectionStatus.online) {
      await registerNoticeApp(utilService);
      final response = await utilService.getVersionApp(send);
      if (response.status) {
        final versionData = response.data as VersionResponseModel2;
        final currentVersion = await utilService.getAppCurrentVersion();
        final currentDataVersion = await utilService.getAppCurrentDataApp();

        if (!kIsWeb) {
          if (Platform.isAndroid && !versionData.value!.registros!.first.versionApp!.contains(currentVersion)) {
            //llevar a la tienda correspondiente para acutalizar la app
            versionModal();
            return;
          }

          if (Platform.isIOS && !versionData.value!.registros!.first.versionAppIOS!.contains(currentVersion)) {
            versionModal();
            return;
          }
        }
        //validacion de version del aplicativo

        //validacion de si tenemos data actualizada
        if (currentDataVersion == null || currentDataVersion.versionCont != versionData.value!.registros!.first.versionCont) {
          //print('actualizar data o cargar data inicial');
          await registerUpdateData(versionData);
          return;
        }

        //continuar con lo de siempre
        if (mounted) await Navigator.pushReplacementNamed(context, RoutesApp.home);
      } else {
        if (response.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
          // mosdtrar modal de no hay internet
          UtilCommon().noInternetNoDataModal(context: context);
        }
        if (response.statusCode >= getAppStatusCodeError(AppStatusCode.SERVER) && response.statusCode < 900) {
          //mostrar mensaje de servidor
          UtilCommon().erroServerModal(context: context);
        }
      }
    } else {
      if (mounted) await Navigator.pushReplacementNamed(context, RoutesApp.home);
    }
  }

  Future<void> registerUpdateData(VersionResponseModel2 version) async {
    //ya tenemos el servicio creado, hacer un refactor
    final methodInitial =  MethodInitial();
    await methodInitial.loadDataLocalInital(version);
    await loadDataLocalInitalPrepareExam();
    //methodInitial.callIsolate();
    //continuar con lo de siempre
    await Navigator.pushReplacementNamed(context, RoutesApp.home);
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
        return WillPopScope(
          onWillPop: () async {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return true;
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset(
                          ConstantsApp.peluchinUpdate,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Nueva actualización disponible',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ConstantsApp.textBluePrimary,
                            fontFamily: ConstantsApp.OPBold,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: Text(
                          'Una nueva versión de la aplicación se descargará e instalará.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ConstantsApp.colorBlackSecondary,
                            fontFamily: ConstantsApp.QSMedium,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottonCenterWidget(
                  ontap: () async {
                    final url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.app.pronabec&hl=es'
                        : 'https://apps.apple.com/us/app/pronabec/id1640302895';

                    final uri = Uri.parse(url);

                    try {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      // print("");
                    }
                  },
                  text: 'Ir a',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void noInternetNoDataModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return true;
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset(
                          ConstantsApp.peluchinNoInternet,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Sin conexión a internet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ConstantsApp.textBluePrimary,
                            fontFamily: ConstantsApp.OPBold,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: Text(
                          'Comprueba tu conexión  Wi-Fi o de datos móbiles. Por favor, verifica y vuelva a intentar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ConstantsApp.colorBlackSecondary,
                            fontFamily: ConstantsApp.QSMedium,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottonCenterWidget(
                  ontap: () async {
                    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  text: 'Entendido',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(color: ConstantsApp.purpleTerctiaryColor);
  }
}
