// ignore_for_file: avoid_field_initializers_in_const_classes, lines_longer_than_80_chars, prefer_const_constructors_in_immutables, inference_failure_on_function_invocation, must_be_immutable, sdk_version_since, cascade_invocations, use_build_context_synchronously, sort_constructors_first, parameter_assignments, avoid_positional_boolean_parameters, avoid_bool_literals_in_conditional_expressions

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
import 'package:perubeca/app/database/entities/prepare/prepare_alternative_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_advance_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_pregunta_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/download_file_bloc/download_file_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/prepare_exam/prepare_exam_bloc.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/examen_result_simulacrum_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/close_simulacrum_exam_alert.dart';
import 'package:perubeca/app/modules/scholarship/widget/finish_prepare_exam_alert.dart';
import 'package:perubeca/app/modules/scholarship/widget/finish_prepare_exam_simulacrum_alert.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PrepareExamSimulacrumPage extends StatefulWidget {
  PrepareExamSimulacrumPage(
      {required this.area,
      required this.redesign,
      this.viewResponseGeneral = false,
      this.viewResponseButton = false,
      super.key,
      });
  PrepareAreaCommonEntity area;

  bool
      redesign; //true si es areas comunes y areas de interes, false si es simulacro
  bool viewResponseGeneral;
  bool viewResponseButton;
  @override
  State<PrepareExamSimulacrumPage> createState() =>
      _PrepareExamSimulacrumPageState();
}

