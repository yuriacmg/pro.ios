// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class InitPrepareExamAlert extends StatelessWidget {
  InitPrepareExamAlert({
    required this.onTap,
    required this.course,
    required this.nroQuestions,
    super.key,
  });

  VoidCallback onTap;
  String course;
  String nroQuestions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
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
                      SvgPicture.asset(
                        'assets/alert_app.svg',
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Text(
                        'IMPORTANTE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ConstantsApp.OPBold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ConstantsApp.textBluePrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text(
                        'Responderás $nroQuestions preguntas para que pongas a prueba lo aprendido en $course.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: ConstantsApp.OPMedium,
                          fontSize: 16,
                          color: ConstantsApp.colorBlackPrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Text(
                        'Los resultados mostrarán tus fortalezas y oportunidades de mejora en el área.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ConstantsApp.OPMedium,
                          fontSize: 16,
                          color: ConstantsApp.colorBlackPrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      BottonCenterWidget(
                        ontap: onTap,
                        text: 'Empezar',
                        color: ConstantsApp.purpleTerctiaryColor,
                        sized: 152,
                      ),
                      const Divider(
                        color: Colors.transparent,
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
