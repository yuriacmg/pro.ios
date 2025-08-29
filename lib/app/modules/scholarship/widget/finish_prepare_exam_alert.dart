// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class FinishPrepareExamAlert extends StatelessWidget {
  FinishPrepareExamAlert({
    required this.onTap,
    required this.conRespuesta,
    required this.sinRespuesta,
    required this.area,
    required this.isView,
    super.key,
  });

  VoidCallback onTap;
  int conRespuesta;
  int sinRespuesta;
  String area;
  bool isView;

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
                              Navigator.pop(context, false);
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
                      Text(
                        isView ? '¿Estás seguro de finalizar el simulacro de $area?' : '¿Estás seguro de finalizar el simulacro?',
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

                      Text(
                        isView ? '' : 'Ten en cuenta que luego de enviar las respuestas no podrás cambiar las alternativas seleccionadas.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                                         color: Color(0xff373E49),
                                         fontSize: 16,
                                         fontFamily: ConstantsApp.OPRegular,
                                       ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width:
                                (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Con respuestas',
                                      style: TextStyle(
                                        fontFamily: ConstantsApp.OPMedium,
                                        fontSize: 16,
                                        color: ConstantsApp.colorBlackPrimary,
                                      ),
                                    ),
                                    Text(
                                      '$conRespuesta preguntas',
                                      style: const TextStyle(
                                        fontFamily: ConstantsApp.OPMedium,
                                        fontSize: 16,
                                        color: Color(0xff0D5E3F),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sin respuestas',
                                      style: TextStyle(
                                        fontFamily: ConstantsApp.OPMedium,
                                        fontSize: 16,
                                        color: ConstantsApp.colorBlackPrimary,
                                      ),
                                    ),
                                    Text(
                                      '$sinRespuesta preguntas',
                                      style: const TextStyle(
                                        fontFamily: ConstantsApp.OPMedium,
                                        fontSize: 16,
                                        color: Color(0xff9D211B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      BottonCenterWidget(
                        ontap: onTap,
                        text: 'Finalizar simulacro',
                        color: ConstantsApp.purpleTerctiaryColor,
                        sized: 152,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
                            color: ConstantsApp.purpleTerctiaryColor,
                          ),
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
