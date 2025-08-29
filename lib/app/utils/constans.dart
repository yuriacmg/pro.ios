// ignore_for_file: lines_longer_than_80_chars, constant_identifier_names, prefer_single_quotes

import 'package:flutter/material.dart';

class ConstantsApp {
  //view data
  static const loginView = false;
  static const viewSyncHistoryError = false;
  //colors
  static const primaryColor = Color.fromARGB(255, 34, 125, 209);
  static const buttonColorPrimary = Color.fromRGBO(20, 135, 173, 0.4);
  static const buttonColorSecondary = Color.fromRGBO(141, 26, 26, 0.4);
  static const buttonColorTertiary = Color.fromRGBO(67, 201, 85, 0.4);

  static const purplePrimaryColor = Color(0xffB12579);
  static const purpleSecondaryColor = Color(0xff542B6A);
  static const purpleTerctiaryColor = Color(0xff692A6D);
  static const blueTertiaryColor = Color(0xff056DA1);
  static const blueBorderColor = Color(0xffB2C8DE);

  static const whitePrimaryColor = Color(0xffFFFCF9);
  static const whiteSecondaryColor = Color(0xffFFFEFD);

  static const textBlackPrimary = colorBlackPrimary;
  static const textBlackSecondary = Color(0xff575757);
  static const textBlackTertiary = Color.fromRGBO(179, 180, 180, 0.4);
  static const textBlackQuaternary = Color(0xff343434);
  static const textBluePrimary = Color(0xff083E6B);
  static const textBlueSecondary = Color(0xff1B81DD);
  static const bluePrimary = Color(0xff004A92);

  static const Color colorBlackPrimary = Color(0xff555452);
  static const Color colorBlackSecondary = Color(0xff6E6C6D);
  static const Color colorBlackTerciary = Color(0xffA6A6A6);
  static const Color colorBlackQuaternary = Color(0xffB6B6B6);
  static const Color colorBlackInput = Color(0xffEDEEF0);
  static const Color colorBlackInputHidden = Color(0xffD5D5D5);
  static const Color colorCardNotification = Color(0xffE0F1FF);
  static const Color colorReadCardNotification = Color(0xffEFF5FC);

  static const barrierColor = Color.fromRGBO(112, 112, 122, 0.6);
  static const ShadowColor = Color.fromRGBO(0, 0, 0, 0.08);

  // card colors
  static const cardBGColor = Color(0xffEDF5FD);
  static const cardBorderColor = Color(0xffEDF5FD);

  static const BoxDecoration boxRadialDecorationPrimary = BoxDecoration(
    gradient: RadialGradient(
      radius: 2.8,
      colors: [purplePrimaryColor, purpleSecondaryColor],
    ),
  );

