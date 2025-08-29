// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, use_raw_strings

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:perubeca/app/common/widgets/back_appbar_rectangle_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/data_reniec_review_sign_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/report_bloc/report_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/send_report_model.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_subtitle_review_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class ReviewDetailPage extends StatefulWidget {
  ReviewDetailPage({required this.pageController, super.key});
  PageController pageController;

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  DataReniecReviewSignEntity user = DataReniecReviewSignEntity(
    apeMaterno: '',
    apePaterno: '',
    concurso: '',
    fecNacimiento: '',
    fecPostulacion: '',
    modalidad: '',
    nombre: '',
    nombreCompleto: '',
    numdoc: '',
    sexo: '',
  );

  OverlayEntry? _overlayEntry;

  bool isAuth = false;

  @override
  void initState() {
    getDataInitial();
    super.initState();
  }

  Future<void> getDataInitial() async {
    final reniecDatabox = await Hive.openBox<DataReniecReviewSignEntity>('dataReniecViewBox');
    user = reniecDatabox.values.first;
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
                  child: GenericStylesApp().messageLeftPage(
                    text:
                        'Según tu información brindada, esta es tu ficha de expediente, revísalo y firma los documentos para culminar tu postulación.',
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width:
                              (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Material(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(20),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: ConstantsApp.cardBGColor,
                                          border: Border.all(
                                            width: 5,
                                            color: ConstantsApp.cardBorderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 25),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Image.asset('assets/card-header.png'),
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Image.asset('assets/card-bottom.png'),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      TitleSubtitleReviewWidget(
                                                        title: 'DNI',
                                                        subtitle: user.numdoc!,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                          right: 10,
                                                          top: 10,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/history/file_search.png',
                                                          scale: 1.9,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TitleSubtitleReviewWidget(
                                                    title: 'Postulante',
                                                    subtitle: user.nombreCompleto!,
                                                  ),
                                                  TitleSubtitleReviewWidget(
                                                    title: 'Concurso',
                                                    subtitle: user.concurso!,
                                                  ),
                                                  TitleSubtitleReviewWidget(
                                                    title: 'Modalidad',
                                                    subtitle: user.modalidad!,
                                                  ),
                                                  TitleSubtitleReviewWidget(
                                                    title: 'Fecha de postulación',
                                                    subtitle: user.fecPostulacion!,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          //descargar ficha
                                                          final body = BodyData(
                                                            fechaPostulacion: user.fecPostulacion,
                                                            nombreCompleto: user.nombreCompleto,
                                                            nombreConcurso: user.concurso,
                                                            nombreModalidad: user.modalidad,
                                                            numDocumento: user.numdoc,
                                                          );

                                                          final send = SendReportModel(
                                                            data: body,
                                                            rutaPlantilla: 'CONCURSOS\\2024_BECA18\\PRESELECCION\\POSTULACION',
                                                            nombrePlantilla: 'PLANTILLA_ANEXO_01_BECA18_APP.docx',
                                                          );
                                                          if (kIsWeb) {
                                                            context.read<ReportBloc>().downloadReportWeb(send);
                                                          } else {
                                                            context.read<ReportBloc>().downloadReport(send);
                                                          }
                                                        },
                                                        child: const Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              'Descargar ficha',
                                                              style: TextStyle(
                                                                color: ConstantsApp.purpleSecondaryColor,
                                                                fontSize: 16,
                                                                fontFamily: ConstantsApp.QSBold,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons.download,
                                                              color: ConstantsApp.purpleSecondaryColor,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: ConstantsApp.purplePrimaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(
                                              0,
                                              3,
                                            ), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        'Ficha técnica de postulación',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ConstantsApp.OPMedium,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //next design
                              const Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      'Firmar documentos',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ConstantsApp.textBlackQuaternary,
                                        fontFamily: ConstantsApp.OPBold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffDAEEFE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: ConstantsApp.textBluePrimary,
                                    ),
                                    Divider(color: Colors.transparent),
                                    Text(
                                      'Deberás autorizar el uso de tus datos personales sensibles para dar de alta el reconocimiento facial',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ConstantsApp.textBluePrimary,
                                        fontFamily: ConstantsApp.OPRegular,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                      top: 10,
                                      bottom: 10,
                                      left: 10,
                                    ),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          color: isAuth ? Colors.blue : Colors.grey[500]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.transparent,
                                        ),
                                        child: Checkbox(
                                          value: isAuth,
                                          hoverColor: Colors.transparent,
                                          checkColor: Colors.blue,
                                          activeColor: Colors.transparent,
                                          onChanged: (value) {
                                            setState(() {
                                              isAuth = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Autorizo el uso de mis datos personales biométricos para la activación de firma con identificación facial.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: ConstantsApp.OPRegular,
                                          fontSize: 16,
                                          color: ConstantsApp.textBlackQuaternary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 10, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BottonRightWidget(
                                      isEnabled: isAuth,
                                      ontap: isAuth ? () {} : () {},
                                      text: 'Firmar documentos',
                                      //icon: Icons.navigate_next,
                                      size: 220,
                                    ),
                                  ],
                                ),
                              ),

                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'En otro momento',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPSemiBold,
                                    fontSize: 16,
                                    color: ConstantsApp.bluePrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocConsumer<ReportBloc, ReportState>(
                      listener: (context, state) {
                        // Puedes agregar lógica adicional cuando el estado cambie si es necesario
                      },
                      builder: (context, state) {
                        if (state is ErrorState) {
                          //error al obtener los resultados del api de reniec
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            //errorMessage(state.error);
                            hideLoadingOverlay();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                showCloseIcon: true,
                                content: Center(
                                  child: Text(state.error.value.first.message),
                                ),
                              ),
                            );
                          });
                        }

                        if (state is ReportLoadCompleteState) {
                          //data obtenida correctamente
                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                            hideLoadingOverlay();
                            context.read<ReportBloc>().initialState();
                            if (!kIsWeb) {
                              await OpenFile.open(state.response.value);
                            }
                          });
                        }

                        if (state is ReportLoadingState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_overlayEntry == null) {
                              showLoadingOverlay();
                            }
                          });
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 56),
      ],
    );
  }
}
