// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_scholarship_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class ViewSignPage extends StatelessWidget {
  ViewSignPage({required this.pageController, super.key});
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackAppBarCommon(
          title: 'Visualiza y firma tu postulación',
          subtitle: '',
          ontap: () {
            pageController.jumpToPage(0);
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: (constraints.maxWidth > 1000)
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Text(
                          'Selecciona una opción de postulación',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: ConstantsApp.OPSemiBold,
                            color: ConstantsApp.textBluePrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: GenericStylesApp().messageJustifyPage(
                          text:
                              'Completa tus datos y carga los documentos necesarios para postular a la beca.',
                        ),
                      ),
                      // CardScholarshipLauchWidget(
                      //   title: 'Postulación del ciudadano',
                      //   subtitle: 'Beca 18 - Convocatoria 2024',
                      //   icon: ConstantsApp.zeroPostulacionIcon,
                      //   onTap: () {},
                      // ),
                      // CardScholarshipLauchWidget(
                      //   title: 'Postulación asistida',
                      //   subtitle: 'Beca 18 - Convocatoria 2024',
                      //   icon: ConstantsApp.viewSignAsistenteIcon,
                      //   onTap: () {},
                      // ),
                      CardScholarshipWidget(
                        title: 'Revisar y firmar postulación de la beca',
                        icon: ConstantsApp.viewSignFirmaIcon,
                        gradientColors: const [
                          Color(0x293C9EC5),
                          Color(0x29E71D73),
                          Color(0x29F59D24),
                        ],
                        gradientStops: [0.0, 0.5, 1.0],
                        onTap: () {
                          pageController.jumpToPage(4);
                        },
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
