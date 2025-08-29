// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation, use_build_context_synchronously, inference_failure_on_instance_creation

import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perubeca/app/common/widgets/back_appbar_rectangle_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
// import 'package:perubeca/app/database/entities/prepare/prepare_area_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/download_file_bloc/download_file_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/prepare_exam/prepare_exam_bloc.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_exam_simulacrum_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/generic_card_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/repeat_prepare_exam_alert.dart';
import 'package:perubeca/app/modules/scholarship/widget/result_evaluation_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:share_plus/share_plus.dart';

class ExamResultSimulacrumPage extends StatefulWidget {
  ExamResultSimulacrumPage({
    required this.area,
    required this.redesign,
    required this.history,
    required this.dropdown,
    required this.generalCode,
    super.key,
  });
  PrepareAreaCommonEntity area;
  bool redesign;
  PrepareHistoryEntity history;
  List<DrowpdownSimulacroModel> dropdown;
  int generalCode;

  @override
  State<ExamResultSimulacrumPage> createState() =>
      _ExamResultSimulacrumPageState();
}

class _ExamResultSimulacrumPageState extends State<ExamResultSimulacrumPage> {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  late String fullName = '';
  String formato = 'dd/MM/yyyy hh:mm:ss a';
  OverlayEntry? _overlayEntry;
  late File fileAdd;
  bool isFile = false;
  late DrowpdownSimulacroModel selected;
  bool isOffline = false;
  late PrepareUserEntity userFound;
  final GlobalKey imageKey = GlobalKey();

  int totalCorrect = 0;

  bool isTablet = false;

