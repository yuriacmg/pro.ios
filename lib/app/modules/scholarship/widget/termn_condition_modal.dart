// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, cascade_invocations

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class TermsAndCondditionsModal extends StatefulWidget {
  TermsAndCondditionsModal({required this.constraints, super.key});
  BoxConstraints constraints;

  @override
  State<TermsAndCondditionsModal> createState() => _TermsAndCondditionsModalState();
}

class _TermsAndCondditionsModalState extends State<TermsAndCondditionsModal> {
  ScrollController scrollController = ScrollController();
  bool isActivate = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!canScroll()) {
        setState(() {
          isActivate = true;
        });
      }
    });
  }

  bool canScroll() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final minScrollExtent = scrollController.position.minScrollExtent;
    final currentOffset = scrollController.offset;

    return maxScrollExtent - minScrollExtent > 0 && currentOffset == 0.0;
    //return currentOffset < maxScrollExtent && currentOffset > minScrollExtent;
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        setState(() {
          isActivate = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(10),
      titlePadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: (widget.constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Scrollbar(
            child: SingleChildScrollView(
              controller: scrollController,
              child: ScrollConfiguration(
                behavior: AppCustomScrollBehavior(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'términos y condiciones de uso de datos personales'.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: ConstantsApp.OPBold,
                              fontSize: 18,
                              color: ConstantsApp.textBluePrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          RichText(
                            textAlign: TextAlign.justify,
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: ConstantsApp.OPRegular,
                                fontSize: 16,
                                color: ConstantsApp.colorBlackPrimary,
                              ),
                              children: [
                                TextSpan(text: 'De conformidad con la '),
                                TextSpan(
                                  text: 'Ley N° 29733, Ley de Protección de Datos Personales ',
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPBold,
                                  ),
                                ),
                                TextSpan(
                                  text: '(en adelante, la Ley), y su reglamento, aprobado por el ',
                                ),
                                TextSpan(
                                  text: 'Decreto Supremo N° 003-2013- JUS ',
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPBold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '(en adelante, el Reglamento), el titular autoriza el tratamiento de los datos personales que facilite al ',
                                ),
                                TextSpan(
                                  text: 'PRONABEC ',
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPBold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '(en adelante, la Entidad), por el presente formulario. Al completar el presente formulario y aceptar previamente los términos que rigen el tratamiento de los datos personales, la Entidad procederá a guardar la información del titular en la base de datos que posee en condición de titular, por tiempo indefinido o hasta que usted revoque el consentimiento otorgado. La información que brindará el titular de los datos personales a la Entidad se encontrará referida a documento de identidad, nombres y apellidos, fecha de nacimiento, correo electrónico y grado académico. La Entidad (sito en Av. Arequipa 1935, Lince), declara ser la titular del banco de datos personales y utilizará su información para las siguientes finalidades: i) remisión de información sobre las becas y/o créditos de su interés, ii) contactarlo para orientarlo sobre los requisitos de postulación, iii) realización de encuestas de satisfacción y mejora del servicio y iv) otras finalidades conexas a las antes mencionadas. Adicionalmente, y de ser aceptado por el titular, la Entidad queda autorizada a remitirle información sobre las becas y créditos educativos para lo cual utilizará los medios de comunicación registrados en el presente formulario. En ambos casos, se informa al usuario que el contacto que efectuará la Entidad podrá hacerse por llamada telefónica, SMS, correo electrónico, WhatsApp, entre otros medios que considere oportunos a efectos de cumplir las finalidades mencionadas. En caso de que el titular desee ejercer sus derechos de acceso, cancelación, oposición, revocatoria de consentimiento, modificación o cualquier otro contemplado en la Ley, deberá enviar una comunicación al buzón consultas@pronabec.gob.pe. Se pone en conocimiento de los titulares que los formularios, mediante los cuales otorguen sus datos personales, pueden incluir preguntas obligatorias, las cuales podrán ser identificadas en cada uno de éstos. Las consecuencias de la concesión de datos personales, faculta a la Entidad a utilizarlos de acuerdo a las finalidades señaladas precedentemente. La negativa en la entrega de los datos personales del titular imposibilita a la Entidad a incluirlos en su base de datos y atender sus requerimientos.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottonCenterWidget(
                isEnabled: isActivate,
                ontap: isActivate
                    ? () {
                        Navigator.pop(context);
                      }
                    : () {},
                text: 'Aceptar',
                color: isActivate ? ConstantsApp.purpleSecondaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
