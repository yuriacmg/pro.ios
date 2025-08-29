// ignore_for_file: lines_longer_than_80_chars, strict_raw_type, directives_ordering
import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/app_web_view.dart';
import 'package:perubeca/app/modules/home/page/home_page.dart';
import 'package:perubeca/app/modules/info/page/info_page.dart';
import 'package:perubeca/app/modules/contact/page/contact_page.dart';
import 'package:perubeca/app/modules/history/page/history_page.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_response_model.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/page/code_page.dart';
import 'package:perubeca/app/modules/login/page/code_recovery_page.dart';
import 'package:perubeca/app/modules/login/page/code_revalidar_page.dart';
import 'package:perubeca/app/modules/login/page/login_page.dart';
import 'package:perubeca/app/modules/login/page/profile_page.dart';
import 'package:perubeca/app/modules/login/page/recovery_page.dart';
import 'package:perubeca/app/modules/login/page/recovery_password_page.dart';
import 'package:perubeca/app/modules/login/page/register_page.dart';
import 'package:perubeca/app/modules/notification/page/notification_page.dart';
import 'package:perubeca/app/modules/question/page/question_page.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three_details.dart';
import 'package:perubeca/app/modules/scholarship/page/scholarship_page.dart';
import 'package:perubeca/app/modules/splash/page/splash_page.dart';
import 'package:perubeca/app/modules/splash/page/splash_web_page.dart';
import 'package:perubeca/app/modules/start/page/start_page.dart';

class RoutesApp {
  static const splash = '/';
  static const login = '/login';
  static const profile = '/profile';
  static const register = '/register';
  static const recovery = '/recovery';
  static const code = '/code';
  static const codeRecovery = '/code-recovery';
  static const codeRevalid = '/code-revalid';
  static const recoveryPassword = '/recovery-password';
  static const info = '/info';
  static const home = '/home';
  static const start = '/start';
  static const scholarship = '/scholarship';
  static const scholarshipPageThreeDetail = '/scholarship-detail';
  static const history = '/history';
  static const contact = '/contact';
  static const webview = '/webview';
  static const notification = '/notification';
  static const question = '/question';

  static Route routesMobil(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case info:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const InfoPage(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case home:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const HomePage(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case start:
        return MaterialPageRoute(builder: (_) => StartPage());
      case scholarship:
        return MaterialPageRoute(builder: (_) => ScholarshipPage());
      case scholarshipPageThreeDetail:
        return MaterialPageRoute(
            builder: (context) =>
                PageThreeDetail(send: args! as SendModelDetail));
      case webview:
        return MaterialPageRoute(
            builder: (context) => AppWebView(url: args! as String));
      case history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case contact:
        return MaterialPageRoute(
            builder: (context) => ContactPage.create(context, null));
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case recovery:
        return MaterialPageRoute(builder: (context) => const RecoveryPage());
      case code:
        return MaterialPageRoute(
            builder: (context) =>
                CodePage(register: args! as RegisterAccountSendModel));
      case codeRecovery:
        return MaterialPageRoute(
            builder: (context) => CodeRecoveryPage(
                model: args! as RecoveryPasswordResponseModel));
      case codeRevalid:
        return MaterialPageRoute(
            builder: (context) => CodeRevalidarPage(
                recodeSend: args! as RecodeAccountEmailSendModel));
      case profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case recoveryPassword:
        return MaterialPageRoute(
            builder: (context) =>
                RecoveryPasswordPage(registerId: args! as int));
      case notification:
        return MaterialPageRoute(
            builder: (context) => NotificationPage.create(context, null));
      case question:
        return MaterialPageRoute(
            builder: (context) => QuestionPage.create(context, null));
    }
    throw Exception('This route does not exists');
  }

  static Route routesWeb(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashWebPage());

      case info:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const InfoPage(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case home:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const HomePage(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );

      case start:
        return MaterialPageRoute(builder: (_) => StartPage());
      case scholarship:
        return MaterialPageRoute(builder: (_) => ScholarshipPage());
      case scholarshipPageThreeDetail:
        return MaterialPageRoute(
          builder: (context) => PageThreeDetail(send: args! as SendModelDetail),
        );
      case history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case contact:
        return MaterialPageRoute(
            builder: (context) => ContactPage.create(context, null));
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case recovery:
        return MaterialPageRoute(builder: (context) => const RecoveryPage());
      case code:
        return MaterialPageRoute(
            builder: (context) =>
                CodePage(register: args! as RegisterAccountSendModel));
      case codeRecovery:
        return MaterialPageRoute(
            builder: (context) => CodeRecoveryPage(
                model: args! as RecoveryPasswordResponseModel));
      case codeRevalid:
        return MaterialPageRoute(
            builder: (context) => CodeRevalidarPage(
                recodeSend: args! as RecodeAccountEmailSendModel));
      case profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case recoveryPassword:
        return MaterialPageRoute(
            builder: (context) =>
                RecoveryPasswordPage(registerId: args! as int));
    }
    throw Exception('This route does not exists');
  }

  PageRouteBuilder transitionOpacity(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    );
  }
}