  @override
  void initState() {
    super.initState();
    initData();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      internetConnection.internetStatus().listen((status) {
        isOffline = (status == ConnectionStatus.offline);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isTabletMethod();
  }

  Future<void> isTabletMethod() async {
    isTablet = await isTabletOrIPad();
  }

  Future<bool> isTabletOrIPad() async {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    var isTabletAux = shortestSide >= 600;

    if (isTabletAux && Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      isTabletAux = iosInfo.model.toLowerCase().contains('ipad');
    }

    return isTabletAux;
  }

  Future<void> initData() async {
    selected = widget.dropdown.first;
    // final prepareAreabox = await Hive.openBox<PrepareAreaEntity>('prepareAreaBox');
    final prepareUserBox =
        await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    final users = prepareUserBox.values.toList();
    userFound = users.where((element) => element.status! == true).first;
    // final areas = prepareAreabox.values.toList();
    fullName = '${userFound.nombre!.split(' ').first} ${userFound.apePaterno!}';

    final prepareHistorybox =
        await Hive.openBox<PrepareHistoryEntity>('prepareHistoryBox');
    final listHistories = prepareHistorybox.values.toList();
    var histories = listHistories
        .where(
          (element) =>
              element.areaCode == widget.area.codigo &&
              element.numberDoc == userFound.numdoc,
        )
        .toList()
        .length;
    widget.history.userName = fullName;
    widget.history.numberDoc = userFound.numdoc;
    widget.history.attempsNumber = ++histories;
    await prepareHistorybox.add(widget.history);

    totalCorrect = widget.dropdown
        .fold(0, (previousValue, element) => previousValue + element.correct);
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
    return WillPopScope(
      onWillPop: () async {
        await context.read<PrepareExamBloc>().getDataInitial(
              widget.area.codigo!,
              userFound.numdoc!,
              widget.area.codigoPreparate!,
              widget.generalCode,
            );
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Stack(
        children: [
          ResultEvaluationWidget(
              imageKey: imageKey,
              total: totalCorrect.toString(),
              area: 'admisión.',),
          BackgroundCommon(
            child: Column(
              children: [
                BackAppBarRectangleCommon(
                  ontap: () {
                    context.read<PrepareExamBloc>().getDataInitial(
                          widget.area.codigo!,
                          userFound.numdoc!,
                          widget.area.codigoPreparate!,
                          widget.generalCode,
                        );
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
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
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: GenericStylesApp().title(
                                  text: fullName,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: GenericStylesApp().messageJustifyPage(
                                  text:
                                      'Estos son los resultados de tu simulacro de admisión.',
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 15, bottom: 5,),
                                    child: GenericStylesApp()
                                        .subTitle2(text: 'Tus resultados'),
                                  ),
                                ],
                              ),
                              GenericCardWidget(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(color: Colors.transparent),
                                    title('N° de intentos'),
                                    const Divider(color: Colors.transparent),
                                    Center(
                                      child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff557CA4),
                                        maxRadius: 30,
                                        child: Text(
                                          widget.history.attempsNumber
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    iconText(
                                        Icons.refresh, 'Intentar nuevamente',
                                        () {
                                      //abrir modal
                                      final alert = RepeatPrepareExamAlert(
                                        text: widget.area.nombre!,
                                        isView: false,
                                        onTap: () {
                                          context
                                              .read<PrepareExamBloc>()
                                              .getDataInitial(
                                                widget.area.codigo!,
                                                userFound.numdoc!,
                                                widget.area.codigoPreparate!,
                                                widget.generalCode,
                                              );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          // Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  PrepareExamSimulacrumPage(
                                                area: widget.area,
                                                redesign: widget.redesign,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    }),
                                    const Divider(color: Colors.transparent),
                                  ],
                                ),
                              ),
                              GenericCardWidget(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(color: Colors.transparent),
                                    title('Información principal'),
                                    const Divider(color: Colors.transparent),
                                    titleSubtitle('Simulacro', 'Completado'),
                                    // titleSubtitle('N° de ingresos', widget.history.inputNumber!.toString()),
                                    titleSubtitle(
                                        'Fecha de inicio',
                                        DateFormat(formato)
                                            .format(widget.history.startDate!),),
                                    titleSubtitle(
                                        'Fecha de fin',
                                        DateFormat(formato)
                                            .format(widget.history.startEnd!),),
                                    iconText(Icons.download,
                                        'Descargar solucionario', () {
                                      if (kIsWeb) {
                                        context
                                            .read<DownloadFileBloc>()
                                            .downloadFileWbSolution(
                                                widget.area.codigo!,);
                                      } else {
                                        if (isOffline) {
                                          context
                                              .read<DownloadFileBloc>()
                                              .downloadFileSolutionOffline(
                                                  widget.area.codigo!,
                                                  'simulacro',);
                                        } else {
                                          context
                                              .read<DownloadFileBloc>()
                                              .downloadFileSolution(
                                                  widget.area.codigo!,);
                                        }
                                      }
                                    }),
                                    const Divider(color: Colors.transparent),
                                  ],
                                ),
                              ),
                              BottonRightWidget(
                                size: 200,
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PrepareExamSimulacrumPage(
                                          area: widget.area,
                                          redesign: widget.redesign,
                                          viewResponseGeneral: true,
                                          viewResponseButton: true,
                                          //areaUserHistory: widget.areaUserHistory,
                                          //generalCode: widget.generalCode,
                                        );
                                      },
                                    ),
                                  );
                                },
                                text: 'Verificar Respuestas',
                              ),
                              //GenericCardWidget(
                              //  child: Column(
                              //    crossAxisAlignment: CrossAxisAlignment.start,
                              //    children: [
                              //      const Divider(color: Colors.transparent),
                              //      title('Resultado de la evaluación'),
                              //      const Divider(color: Colors.transparent),
                              //      titleSubtitle('Puntaje general', widget.history.score!.toStringAsPrecision(2)),
                              //    ],
                              //  ),
                              //),
                              GenericCardWidget(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(color: Colors.transparent),
                                    title('Resultado de la evaluación'),
                                    subtitlePage(
                                        'El siguiente gráfico muestra tu desempeño en el simulacro:',),
                                    const Divider(color: Colors.transparent),
                                    //dropdown
                                    SizedBox(
                                      height: 50,
                                      child: DropdownButtonFormField2(
                                        isExpanded: true,
                                        hint: Text(
                                          selected.area.isEmpty
                                              ? 'Seleccione'
                                              : selected.area,
                                        ),
                                        decoration: GenericStylesApp()
                                            .newInputDecorationOutlineDropdown(
                                          label: 'Área',
                                          enabled: true,
                                          placeholder: '',
                                          selected: selected.area.isEmpty,
                                        ),
                                        items: widget.dropdown
                                            .map(
                                              (item) => DropdownMenuItem<
                                                  DrowpdownSimulacroModel>(
                                                value: item,
                                                child: Text(
                                                  item.area,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ConstantsApp
                                                        .colorBlackSecondary,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) async {
                                          setState(() {
                                            selected = value!;
                                          });
                                        },
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconEnabledColor:
                                              ConstantsApp.purpleSecondaryColor,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          offset: const Offset(0, -4),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                                WidgetStateProperty.all(6),
                                            thumbVisibility:
                                                WidgetStateProperty.all(true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14,),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            PieChart(
                                              swapAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 500,),
                                              //swapAnimationCurve: Curves.linear,
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse,) {},
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                //centerSpaceRadius: 70,
                                                startDegreeOffset: 90,
                                                sections: showingSections(
                                                  selected.correct,
                                                  selected.error,
                                                  selected.unAnswered,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Divider(color: Colors.transparent),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IndicatorWidget(
                                          color: const Color(0xff116A48),
                                          text: 'Correcto',
                                        ),
                                        IndicatorWidget(
                                          color: const Color(0xff9E140D),
                                          text: 'Incorrecto',
                                        ),
                                        IndicatorWidget(
                                          color: Colors.orange,
                                          text: 'Sin respuesta',
                                        ),
                                      ],
                                    ),
                                    const Divider(color: Colors.transparent),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !kIsWeb && !isTablet,
            child: Positioned(
              bottom: 70,
              right: 10,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    final boundary =
                        imageKey.currentContext!.findRenderObject()!
                            as RenderRepaintBoundary;
                    var image = await boundary.toImage(pixelRatio: 3);

                    final byteData =
                        await image.toByteData(format: ui.ImageByteFormat.png);
                    final pngBytes = byteData!.buffer.asUint8List();

                    // Guarda la imagen en un archivo temporal
                    final tempDir = await getTemporaryDirectory();
                    final file =
                        await File('${tempDir.path}/widget_image.png').create();
                    await file.writeAsBytes(pngBytes);

                    // Comparte la imagen usando share_plus
                    await Share.shareXFiles([XFile(file.path)]);
                  },
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: ConstantsApp.purpleSecondaryColor,
                            child: Image.asset(
                              ConstantsApp.arrowSharedImage,
                              scale: 1.7,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: const Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Compartir',
                                style: TextStyle(
                                  color: ConstantsApp.purpleSecondaryColor,
                                  fontFamily: ConstantsApp.OPSemiBold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<DownloadFileBloc, DownloadFileState>(
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

              if (state is DownloadFileCompleteState) {
                //data obtenida correctamente
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  hideLoadingOverlay();
                  context.read<DownloadFileBloc>().initialState();
                  if (!kIsWeb) {
                    await OpenFile.open(state.response.value!.path);
                  }
                });
              }

              if (state is DownloadFileLoadingState) {
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
    );
  }

  List<PieChartSectionData> showingSections(
      int correct, int erros, int blancos,) {
    return List.generate(3, (i) {
      const fontSize = 30.0;
      const radius = 80.0;
      const shadows = [Shadow(blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff116A48),
            value: double.parse(correct.toString()),
            title: correct.toString(),
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize + 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffE78E17),
            value: double.parse(blancos.toString()),
            title: blancos.toString(),
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff9E140D),
            value: double.parse(erros.toString()),
            title: erros.toString(),
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize - 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: ConstantsApp.OPBold,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: ConstantsApp.OPBold,
          fontSize: 16,
          color: ConstantsApp.textBlackQuaternary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget titlePage(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: ConstantsApp.OPSemiBold,
          fontSize: 16,
          color: ConstantsApp.textBlackQuaternary,
        ),
      ),
    );
  }

  Widget subtitlePage(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 18,
          color: ConstantsApp.textBlackQuaternary,
        ),
      ),
    );
  }

  Widget titleSubtitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titlePage(title),
        subtitlePage(subtitle),
      ],
    );
  }

  Widget iconText(IconData icon, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: ConstantsApp.purpleTerctiaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(
                color: ConstantsApp.purpleTerctiaryColor,
                fontFamily: ConstantsApp.OPBold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  IndicatorWidget({
    required this.color,
    required this.text,
    super.key,
  });

  Color color;
  String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: ConstantsApp.OPRegular,
              fontSize: 13,
              color: ConstantsApp.textBlackQuaternary,
            ),
          ),
        ),
      ],
    );
  }
}
