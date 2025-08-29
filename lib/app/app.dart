// ignore_for_file: lines_longer_than_80_chars, cascade_invocations, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/common/navigation_app/cubit/notice_cubit.dart';
import 'package:perubeca/app/common/provider/push_notification_provider.dart';
import 'package:perubeca/app/common/widgets/custom_loader2.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/config/theme_app.dart';
import 'package:perubeca/app/modules/history/bloc/history_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/code_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/profile_bloc.dart';
import 'package:perubeca/app/modules/notification/bloc/notification-update-api/notification_update_api_bloc.dart';
import 'package:perubeca/app/modules/notification/bloc/notification_bloc.dart';
import 'package:perubeca/app/modules/question/bloc/pregunta_frecuente_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/bottom_sheet_bloc/bottom_sheet_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/email_bloc/email_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/enlace_relacionado_bloc/enlace_relacionado_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/option_bloc/option_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/other_country_bloc/other_country_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/prepare_exam/prepare_exam_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/procesar_data_bloc/procesar_data_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/reniec_bloc/reniec_review_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/report_bloc/report_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/scholarship_bloc/scholarship_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/search_bloc/filter_cubit.dart';
import 'package:perubeca/app/modules/scholarship/bloc/search_bloc/search_bloc.dart';

final GetIt getItApp = GetIt.instance;

//cambiar este valor a true para hacer pruebas de crashlitytics
const _kShouldTestAsyncErrorOnInit = false;
const _kTestingCrashlytics = true;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>{
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observerAnalitics =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
    _initializeFlutterFire();
    //iniNotification();//notificaciones
  }

  Future<void> iniNotification() async{
    final pushProvider = PushNotificationProvider();
    await pushProvider.initNotifications(context);
    await pushProvider.processStoredNotifications();
  }

  Future<void> _testAsyncErrorOnInit() async {
    Timer(
      const Duration(seconds: 15),
      () => FirebaseCrashlytics.instance.crash(),
    );
  }

  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoaderCubit()),
        BlocProvider(create: (context) => ScholarshipBloc()),
        BlocProvider(create: (context) => ReniecReviewBloc()),
        BlocProvider(create: (context) => ReportBloc()),
        BlocProvider(create: (context) => ProcesarDataBloc()),
        BlocProvider(create: (context) => EmailBloc()),
        BlocProvider(create: (context) => OptionBloc()),
        BlocProvider(create: (context) => PrepareExamBloc()),
        BlocProvider(create: (context) => NoticeCubit()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => CodeBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => HistoryBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => BottomSheetBloc()),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => OtherCountryBloc()),
        BlocProvider(create: (context) => EnlaceRelacionadoBloc()),
        BlocProvider(create: (context) => PreguntaFrecuenteBloc()),
        //BlocProvider(create: (context) => NotificationBloc()),
        //BlocProvider(create: (context) => NotificationUpdateApiBloc()),
        BlocProvider<NotificationStatusCubit>.value(value: getItApp<NotificationStatusCubit>()),
        BlocProvider<NotificationBloc>.value(value: getItApp<NotificationBloc>()),
        BlocProvider<NotificationUpdateApiBloc>.value(value: getItApp<NotificationUpdateApiBloc>()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'PRONABEC',
            theme: ThemeApp().light,
            onGenerateRoute: kIsWeb ? RoutesApp.routesWeb : RoutesApp.routesMobil,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('es', ''),
            ],
            locale: const Locale('es'),
            builder: (context, child) {
              return Stack(
                children: [
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(MediaQuery.of(context).textScaleFactor.clamp(
                                1.0,
                                1.2,
                              ),),
                    ),
                    child: child!,
                  ),
                  BlocBuilder<LoaderCubit, bool>(
                    builder: (context, state) {
                      if (state) {
                        return CustomLoader2();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              );
            },
            navigatorObservers: <NavigatorObserver>[observerAnalitics],
            // routingCallback: (routing) {
            //   MethodsApp().registerPageAnalytics(routing!.current);
            // },
          );
        },
      ),
    );
  }
}