  static const BoxDecoration boxRadialDecoratioBottonBorderPrimary =
      BoxDecoration(
    gradient: RadialGradient(
      radius: 2.8,
      colors: [purplePrimaryColor, purpleSecondaryColor],
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
  );

  static BoxDecoration boxLinearVerticalDecorationPrimary = BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [purplePrimaryColor, purpleSecondaryColor],
    ),
  );

  //status area
  static const int areaInitial = 1;
  static const int areaProcess = 2;
  static const int areaCompleted = 3;

  //values for find scholarship
  static const idQuestionPrimary = 150001;
  static const listOptionExeption = [
    240001,
    240002,
    240003,
    240048,
    240047,
  ]; //secundaria incompleta, primaria incompleta, los dos ultimos
  static const idQuestionHide = 150014;

  static const listModIdEspecial = [200011, 200013];

  //contact
  static const String messageWhatsapp = "Hola Pronabec";
  static const String messageShared = "Te invito al evento de pronabec ";
  static const String pageIdPronabec = '246774195459798';
  static const String cellPhoneIcon = 'assets/contact/tablet.svg';

  //images general
  static String logoApp = 'assets/logo.app';
  static String iconAdd = 'assets/icons/add.png';
  static String iconDelete = 'assets/icons/delete.png';
  static String iconSend = 'assets/icons/send.png';
  static String logo = 'assets/logo.svg';
  static String logoPronabec = 'assets/logo-pronabec.png';
  static String fondoApp = 'assets/fondo.png';
  static String fondoAppWeb = 'assets/fondo-web.png';
  static String peluchin = 'assets/peluchin.png';
  static String peluchinNoInternet = 'assets/peluchin-no-internet.svg';
  static String peluchinUpdate = 'assets/peluchin-update.svg';

  //starpage
  static String startScholarshipIcon = 'assets/start/becas.svg';
  static String startContactIcon = 'assets/start/contacto.svg';
  static String startHistoryIcon = 'assets/start/historial.svg';

  static String startScholarshipIconPng = 'assets/start/becas.png';
  static String startContactIconPng = 'assets/start/contacto.png';
  static String startHistoryIconPng = 'assets/start/history.png';
  static String startQAIconPng = 'assets/start/QA.png';

  static String startFinds2025 = 'assets/start/Encuentra2.png';
  static String startGetReady2025 = 'assets/start/Preparate2.png';
  static String startContact2025 = 'assets/start/Contacto2.png';
  static String startAsked2025 = 'assets/start/Preguntas2.png';

  //scholarship
  static String smileIcon = 'assets/scholarship/3.png';
  static String surpriseIcon = 'assets/scholarship/1.png';
  static String seriusIcon = 'assets/scholarship/2.png';
  static String atIcon = 'assets/scholarship/at.png';
  static String dniA = 'assets/scholarship/dni-a.svg';
  static String dniE = 'assets/scholarship/dni-e.svg';
  static String dniE2 = 'assets/scholarship/dni-e.png';
  static String noData = 'assets/scholarship/no-data.png';
  static String email = 'assets/email.png';
  //zero
  static String zeroEncuentraIcon = 'assets/scholarship/zero/encuentra.png';
  static String zeroExamenIcon = 'assets/scholarship/zero/examen.png';
  static String zeroPostulacionIcon = 'assets/scholarship/zero/postulacion.png';
  static String zeroRendimientoIcon = 'assets/scholarship/zero/rendimiento.png';
  static String zeroViewFichaIcon = 'assets/scholarship/zero/view_ficha.png';
  static String zeroWorldIcon = 'assets/scholarship/zero/world.png';
  static String zerSearchIcon = 'assets/scholarship/zero/buscador.png';
  //view-sign
  static String viewSignAsistenteIcon =
      'assets/scholarship/view-sign/asistente.png';
  static String viewSignFirmaIcon = 'assets/scholarship/view-sign/firma.png';
  //syllabus
  static String syllabusCard1 = 'assets/scholarship/syllabus/card1.png';
  static String syllabusCard2 = 'assets/scholarship/syllabus/card2.png';

  //splash
  static String mapIcon = 'assets/splash/map.svg';
  static String espiralIcon = 'assets/splash/espiral.svg';
  static String logoIcon = 'assets/splash/logo.svg';
  static String backgroundIcon = 'assets/splash/background.png';

  //info
  static String oneIcon = 'assets/info/one.png';
  static String twoIcon = 'assets/info/two.png';
  static String fourIcon = 'assets/info/four.png';
  //menu
  static String startIcon = 'assets/menu/home.svg';
  static String scholarshipIcon = 'assets/menu/beca.svg';
  static String historyIcon = 'assets/menu/historial.svg';
  static String contatIcon = 'assets/menu/contacto.svg';
  static String questionIcon = 'assets/menu/historial.svg';
  //start
  static String logogroupIcon = 'assets/start/logo-group.png';
  //static String backgroundIcon = 'assets/start/back.svg';
  //static String groupIcon = 'assets/start/hijo.png';
  static String groupIcon = 'assets/start/fondo.png';

  //enlace relacionado
  static String certificadoImage = 'assets/scholarship/enlace_relacionado/certificado.png';
  static String codigoModImage = 'assets/scholarship/enlace_relacionado/codigomod.png';
  static String compromisoImage = 'assets/scholarship/enlace_relacionado/compromiso.png';
  static String constanciaImage = 'assets/scholarship/enlace_relacionado/constancia.png';
  static String ruvImage = 'assets/scholarship/enlace_relacionado/ruv.png';
  static String sisfohImage = 'assets/scholarship/enlace_relacionado/sisfoh.png';

  static String arrowSharedImage = 'assets/arrow_shared.png';
  static String resultadoCourseSharedImage = 'assets/resultado2.png';

//notification
  static String imageGirl = 'assets/girl.png';
  static String bell = 'assets/bell.png';
  static String bellSvg = 'assets/bell.svg';

  //fonts - openSans
  static const String OPBold = 'OpenSans-Bold';
  static const String OPBoldItalic = 'OpenSans-BoldItalic';
  static const String OPExtraBold = 'OpenSans-ExtraBold';
  static const String OPExtraboldItalic = 'OpenSans-ExtraBoldItalic';
  static const String OPLight = 'OpenSans-Light';
  static const String OPMedium = 'OpenSans-Medium';
  static const String OPMediumItalic = 'OpenSans-MediumItalic';
  static const String OPRegular = 'OpenSans-Regular';
  static const String OPSemiBold = 'OpenSans-SemiBold';
  static const String OPSemiBoldItalic = 'OpenSans-SemiBoldItalic';

  //fonts - openSans
  static const String QSBold = 'Quicksand-Bold';
  static const String QSLight = 'Quicksand-Light';
  static const String QSMedium = 'Quicksand-Medium';
  static const String QSRegular = 'Quicksand-Regular';
  static const String QSSemiBold = 'Quicksand-SemiBold';

  //fonts - Roboto
  static const String RBBlack = 'Roboto-Black';
  static const String RBBlackItalic = 'Roboto-BlackItalic';
  static const String RBBold = 'Roboto-Bold';
  static const String RBNoldItalic = 'Roboto-BoldItalic';
  static const String RBItalic = 'Roboto-Italic';
  static const String RBLight = 'Roboto-Light';
  static const String RBLightItalic = 'Roboto-LightItalic';
  static const String RBMedium = 'Roboto-Medium';
  static const String RBMediumItalic = 'Roboto-MediumItalic';
  static const String RBRegular = 'Roboto-Regular';
  static const String RBThin = 'Roboto-Thin';
  static const String RBThinItalic = 'Roboto-ThinItalic';

  //text
  static const labelStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 40);
  static const unselectedLabelStyle = TextStyle(
    color: Color.fromARGB(96, 95, 92, 92),
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
}

enum AppStatusCode {
  NOINTERNET,
  VALIDATION,
  SERVER,
  NOUSER,
}
