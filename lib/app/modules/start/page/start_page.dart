// ignore_for_file: lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/common/navigation_app/navigation_page.dart';
import 'package:perubeca/app/common/widgets/appbarCommon.dart';
import 'package:perubeca/app/common/widgets/bottom_navigation_bar_height.dart';
import 'package:perubeca/app/common/widgets/web/app_bar_back_common_web_widget.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_exam_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_general_page.dart';
import 'package:perubeca/app/modules/start/widgets/card_start_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class StartPage extends StatelessWidget {
  StartPage({this.scaffoldKey, super.key});
  GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              if (constraints.maxWidth > 1000)
                AppBarBackCommonWebWidget(
                  title: 'Inicio',
                  subtitle: 'subtitle',
                  scaffoldKey: scaffoldKey!,
                )
              else
                AppBarCommon(
                  title: 'Inicio',
                  subtitle: '',
                ),
              Divider(
                color: Colors.transparent,
                height: (constraints.maxWidth > 1000) ? 50 : null,
              ),
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
                    text: '¡Hola!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: ConstantsApp.OPBold,
                      fontWeight: FontWeight.bold,
                      color: ConstantsApp.textBluePrimary,
                    ),
                  ),
                  textScaler:
                      TextScaler.linear((constraints.maxWidth > 1000) ? 2 : 1),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: (constraints.maxWidth > 1000) ? 50 : null,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Te damos la bienvenida a ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: ConstantsApp.OPRegular,
                    color: ConstantsApp.textBlackPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Pronabec app, ',
                      style: TextStyle(
                        fontFamily: ConstantsApp.OPBold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\ndonde encontrarás las becas y créditos \neducativos que tenemos para ti.',
                    ),
                  ],
                ),
                textScaler:
                    TextScaler.linear((constraints.maxWidth > 1000) ? 2 : 1),
              ),
              Divider(
                color: Colors.transparent,
                height: (constraints.maxWidth > 1000) ? 0 : 30,
              ),
              SizedBox(
                width: (constraints.maxWidth > 1000)
                    ? MediaQuery.of(context).size.width * 0.5
                    : MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    //Encuentra tu beca
                    CardStartWidget(
                      title: 'Encuentra tu beca o crédito educativo',
                      subtitle: 'Accede a los principales servicios otorgados.',
                      icon: ConstantsApp.startFinds2025,
                      gradientColors: [
                          const Color(0x1FE71D73),
                          const Color(0x1F004A92),
                        ],
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => NavigationPage(
                              selectedIndex: 1,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                    ),

                    //Prepárate
                    CardStartWidget(
                      title: 'Prepárate',
                      subtitle: 'Prepárate para tu examen de admisión',
                      icon: ConstantsApp.startGetReady2025,
                      gradientColors: [
                          const Color(0x1F0A8CB3),
                          const Color(0x1F00913E),
                        ],
                      onTap: () {
                        //registerPageAnalytics('/ReniecPrepareExam');
                        if (ConstantsApp.loginView) {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PrepareGeneralPage(
                                      pageController: PageController()),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PrepareExamPage(areaCode: '400000'),
                            ),
                          );
                        }
                      },
                    ),

                    //CardStartWidget(
                    //  title: 'Historial de consultas',
                    //  subtitle: 'Información almacenada de tus búsquedas.',
                    //  onTap: () {
                    //    Navigator.pushAndRemoveUntil(
                    //      context,
                    //      MaterialPageRoute<void>(
                    //        builder: (BuildContext context) => NavigationPage(
                    //          selectedIndex: 2,
                    //        ),
                    //      ),
                    //      (route) => false,
                    //    );
                    //  },
                    //  icon: ConstantsApp.startHistoryIconPng,
                    //),

                    //Contacto
                    CardStartWidget(
                      title: 'Contacto',
                      subtitle:
                          'Descubre nuestras redes sociales oficiales y síguenos.',
                      icon: ConstantsApp.startContact2025,
                      gradientColors: [
                          const Color(0x1FF59D24),
                          const Color(0x1FE71D73),
                        ],
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => NavigationPage(
                              selectedIndex: 3,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                    ),

                    //Preguntas frecuentes
                    Visibility(
                      child: CardStartWidget(
                        title: 'Preguntas frecuentes',
                        subtitle:
                            'Resuelve tus dudas sobre requisitos, postulación y más.',
                        icon: ConstantsApp.startAsked2025,
                        gradientColors: [
                          const Color(0x1F0022FF),
                          const Color(0x1F00B2E8),
                        ],
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => NavigationPage(
                                selectedIndex: 4,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              //la diferencia del BNB
              Visibility(
                visible: constraints.maxWidth > 1000,
                child: const BottomNavigationBarHeightWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarStart extends StatelessWidget {
  const AppBarStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      decoration: ConstantsApp.boxRadialDecoratioBottonBorderPrimary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -35,
            bottom: 12,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: -50,
            top: -7,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            top: -30,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ConstantsApp.logoIcon,
                fit: BoxFit.cover,
              ),
              const Divider(
                color: Colors.transparent,
              ),
              const Text(
                'Inicio',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: ConstantsApp.OPBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