class _PrepareExamSimulacrumPageState extends State<PrepareExamSimulacrumPage> {
  final CountdownController _timerController =
      CountdownController(autoStart: true);
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
          userDocument: '',
          areaCode: widget.area.codigoPreparate!,
          generalCode: 0,
          ),
          );
      history.startDate = DateTime.now();
    } else {
      setState(() {
        viewResponse = widget.viewResponseGeneral;
      });
    }

    internetConnection.internetStatus().listen((status) {
     if(!mounted){
       setState(() {
        isOffline = (status == ConnectionStatus.offline);
      });
     }
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
          _timerController.onPause!();
          final alert = CloseSimulacrumExamAlert(
            onTap: () async {
              Navigator.pop(context, true);
            },
          );
          final response = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return alert;
            },
          ) as bool;
          _timerController.onResume!();
          if (response) {
            await context
                .read<PrepareExamBloc>()
                .deleteHistorySimulacrum(widget.area.codigo!);
            Navigator.pop(context);
            Navigator.pop(context);
          }
          return response;
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
                    viewOntap:
                        widget.viewResponseGeneral ? true : !viewResponse,
                    ontap: viewResponse
                        ? () {
                            if (widget.viewResponseGeneral) {
                              Navigator.pop(context);
                            }
                          }
                        : () async {
                            _timerController.onPause!();
                            final alert = CloseSimulacrumExamAlert(
                              onTap: () async {
                                Navigator.pop(context, true);
                              },
                            );
                            final response = await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            ) as bool;
                            _timerController.onResume!();
                            if (response) {
                              await context
                                  .read<PrepareExamBloc>()
                                  .deleteHistorySimulacrum(widget.area.codigo!);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: (constraints.maxWidth > 1000)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              if (viewResponse)
                                const SizedBox.shrink()
                              else
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(5),
                                  color: const Color(0xff9B1C6D),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Tiempo restante',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: ConstantsApp.OPMedium,
                                        ),
                                      ),
                                      Countdown(
                                        controller: _timerController,
                                        seconds: 3600,
                                        build: (_, double time) {
                                          final duracion =
                                              Duration(seconds: time.toInt());
                                          final tiempoFormateado =
                                              "${duracion.inHours}:${duracion.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duracion.inSeconds.remainder(60).toString().padLeft(2, '0')}";

                                          return Text(
                                            tiempoFormateado,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: ConstantsApp.OPMedium,
                                            ),
                                          );
                                        },
                                        onFinished: () async {
                                          var totalMarked = 0;
                                          var totalUnmarked = 0;
                                          var totalArea = 0;
                                          var totalCorrect = 0;
                                          var resultadoAreas =
                                              <DrowpdownSimulacroModel>[];

                                          final result = await resultSimulacrum(
                                            totalArea,
                                            totalMarked,
                                            totalUnmarked,
                                            totalCorrect,
                                            widget.area.codigo!,
                                            resultadoAreas,
                                            state,
                                          );

                                          totalArea = result[0] as int;
                                          totalMarked = result[1] as int;
                                          totalUnmarked = result[2] as int;
                                          totalCorrect = result[3] as int;
                                          resultadoAreas = result[4]
                                              as List<DrowpdownSimulacroModel>;

                                          // para mostrar en el modal totales

                                          final alert =
                                              FinishPrepareExamSimulacrumAlert(
                                            conRespuesta: totalMarked,
                                            sinRespuesta: totalUnmarked,
                                            onTap: () {
                                              showLoadingOverlay();
                                              Navigator.pop(context);
                                              scrollController
                                                  .animateTo(
                                                0,
                                                duration: const Duration(milliseconds: 1000),
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
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.questions!.length,
                                  itemBuilder: (context, indexGeneral) {
                                    final question = state.questions![indexGeneral];
                                    var alternativeSelected = PrepareAlternativeEntity();
                                    final advance = state.advances!.where((e) => e.preguntaId == question.preguntaId).firstOrNull;
                                    if (advance != null) {
                                      alternativeSelected = question.alternatives!
                                          .where((element) => element.alternativaId == advance.respuestaMarcada)
                                          .first;
                                    }
                                    return Column(
                                      children: [
                                        Visibility(
                                          visible: question.respuesta == null &&
                                              question.pregunta!
                                                  .contains('PREGUNTAS'),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: GenericStylesApp().title(
                                              text: question.pregunta ?? '',
                                            ),
                                          ),
                                        ),

                                        Visibility(
                                          visible: !question.pregunta!.contains('PREGUNTAS'),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
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
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              //pregunta
                                                              if (isOffline)
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                                                  child: Html(
                                                                    data: question.preguntaOffline ?? '',
                                                                    style: {
                                                                      'body': Style(
                                                                        textAlign: TextAlign.justify,
                                                                        fontSize: FontSize.large,
                                                                        // fontFamily: ConstantsApp.OPSemiBold,
                                                                      ),
                                                                    },
                                                                  ),
                                                                )
                                                              else
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                                                  child: Html(
                                                                    data: question.pregunta ?? '',
                                                                    style: {
                                                                      'body': Style(
                                                                        textAlign: TextAlign.justify,
                                                                        fontSize: FontSize.large,
                                                                        // fontFamily: ConstantsApp.OPSemiBold,
                                                                      ),
                                                                    },
                                                                  ),
                                                                ),

                                                              if (isOffline)
                                                                Visibility(
                                                                  visible: question.enlaceImagenOffline != null &&
                                                                      question.enlaceImagenOffline!.isNotEmpty,
                                                                  child: Center(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 18),
                                                                      child: Image.asset(
                                                                        'assets${question.enlaceImagenOffline}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              else
                                                                Visibility(
                                                                  visible:
                                                                      question.enlaceImagen != null && question.enlaceImagen!.isNotEmpty,
                                                                  child: Center(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 18),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl: question.enlaceImagen ?? '',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                              //comentario
                                                              if (isOffline)
                                                                Visibility(
                                                                  visible: question.comentarioOffline != null &&
                                                                      question.comentarioOffline!.isNotEmpty,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                                                    child: Html(
                                                                      data: question.comentarioOffline ?? '',
                                                                      style: {
                                                                        'body': Style(
                                                                          textAlign: TextAlign.justify,
                                                                          fontSize: FontSize.large,
                                                                        ),
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
                                                                          textAlign: TextAlign.justify,
                                                                          fontSize: FontSize.large,
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
                                                                RadioButtonListAlternativeSimulacrum(
                                                                  alternatives: question.alternatives!,
                                                                  area: widget.area,
                                                                  selected: alternativeSelected,
                                                                  isOffline: isOffline,
                                                                  respuesta: question.respuesta != null ? question.respuesta! : '',
                                                                )
                                                              else
                                                                RadioButtonListAlternativeSimulacrumNoResponse(
                                                                  alternatives:question .alternatives!,
                                                                  area: widget.area,
                                                                  selected: alternativeSelected,
                                                                  isOffline:isOffline,
                                                                  respuesta: question.respuesta != null ? question.respuesta!: '',
                                                                  userDocument:'', 
                                                                  generalCode: 00,
                                                                ),
                                                              const Divider(color: Colors.transparent),
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
                                        ),
                                        //buttons
                                        Visibility(
                                          visible: state.questions!.length == indexGeneral + 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Visibility(
                                                  visible: !widget
                                                      .viewResponseButton,
                                                  child: BottonRightWidget(
                                                    ontap: isActivate(state)
                                                        ? viewResponse
                                                            ? () async {
                                                                var totalMarked =0;
                                                                var totalUnmarked =0;
                                                                var totalArea = 0;
                                                                var totalCorrect = 0;
                                                                var resultadoAreas =<DrowpdownSimulacroModel>[];

                                                                final result = await resultSimulacrum(
                                                                                totalArea,
                                                                                totalMarked,
                                                                                totalUnmarked,
                                                                                totalCorrect,
                                                                                widget.area.codigo!,
                                                                                resultadoAreas,
                                                                                state,
                                                                              );

                                                                totalArea = result[0] as int;
                                                                totalMarked = result[1] as int;
                                                                totalUnmarked =result[2] as int;
                                                                totalCorrect = result[3] as int;
                                                                resultadoAreas = result[4] as List<DrowpdownSimulacroModel>;

                                                                await registerPageAnalytics('/PrepareExamResult');
                                                                // // eliminamos el advancehistorico
                                                                await context.read< PrepareExamBloc>().deleteHistorySimulacrum(widget.area.codigo!);

                                                                // //prepare history;
                                                                history.areaCode = widget.area.codigo;
                                                                history.areaName = widget.area.nombre;
                                                                history.score = totalCorrect;
                                                                history.attempsNumber =  1;
                                                                history.startEnd = DateTime.now();
                                                                history.inputNumber =1;
                                                                history.totalCorrect =0;
                                                                history.totalError =0;
                                                                history.totalUnanswered =0;
                                                                history.userName ='';

                                                                // Navigator.pop(context);
                                                                await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute<void>(
                                                                    builder: (BuildContext context) =>
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          DownloadFileBloc(),
                                                                      child: Builder(
                                                                        builder:(context) {
                                                                          return ExamResultSimulacrumPage(
                                                                            area:widget.area,
                                                                            redesign:widget.redesign,
                                                                            history: history,
                                                                            dropdown: resultadoAreas,
                                                                            generalCode:0,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            : () async {
                                                                _timerController.onPause!();

                                                                var totalMarked = 0;
                                                                var totalUnmarked =0;
                                                                var totalArea = 0;
                                                                var totalCorrect =0;
                                                                var resultadoAreas =<DrowpdownSimulacroModel>[];

                                                                final result = await resultSimulacrum(
                                                                                totalArea,
                                                                                totalMarked,
                                                                                totalUnmarked,
                                                                                totalCorrect,
                                                                                widget.area .codigo!,
                                                                                resultadoAreas,
                                                                                state,
                                                                              );

                                                                totalArea =result[0] as int;
                                                                totalMarked = result[1] as int;
                                                                totalUnmarked =  result[2] as int;
                                                                totalCorrect = result[3] as int;
                                                                resultadoAreas = result[4] as List<DrowpdownSimulacroModel>;

                                                                // para mostrar en el modal totales
                                                                final alert = FinishPrepareExamAlert(
                                                                  conRespuesta: totalMarked,
                                                                  sinRespuesta: totalUnmarked,
                                                                  area: widget .area .nombre!,
                                                                  isView: false,
                                                                  onTap: () {
                                                                    showLoadingOverlay();
                                                                    Navigator.pop(context);
                                                                    scrollController.animateTo(0,
                                                                      duration: const Duration( milliseconds: 1000),
                                                                      curve: Curves.easeInOut,
                                                                    ).whenComplete(() {
                                                                      hideLoadingOverlay();
                                                                      setState(() {viewResponse =true;});
                                                                    });
                                                                  },
                                                                );
                                                                await showDialog(
                                                                  context: context,
                                                                  builder:(BuildContext context) {
                                                                    return alert;
                                                                  },
                                                                ).then((value) {
                                                                  if (value != null) {
                                                                    final r = value as bool;
                                                                    if (!r) {
                                                                      _timerController.onResume!();
                                                                    }
                                                                  }
                                                                });
                                                              }
                                                        : () {},

                                                    text: viewResponse
                                                        ? 'Continuar'
                                                        : 'Finalizar',
                                                    // icon: Icons.navigate_next,
                                                    isEnabled:
                                                        isActivate(state),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
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
  //final questions = state.questions!
  //    .where((element) => element.alternatives!.isNotEmpty)
  //    .toList();
  //return questions.length == state.advances!.length;
  return true;
}

Future<List<dynamic>> resultSimulacrum(
  int totalArea,
  int totalMarked,
  int totalUnmarked,
  int totalCorrect,
  int areaCodigo,
  List<DrowpdownSimulacroModel> resultadoAreas,
  PrepareExamCompleteState state,
) async {
  final preparePreguntabox =
      await Hive.openBox<PreparePreguntaEntity>('preparePreguntaBox');

  final questionsList = preparePreguntabox.values.toList();
  final listArea = questionsList
      .where((element) => element.simulacroId == areaCodigo)
      .toList();

  var idAreas = <int>[];

  for (final a in listArea) {
    if (a.preguntaPadreId != null) {
      idAreas.add(a.preguntaPadreId!);
    }
  }

  final conjuntoUnico = Set<int>.from(idAreas);
  idAreas = conjuntoUnico.toList();
  idAreas.remove(1);

  final questions = questionsList
      .where(
        (element) =>
            element.simulacroId == areaCodigo &&
            idAreas.contains(element.preguntaPadreId),
      )
      .toList();
  final totalQuestion =
      questions.where((element) => element.alternatives!.isNotEmpty).toList();
  totalQuestion
      .sort((a, b) => a.preguntaPadreId!.compareTo(b.preguntaPadreId!));

  for (final id in idAreas) {
    //cargar los dropdown
    var correctos = 0;
    var errores = 0;
    var blancos = 0;
    final total = totalQuestion
        .where((element) => element.preguntaPadreId == id)
        .toList()
        .length;

    for (final q in totalQuestion) {
      if (q.preguntaPadreId == id) {
        //calculamos las preguntas correctas, con errores y no marcadas por area ;
        final ad = state.advances!
            .where((element) => element.preguntaId == q.preguntaId)
            .firstOrNull;
        if (ad != null) {
          final alternative = q.alternatives!
              .where((a) => a.alternativaId == ad.respuestaMarcada)
              .first;
          if (q.respuesta == alternative.codigo) {
            correctos++;
          } else {
            errores++;
          }
        }
      }
    }
    blancos = total - (correctos + errores);
    final questionE =
        totalQuestion.where((element) => element.preguntaPadreId == id).first;
    final simulacrum = DrowpdownSimulacroModel(
      area: questionE.area!,
      correct: correctos,
      error: errores,
      unAnswered: blancos,
    );
    resultadoAreas.add(simulacrum);

    //totales
    totalArea = totalArea + total;
    totalMarked = totalMarked + (correctos + errores);
    totalUnmarked = totalUnmarked + blancos;
    totalCorrect = totalCorrect + correctos;
  }
  return [totalArea, totalMarked, totalUnmarked, totalCorrect, resultadoAreas];
}

class DrowpdownSimulacroModel {
  String area;
  int correct;
  int error;
  int unAnswered;
  DrowpdownSimulacroModel({
    required this.area,
    required this.correct,
    required this.error,
    required this.unAnswered,
  });
}

class RadioButtonListAlternativeSimulacrum extends StatefulWidget {
  RadioButtonListAlternativeSimulacrum({
    required this.alternatives,
    required this.area,
    required this.isOffline,
    required this.respuesta,
    this.selected,
    super.key,
  });
  List<PrepareAlternativeEntity> alternatives;
  PrepareAreaCommonEntity area;
  PrepareAlternativeEntity? selected;
  bool isOffline;
  String respuesta;

  @override
  State<RadioButtonListAlternativeSimulacrum> createState() =>
      _RadioButtonListAlternativeSimulacrumState();
}

class _RadioButtonListAlternativeSimulacrumState
    extends State<RadioButtonListAlternativeSimulacrum> {
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
                                  color: getChecKBorderColor(
                                      isSelected,
                                      isCorrect,
                                      widget.selected!.codigo != null,
                                      noSelected,
                                      ),
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

class RadioButtonListAlternativeSimulacrumNoResponse extends StatefulWidget {
  RadioButtonListAlternativeSimulacrumNoResponse({
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
  State<RadioButtonListAlternativeSimulacrumNoResponse> createState() =>
      _RadioButtonListAlternativeSimulacrumNoResponseState();
}

class _RadioButtonListAlternativeSimulacrumNoResponseState
    extends State<RadioButtonListAlternativeSimulacrumNoResponse> {
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
                );
                context
                    .read<PrepareExamBloc>()
                    .add(AddRespuestaSimulacrum(history: respuesta));
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
                                  );
                                  context.read<PrepareExamBloc>().add(AddRespuestaSimulacrum(history: respuesta));
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
                          dataOffline(alternative, isSelected, isCorrect,widget.selected)
                        else
                          dataOnline(alternative, isSelected, isCorrect,widget.selected),
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
