// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/utils/constans.dart';

class InitSimulacrumExamAlert extends StatelessWidget {
  InitSimulacrumExamAlert({
    required this.onTap,
    super.key,
  });

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
            height: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height *0.65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close_sharp,
                              size: 20,
                              weight: 10,
                              color: ConstantsApp.purpleTerctiaryColor,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/alert_app.svg',
                                height: 150,
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              Text(
                                'INDICACIONES:'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: ConstantsApp.OPBold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ConstantsApp.textBluePrimary,
                                ),
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              DetailMessage(text: 'Tiempo de duración: 60 minutos.'),
                              DetailMessage(text: 'Una vez comenzado el simulacro, permanecer en la aplicación hasta finalizar.'),
                              // DetailMessage(
                              //   text:
                              //       'No abrir o visualizar otras páginas mientras estás realizando el simulacro, porque sino la aplicación lo detectará como inactividad.',
                              // ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                               const Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Padding(
                                     padding: EdgeInsets.only(left: 10, right: 10),
                                     child: Icon(
                                       Icons.info,
                                       color: Color(0xffEB8C0A),
                                     ),
                                   ),
                                   Expanded(
                                     child: Text(
                                       'Antes de comenzar, asegúrate de tener una buena conexión a Internet.',
                                       style: TextStyle(
                                         color: Color(0xff373E49),
                                         fontSize: 16,
                                         fontFamily: ConstantsApp.OPSemiBold,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               const Divider(
                                 color: Colors.transparent,
                               ),
                            ],
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(bottom: kIsWeb ? 80 : 0),
                        child: BottonCenterWidget(
                          ontap: onTap,
                          text: 'Entendido',
                          color: ConstantsApp.purpleTerctiaryColor,
                          sized: 152,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DetailMessage extends StatelessWidget {
  DetailMessage({
    required this.text,
    super.key,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(right: 10, top: 7),
            decoration: ConstantsApp.boxLinearVerticalDecorationPrimary,
          ),
          Expanded(child: GenericStylesApp().messageJustifyPage(text: text)),
        ],
      ),
    );
  }
}
