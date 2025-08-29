// ignore_for_file: avoid_field_initializers_in_const_classes, lines_longer_than_80_chars, prefer_const_constructors_in_immutables, inference_failure_on_function_invocation, must_be_immutable, sdk_version_since, cascade_invocations, use_build_context_synchronously, avoid_bool_literals_in_conditional_expressions, avoid_positional_boolean_parameters

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/widgets/back_appbar_rectangle_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/prepare/area_user_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_advance_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_history_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/download_file_bloc/download_file_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/prepare_exam/prepare_exam_bloc.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/examen_result_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/finish_prepare_exam_alert.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class ExamPage extends StatefulWidget {
  ExamPage(
      {required this.area,
      required this.areaUserHistory,
      required this.redesign,
      required this.generalCode,
      this.viewResponseGeneral = false,
      super.key,
      });
  PrepareAreaCommonEntity area;
  AreaUserHistoryEntity areaUserHistory;
  bool redesign; //true si es areas comunes y areas de interes, false si es simulacro
  bool viewResponseGeneral;
  int generalCode;
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  final ScrollController scrollController = ScrollController();
  final history = PrepareHistoryEntity();
  bool isOffline = true;
  bool viewResponse = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    if (!widget.viewResponseGeneral) {
      context.read<PrepareExamBloc>().add(InitDataEvent(
          advances: const [],
          courseCode: widget.area.codigo!,
          userDocument: widget.areaUserHistory.userDocument!,
          areaCode: widget.area.codigoPreparate!,
          generalCode: widget.generalCode,
          ),
          );
      history.startDate = DateTime.now();
    } else {
      setState(() {
        viewResponse = widget.viewResponseGeneral;
      });
    }
    internetConnection.internetStatus().listen((status) {
      setState(() {
        isOffline = (status == ConnectionStatus.offline);
      });
    });
    super.initState();
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
    return WillPopScope(
      onWillPop: () async {
        if (widget.viewResponseGeneral) {
          return true;
        } else if (viewResponse) {
          return false;
        } else {
          context.read<PrepareExamBloc>().add(SaveHistoryArea(userDocument: widget.areaUserHistory.userDocument!,areaCode: widget.area.codigoPreparate!, generalCode: widget.generalCode, courseCode: widget.area.codigo!));
          return true;
        }
      },
      child: BlocConsumer<PrepareExamBloc, PrepareExamState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PrepareExamCompleteState) {
            return BackgroundCommon(
              child: Column(
                children: [
                  BackAppBarRectangleCommon(
                    //viewOntap: true,
                    ontap:() async {
                            context .read<PrepareExamBloc>().add(SaveHistoryArea(userDocument: widget.areaUserHistory.userDocument!,areaCode: widget.area.codigoPreparate!, generalCode: widget.generalCode, courseCode: widget.area.codigo! ));
                            Navigator.pop(context);
                          },
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: (constraints.maxWidth > 1000)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: GenericStylesApp().title(
                                  text: state.questions!.isNotEmpty
                                      ? state.questions![0].pregunta
                                      : '',
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.questions!.length,
                                  itemBuilder: (context, indexGeneral) {
                                    if (indexGeneral != 0) {
                                      final question = state.questions![indexGeneral];
                                      var alternativeSelected =PrepareAlternativeEntity();
                                      final advance = state.advances!
                                          .where((e) => e.preguntaId == question.preguntaId && e.courseCode == widget.area.codigo && e.generalCode == widget.generalCode  && e.areaCode == widget.area.codigoPreparate && e.userDocument == widget.areaUserHistory.userDocument)
                                          .firstOrNull;
                                      if (advance != null) {
                                        alternativeSelected = question
                                            .alternatives!
                                            .where((element) =>element.alternativaId == advance.respuestaMarcada)
                                            .first;
                                      }
                                      return Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Material(
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  elevation: 2,
                                                  borderRadius:BorderRadius.circular(20),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: ConstantsApp.cardBGColor,
                                                      border: Border.all(
                                                        width: 5,
                                                        color: ConstantsApp.cardBorderColor,
                                                      ),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
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
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisAlignment:MainAxisAlignment.end,
                                                            crossAxisAlignment:CrossAxisAlignment.start,
                                                            children: [
                                                              //pregunta
                                                              if (isOffline)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets .only(
                                                                                    left: 10,
                                                                                    top: 10,
                                                                                    right:10,
                                                                                    ),
                                                                  child: Html(
                                                                    data: question .preguntaOffline ??
                                                                        '',
                                                                    style: {
                                                                      'body':
                                                                          Style(
                                                                        fontSize:
                                                                            FontSize.large,
                                                                      ),
                                                                    },
                                                                  ),
                                                                )
                                                              else
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(left:10,
                                                                          top: 10,
                                                                          right:10,
                                                                          ),
                                                                  child: Html(
                                                                    data: question.pregunta ?? '',
                                                                    style: {
                                                                      'body':Style(fontSize:FontSize.large),
                                                                    },
                                                                  ),
                                                                ),

                                                              if (isOffline)
                                                                Visibility(
                                                                  visible: question.enlaceImagenOffline != null &&
                                                                      question.enlaceImagenOffline!.isNotEmpty,
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal:18),
                                                                      child: Image.asset('assets${question.enlaceImagenOffline!}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              else
                                                                Visibility(
                                                                  visible: question.enlaceImagen !=null &&
                                                                      question.enlaceImagen!.isNotEmpty,
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal:18),
                                                                      child: CachedNetworkImage(imageUrl:question.enlaceImagen ??''),
                                                                    ),
                                                                  ),
                                                                ),

                                                              //comentario
                                                              if (isOffline)
                                                                Visibility(
                                                                  visible: question.comentarioOffline != null &&
                                                                      question.comentarioOffline!.isNotEmpty,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets.only(left:10,top: 10,right:10),
                                                                    child: Html(
                                                                      data: question.comentarioOffline ??'',
                                                                      style: {
                                                                        'body':Style(fontSize:FontSize.large),
                                                                      },
                                                                    ),
                                                                  ),
                                                                )
                                                              else
                                                                Visibility(
                                                                  visible: question.comentarios != null && question.comentarios!.isNotEmpty,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                                                    child: Html(
                                                                      data: question.comentarios ?? '',
                                                                      style: {
                                                                        'body': Style(
                                                                          //textAlign: TextAlign.justify,
                                                                          fontSize: FontSize.large,
                                                                          // fontFamily: ConstantsApp.OPSemiBold,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),

                                                              const Divider(
                                                                color: Colors.transparent,
                                                              ),
                                                              //respuestas
                                                              if (viewResponse)
                                                                RadioButtonListAlternative(
                                                                  alternatives: question.alternatives!,
                                                                  area: widget.area,
                                                                  isOffline: isOffline,
                                                                  respuesta: question.respuesta == null ? '' : question.respuesta!,
                                                                  selected: alternativeSelected,
                                                                  userDocument: widget.areaUserHistory.userDocument!,
                                                                  generalCode: widget.generalCode,
                                                                )
                                                              else
                                                                RadioButtonListAlternativeNoResponse(
                                                                  alternatives: question.alternatives!,
                                                                  area: widget.area,
                                                                  isOffline: isOffline,
                                                                  respuesta: question.respuesta == null ? '' : question.respuesta!,
                                                                  selected: alternativeSelected,
                                                                  userDocument: widget.areaUserHistory.userDocument!,
                                                                  generalCode: widget.generalCode,
                                                                ),
                                                              const Divider(
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //buttons
                                          Visibility(
                                            visible: !widget.viewResponseGeneral,
                                            child: Visibility(
                                              visible: state.questions!.length == indexGeneral + 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    BottonRightWidget(
                                                      ontap: isActivate(state) ? viewResponse
                                                          ? () async {
                                                              //calculamos las preguntas correctas, con errores y no marcadas;
                                                              var correctos = 0;
                                                              var errores = 0;
                                                              var blancos = 0;
                                                              final total = widget.area.nroPregunta!;

                                                              for (final ad in state.advances!) {
                                                                final question = state.questions!
                                                                    .where((element) => element.preguntaId == ad.preguntaId)
                                                                    .first;
                                                                final alternative = question.alternatives!
                                                                    .where((a) => a.alternativaId == ad.respuestaMarcada)
                                                                    .first;
                                                                if (question.respuesta == alternative.codigo) {
                                                                  correctos++;
                                                                } else {
                                                                  errores++;
                                                                }
                                                              }

                                                              blancos = total - (correctos + errores);
                                                              await registerPageAnalytics('/${widget.area.nombre!.replaceAll(RegExp(' '), '')}Result',
                                                              );
                                                              //cambiamos el estado del area
                                                              final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
                                                              final listArea = prepareAreaCommonbox.values.toList();

                                                              final indexArea = listArea.indexWhere((element) => element.codigo == widget.area.codigo && element.codigoPreparate == widget.area.codigoPreparate);

                                                              if (indexArea != -1) {
                                                                widget.area.status = ConstantsApp.areaCompleted;
                                                                await prepareAreaCommonbox.putAt(indexArea, widget.area);
                                                              }

                                                              //areUserHistory
                                                              final areUserHistoryBox = await Hive.openBox<AreaUserHistoryEntity>('areaUserHistoryBox');
                                                              final listAreaUserHistory = areUserHistoryBox.values.toList();

                                                              final indexAreaUserHistory = listAreaUserHistory.indexWhere(
                                                                (element) =>
                                                                    element.areaId == widget.area.codigo &&
                                                                    element.userDocument == widget.areaUserHistory.userDocument! &&
                                                                    element.generalCode == widget.generalCode &&  
                                                                    element.areaCode == widget.area.codigoPreparate,                                                                
                                                              );

                                                              if (indexAreaUserHistory != -1) {
                                                                widget.areaUserHistory.areaStatus = widget.area.status;
                                                                widget.areaUserHistory.areaCode = widget.area.codigoPreparate;
                                                                await areUserHistoryBox.putAt(
                                                                  indexAreaUserHistory,
                                                                  widget.areaUserHistory,
                                                                );
                                                              }

                                                              // // eliminamos el advancehistorico
                                                              await context.read<PrepareExamBloc>().deleteHistory(
                                                                    widget.area.codigo!,
                                                                    widget.areaUserHistory.userDocument!,
                                                                    widget.generalCode,
                                                                    widget.area.codigoPreparate!,
                                                                  );

                                                              //prepare history;
                                                              history.areaCode = widget.area.codigo;
                                                              history.areaName = widget.area.nombre;
                                                              history.score = correctos;
                                                              history.attempsNumber = 1;
                                                              history.startEnd = DateTime.now();
                                                              history.inputNumber = 1;
                                                              history.totalCorrect = correctos;
                                                              history.totalError = errores;
                                                              history.totalUnanswered = blancos;
                                                              history.userName = '';

                                                              // Navigator.pop(context);
                                                              await Navigator.push(
                                                                context,
                                                                MaterialPageRoute<void>(
                                                                  builder: (BuildContext context) => BlocProvider(
                                                                    create: (context) => DownloadFileBloc(),
                                                                    child: Builder(
                                                                      builder: (context) {
                                                                        return ExamResultPage(
                                                                          area: widget.area,
                                                                          redesign: widget.redesign,
                                                                          history: history,
                                                                          areaUserHistory: widget.areaUserHistory,
                                                                          generalCode: widget.generalCode,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          : () async {
                                                              //calculamos las preguntas correctas, con errores y no marcadas;
                                                              var correctos = 0;
                                                              var errores = 0;
                                                              var blancos = 0;
                                                              final total = widget.area.nroPregunta!;

                                                              for (final ad in state.advances!) {
                                                                final question = state.questions!
                                                                    .where((element) => element.preguntaId == ad.preguntaId)
                                                                    .first;
                                                                final alternative = question.alternatives!
                                                                    .where((a) => a.alternativaId == ad.respuestaMarcada)
                                                                    .first;
                                                                if (question.respuesta == alternative.codigo) {
                                                                  correctos++;
                                                                } else {
                                                                  errores++;
                                                                }
                                                              }

                                                              blancos = total - (correctos + errores);

                                                              final alert = FinishPrepareExamAlert(
                                                                conRespuesta: total - blancos,
                                                                sinRespuesta: blancos,
                                                                area: widget.area.nombre!,
                                                                isView: true,
                                                                onTap: () {
                                                                  showLoadingOverlay();
                                                                  Navigator.pop(context);
                                                                  scrollController
                                                                      .animateTo(
                                                                    0,
                                                                    duration: const Duration(milliseconds: 200),
                                                                    curve: Curves.easeInOut,
                                                                  )
                                                                      .whenComplete(() {
                                                                    hideLoadingOverlay();
                                                                    setState(() {
                                                                      viewResponse = true;
                                                                    });
                                                                  });
                                                                },
                                                              );
                                                              await showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return alert;
                                                                },
                                                              );
                                                            } :(){},
                                                      text: viewResponse ? 'Continuar' : 'Finalizar',
                                                      isEnabled: isActivate(state),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

  bool isActivate(PrepareExamCompleteState state) {
    //final questions = state.questions!.where((element) => element.alternatives!.isNotEmpty).toList(); 
    return true;
  }

class RadioButtonListAlternative extends StatefulWidget {
  RadioButtonListAlternative({
    required this.alternatives,
    required this.area,
    required this.isOffline,
    required this.respuesta,
    required this.userDocument,
    required this.generalCode,
    this.selected,
    super.key,
  });
  List<PrepareAlternativeEntity> alternatives;
  PrepareAreaCommonEntity area;
  PrepareAlternativeEntity? selected;
  bool isOffline;
  String respuesta;
  String userDocument;
  int generalCode;
  @override
  State<RadioButtonListAlternative> createState() => _RadioButtonListAlternativeState();
}

class _RadioButtonListAlternativeState extends State<RadioButtonListAlternative> {
  @override
  Widget build(BuildContext context) {
    var noSelected = false;
    if (widget.selected!.codigo == null && widget.alternatives.isNotEmpty) {
      noSelected = true;
      widget.selected = widget.alternatives.firstWhere(
        (alternative) => alternative.codigo == widget.respuesta,
      );
    }
    return ListView.builder(
      itemCount: widget.alternatives.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final alternative = widget.alternatives[index];
        final isSelected = widget.selected!.codigo == null
            ? false
            : widget.selected == alternative;
        final isCorrect = alternative.codigo == widget.respuesta;

        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 7),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                width: 2,
                color: widget.selected!.codigo == null
                    ? const Color(0xffD8E5F1)
                    : getBorderColor(isSelected, isCorrect, noSelected),
              ),
              color: widget.selected!.codigo == null
                  ? const Color(0xffF7F8FC)
                  : getBackgroundColor(isSelected, isCorrect, noSelected),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(right: 10, left: 15, top: 3),
                        child: Transform.scale(
                          scale: 1.3,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: getChecKBorderColor(isSelected,isCorrect, widget.selected!.codigo != null, noSelected),
                                width: 2,
                              ),
                            ),
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: getChecKBorderSelectedColor(isSelected, isCorrect, noSelected),
                                    width: 2,
                                    ),
                                color: getCheckBackgroundColor(isSelected, isCorrect, noSelected),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '${alternative.codigo}. ',
                          style: TextStyle(
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
                            color: getTextColor(isSelected, isCorrect,widget.selected!.codigo != null),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (widget.isOffline)
                        dataOffline(alternative, isSelected, isCorrect, widget.selected)
                      else
                        dataOnline(alternative, isSelected, isCorrect,widget.selected),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: getIcon(isSelected, isCorrect, noSelected),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget dataOnline(PrepareAlternativeEntity alternative, bool isSelected,bool isCorrect, PrepareAlternativeEntity? selected) {
    if (alternative.type?.toLowerCase() == 'texto'.toLowerCase()) {
      return alternative.typeAlternativa!.toLowerCase() == 'texto'.toLowerCase()
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Html(
                  data: alternative.alternativa,
                  style: {
                    'body': Style(
                      textAlign: TextAlign.justify,
                      fontSize: FontSize.large,
                      fontFamily: ConstantsApp.OPRegular,
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                      color: getTextColor(isSelected, isCorrect, selected!.codigo != null),
                    ),
                  },
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: CachedNetworkImage(
                imageUrl: alternative.alternativa!,
              ),
            );
    } else {
      return Expanded(
        child: CachedNetworkImage(
          imageUrl: alternative.enlaceImagen!,
        ),
      );
    }
  }

  Widget dataOffline(PrepareAlternativeEntity alternative, bool isSelected, bool isCorrect, PrepareAlternativeEntity? selected) {
    if (alternative.type?.toLowerCase() == 'texto'.toLowerCase()) {
      return alternative.typeAlternativaOffline!.toLowerCase() ==
              'texto'.toLowerCase()
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Html(
                  data: alternative.alternativaOffline,
                  style: {
                    'body': Style(
                      textAlign: TextAlign.justify,
                      fontSize: FontSize.large,
                      fontFamily: ConstantsApp.OPRegular,
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                      color: getTextColor(isSelected, isCorrect, selected!.codigo != null),
                    ),
                  },
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Image.asset(
                'assets${alternative.alternativaOffline!}',
              ),
            );
    } else {
      return Expanded(
        child: Image.asset(
          'assets${alternative.enlaceImagenOffline!}',
        ),
      );
    }
  }
}

class RadioButtonListAlternativeNoResponse extends StatefulWidget {
  RadioButtonListAlternativeNoResponse({
    required this.alternatives,
    required this.area,
    required this.isOffline,
    required this.respuesta,
    required this.userDocument,
    required this.generalCode,
    this.selected,
    super.key,
  });
  List<PrepareAlternativeEntity> alternatives;
  PrepareAreaCommonEntity area;
  PrepareAlternativeEntity? selected;
  bool isOffline;
  String respuesta;
  String userDocument;
  int generalCode;
  @override
  State<RadioButtonListAlternativeNoResponse> createState() =>
      _RadioButtonListAlternativeNoResponseState();
}

class _RadioButtonListAlternativeNoResponseState
    extends State<RadioButtonListAlternativeNoResponse> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.alternatives.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final alternative = widget.alternatives[index];
        final isSelected = widget.selected!.codigo == null
            ? false
            : widget.selected == alternative;
        final isCorrect = alternative.codigo == widget.respuesta;

        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 7),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 7),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                width: 2,
                color: isSelected
                    ? const Color(0xffD8E5F1)
                    : const Color(0xffD8E5F1),
              ),
              color: isSelected
                  ? const Color(0xffE8EBFA)
                  : const Color(0xffFfffff),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Colors.grey.withOpacity(0.7)
                      : Colors.transparent,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.selected = alternative;
                });
                final respuesta = PrepareAreaAdvanceEntity(
                  courseCode: widget.area.codigo,
                  preguntaId: alternative.preguntaId,
                  respuestaMarcada: alternative.alternativaId,
                  userDocument: widget.userDocument,
                  generalCode: widget.generalCode,
                  areaGeneralCode: '${widget.area.codigo}${widget.generalCode}',
                  areaCode: widget.area.codigoPreparate,
                );
                context
                    .read<PrepareExamBloc>()
                    .add(AddRespuesta(history: respuesta));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10, left: 15, top: 3),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xff7F3088)
                                      : const Color(0xffB2C8DE),
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.selected = alternative;
                                  });
                                  final respuesta = PrepareAreaAdvanceEntity(
                                    courseCode: widget.area.codigo,
                                    preguntaId: alternative.preguntaId,
                                    respuestaMarcada: alternative.alternativaId,
                                    userDocument: widget.userDocument,
                                    generalCode: widget.generalCode,
                                    areaGeneralCode:'${widget.area.codigo}${widget.generalCode}',
                                    areaCode: widget.area.codigoPreparate,
                                  );
                                  context
                                      .read<PrepareExamBloc>()
                                      .add(AddRespuesta(history: respuesta));
                                },
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: const Color(0xffF7F8FC),
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? const Color(0xff7F3088)
                                        : const Color(0xffF7F8FC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '${alternative.codigo}. ',
                            style: const TextStyle(
                              fontFamily: ConstantsApp.OPSemiBold,
                              fontSize: 16,
                              color: ConstantsApp.textBlackQuaternary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (widget.isOffline)
                          dataOffline(alternative, isSelected, isCorrect, widget.selected)
                        else
                          dataOnline(alternative, isSelected, isCorrect, widget.selected),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dataOnline(PrepareAlternativeEntity alternative, bool isSelected, bool isCorrect, PrepareAlternativeEntity? selected) {
    if (alternative.type?.toLowerCase() == 'texto'.toLowerCase()) {
      return alternative.typeAlternativa!.toLowerCase() == 'texto'.toLowerCase()
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Html(
                  data: alternative.alternativa,
                  style: {
                    'body': Style(
                      textAlign: TextAlign.justify,
                      fontSize: FontSize.large,
                      fontFamily: ConstantsApp.OPRegular,
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                      color: ConstantsApp.textBlackQuaternary,
                    ),
                  },
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: CachedNetworkImage(
                imageUrl: alternative.alternativa!,
              ),
            );
    } else {
      return Expanded(
        child: CachedNetworkImage(
          imageUrl: alternative.enlaceImagen!,
        ),
      );
    }
  }

  Widget dataOffline(PrepareAlternativeEntity alternative, bool isSelected, bool isCorrect, PrepareAlternativeEntity? selected) {
    if (alternative.type?.toLowerCase() == 'texto'.toLowerCase()) {
      return alternative.typeAlternativaOffline!.toLowerCase() ==
              'texto'.toLowerCase()
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Html(
                  data: alternative.alternativaOffline,
                  style: {
                    'body': Style(
                      textAlign: TextAlign.justify,
                      fontSize: FontSize.large,
                      fontFamily: ConstantsApp.OPRegular,
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                      color: ConstantsApp.textBlackQuaternary,
                    ),
                  },
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Image.asset(
                'assets${alternative.alternativaOffline!}',
              ),
            );
    } else {
      return Expanded(
        child: Image.asset(
          'assets${alternative.enlaceImagenOffline!}',
        ),
      );
    }
  }
}
