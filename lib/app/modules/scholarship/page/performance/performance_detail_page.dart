// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/widgets/back_appbar_rectangle_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/consulta_siage_entity.dart';
import 'package:perubeca/app/database/entities/reniec_performance_entity.dart';
import 'package:perubeca/app/utils/constans.dart';

class PerformanceDetailPage extends StatefulWidget {
  PerformanceDetailPage({required this.pageController, super.key});
  PageController pageController;
  // PageController fatherPageController;

  @override
  State<PerformanceDetailPage> createState() => _PerformanceDetailPageState();
}

class _PerformanceDetailPageState extends State<PerformanceDetailPage> {
  ReniecPerformanceEntity user = ReniecPerformanceEntity(
    apeMaterno: '',
    apePaterno: '',
    resultadoSiagie: '',
    fecNacimiento: '',
    nombre: '',
    nombreCompleto: '',
    numdoc: '',
    sexo: '',
    rptaSiagieBool: false,
    notara: '',
  );

  List<ConsultaSiageEntity> listdetail = [];

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    getDataInitial();
    super.initState();
  }

  Future<void> getDataInitial() async {
    final reniecDatabox = await Hive.openBox<ReniecPerformanceEntity>('dataReniecPerformanceBox');
    user = reniecDatabox.values.first;
    final siagebox = await Hive.openBox<ConsultaSiageEntity>('siageBox');
    listdetail = siagebox.values.toList();
    setState(() {});
  }

  void showLoadingOverlay() {
    // Crear el OverlayEntry para mostrar el CircularProgressIndicator
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Fondo oscuro semi-transparente
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // CircularProgressIndicator centrado
            CustomLoader(),
          ],
        );
      },
    );
    // Agregar el OverlayEntry al Overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingOverlay() {
    // Remover el OverlayEntry del Overlay
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackAppBarRectangleCommon(
          ontap: () {
            widget.pageController.jumpToPage(0);
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, left: 10, top: 10),
                        child: GenericStylesApp().title(
                          text: user.nombreCompleto,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        child: GenericStylesApp().messagePage(
                          text:
                              'Según la información contenida en los Certificados de Estudios oficiales remitida por el Ministerio de Educación (SIAGIE), estos  son tus resultados:',
                        ),
                      ),
                      //card
                      //
                      if (listdetail.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.transparent,
                          child: Material(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            //elevation: 0,
                            borderRadius: BorderRadius.circular(10),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: ConstantsApp.cardBGColor,
                                border: Border.all(
                                  width: 5,
                                  color: ConstantsApp.cardBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: -10,
                                    top: 0,
                                    child: Image.asset('assets/card-header.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //detail
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: listdetail.length,
                                          itemBuilder: (context, index) {
                                            final model = listdetail[index];
                                            //return Text(model.condicion!);
                                            return DetailPerformance(text1: model.grado!, text2: model.condicion!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Image.asset(
                          ConstantsApp.noData,
                          scale: 1.9,
                        ),

                      //message
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10, bottom: 10),
                              child: Icon(
                                (user.rptaSiagieBool!) ? Icons.check_circle : Icons.warning_rounded,
                                color: (user.rptaSiagieBool!) ? const Color(0xff005C1D) : const Color(0xffAD0011),
                              ),
                            ),
                            Expanded(child: Html(data: user.resultadoSiagie)),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                        child: Html(data: user.notara),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 10, top: listdetail.isNotEmpty ? 10 : 70, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BottonRightWidget(
                              isEnabled: true,
                              ontap: () {
                                widget.pageController.jumpToPage(0);
                              },
                              text: 'Hacer nueva consulta',
                              //icon: Icons.navigate_next,
                              size: 220,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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

class DetailPerformance extends StatelessWidget {
  DetailPerformance({
    required this.text1,
    required this.text2,
    super.key,
  });
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Html(data: text1)),
        Expanded(
          child: Html(data: text2),
        ),
      ],
    );
  }
}
