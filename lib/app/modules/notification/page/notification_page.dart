// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/provider/push_notification_provider.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';
import 'package:perubeca/app/modules/notification/bloc/notification_bloc.dart';
import 'package:perubeca/app/modules/notification/widget/notification_card.dart';
import 'package:perubeca/app/modules/notification/widget/title_card_notification.dart';
import 'package:perubeca/app/utils/constans.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  static Widget create(
    BuildContext context,
    GlobalKey<ScaffoldState>? scaffoldKey,
  ) {
    return NotificationPage(
      scaffoldKey: scaffoldKey,
    );
  }

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with WidgetsBindingObserver {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
    //context.read<NotificationStatusCubit>().clearNotificationStatus();
    WidgetsBinding.instance.addObserver(this);
    //clearAllNotifications();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose(); 
  }

  Future<void> clearAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Cuando la app vuelve al primer plano, recargamos las notificaciones
      getItApp<NotificationBloc>().add(GetNotificationDataLocalEvent());
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getItApp<NotificationBloc>().add(GetMoreNotificationsEvent());
    }
  }

  Future<bool> _onWillPop() async {
    getItApp<NotificationBloc>().add(MarkAllNotificationsAsReadEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationUpdateApiBloc, NotificationUpdateApiState>(
      listener: (context, state) {
        if(state is NotificationUpdateApiLoadingState){
          context.read<LoaderCubit>().showLoader();
        }

        if(state is NotificationUpdateApiLoadedState){
          context.read<LoaderCubit>().hideLoader();
          //getItApp<NotificationUpdateApiBloc>().add(const LoadNotificationsEvent());
          getItApp<NotificationBloc>().add(GetNotificationDataLocalEvent());
          getItApp<NotificationStatusCubit>().clearNotificationStatus();
          clearAllNotifications();
          //carga de notificaciones
        }

        if(state is NotificationUpdateApiLoadedState){
          context.read<LoaderCubit>().hideLoader();
          //error en la carga
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: BackgroundCommon(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  BackAppBardCommoMini(
                    ontap: () {
                      _onWillPop();
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  //title
                  Container(
                    width: (constraints.maxWidth > 1000)
                        ? MediaQuery.of(context).size.width * 0.47
                        : MediaQuery.of(context).size.width,
                    padding: (constraints.maxWidth > 1000)
                        ? const EdgeInsets.only(left: 40)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Notificaciones',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: ConstantsApp.OPBold,
                          fontWeight: FontWeight.bold,
                          color: ConstantsApp.textBluePrimary,
                        ),
                      ),
                      textScaler: TextScaler.linear(
                          (constraints.maxWidth > 1000) ? 2 : 1,),
                    ),
                  ),
                  // Cuerpo con las notificaciones
                  Expanded(
                    child: BodyPage(
                      constraints: constraints,
                      scrollController: _scrollController,
                    ),
                  ),
                  // Botón para obtener el token
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          final localSecureDbRepository =
                              getItApp.get<ILocalDataSecureDbRepository>();
                          final token =
                              await localSecureDbRepository.getPushToken();
                          await Clipboard.setData(
                            ClipboardData(
                              text: token.isEmpty
                                  ? 'EL TOKEN GENERADO DE FIREBASE NO EXISTE'
                                  : token,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Token copiado al portapapeles'),
                            ),
                          );
                        },
                        child: const Text('Obtener Push Token'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BodyPage extends StatelessWidget {
  const BodyPage({
    required this.constraints,
    required this.scrollController,
    super.key,
  });

  final BoxConstraints constraints;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoadLocalCompleteState) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: (constraints.maxWidth > 1000)
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.newNotifications.isEmpty &&
                      state.todayNotifications.isEmpty &&
                      state.earlierNotifications.isEmpty) ...[
                    const NoNotificationMessage(),
                  ],
                  if (state.newNotifications.isNotEmpty) ...[
                    TitleCardNotification(text: 'Nuevas'),
                    const SizedBox(height: 10),
                    ...state.newNotifications.map(
                      (notification) => NotificationCard(
                        title: notification.title,
                        description: notification.description,
                        timeAgo: getTimeAgo(notification.registerDate),
                        icon: Icons.campaign,
                        backgroundColor: !notification.isOpen
                            ? ConstantsApp.colorCardNotification
                            : ConstantsApp.colorReadCardNotification,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (state.todayNotifications.isNotEmpty) ...[
                    TitleCardNotification(text: 'Hoy'),
                    const SizedBox(height: 10),
                    ...state.todayNotifications.map(
                      (notification) => NotificationCard(
                        title: notification.title,
                        description: notification.description,
                        timeAgo: getTimeAgo(notification.registerDate),
                        icon: Icons.event,
                        backgroundColor: !notification.isOpen
                            ? ConstantsApp.colorCardNotification
                            : ConstantsApp.colorReadCardNotification,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (state.earlierNotifications.isNotEmpty) ...[
                    TitleCardNotification(text: 'Anteriores'),
                    const SizedBox(height: 10),
                    ...state.earlierNotifications.map(
                      (notification) => NotificationCard(
                        title: notification.title,
                        description: notification.description,
                        timeAgo: getTimeAgo(notification.registerDate),
                        icon: Icons.event,
                        backgroundColor: !notification.isOpen
                            ? ConstantsApp.colorCardNotification
                            : ConstantsApp.colorReadCardNotification,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          );
        } else if (state is NotificationInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No se encontraron notificaciones'));
        }
      },
    );
  }
}

class NoNotificationMessage extends StatelessWidget {
  const NoNotificationMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            right: MediaQuery.of(context).size.width * 0.2,
            child: Image.asset(
              ConstantsApp.imageGirl,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          const Positioned(
            bottom: 50,
            child: Text(
              'No tienes \nnotificaciones',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: ConstantsApp.OPRegular,
                color: ConstantsApp.colorBlackQuaternary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getTimeAgo(DateTime registerDate) {
  final difference = DateTime.now().difference(registerDate);

  if (difference.inSeconds < 60) {
    return 'Hace un momento';
  } else if (difference.inMinutes == 1) {
    return 'Hace un minuto';
  } else if (difference.inMinutes < 60) {
    return 'Hace ${difference.inMinutes} min';
  } else if (difference.inHours == 1) {
    return 'Hace una hora';
  } else if (difference.inHours < 24) {
    return 'Hace ${difference.inHours} horas';
  } else if (difference.inDays == 1) {
    return 'Hace un día';
  } else if (difference.inDays <= 7) {
    return 'Hace ${difference.inDays} días';
  } else if (difference.inDays <= 14) {
    return 'Hace una semana';
  } else {
    return '${registerDate.day} de ${_getMonthName(registerDate.month)}';
  }
}

String _getMonthName(int month) {
  const months = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre',
  ];
  return months[month - 1];
}
