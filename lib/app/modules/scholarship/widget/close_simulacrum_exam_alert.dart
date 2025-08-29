// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/utils/constans.dart';

class CloseSimulacrumExamAlert extends StatelessWidget {
  CloseSimulacrumExamAlert({
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
                        height: 150,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Text(
                        '¿Estás seguro que deseas salir?',
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
                      GenericStylesApp().messagePage(text: 'Recuerda que, si sales del simulacro sin haber finalizado, tendrás que volver a iniciar.'),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      BottonCenterWidget(
                        ontap: onTap,
                        text: 'Si',
                        color: ConstantsApp.purpleTerctiaryColor,
                        sized: 152,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            color: ConstantsApp.purpleTerctiaryColor,
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
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
