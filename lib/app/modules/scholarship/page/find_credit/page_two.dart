// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation, unused_local_variable, sort_constructors_first, sdk_version_since, cascade_invocations, camel_case_types, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/botton_left_icon_widget.dart';
import 'package:perubeca/app/common/widgets/botton_right_icon_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_entity.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/option_bloc/option_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/procesar_data_bloc/procesar_data_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_page_two_children_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_card_page_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_page_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_sub_page_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/toggle_list_boton_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class DataMemory {
  int id;
  Widget child;
  String? selected;
  int sectionId;
  DataMemory({
    required this.id,
    required this.child,
    required this.sectionId,
    this.selected,
  });
}

class PageTwo extends StatefulWidget {
  PageTwo({
    required this.pageController,
    super.key,
  });
  PageController pageController;

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final internetConnection = CheckInternetConnection();
  final pageControllerchild = PageController();
  String selectedValueGEneral = 'Ninguna de las opciones';
  int currentPage = 1;
  OverlayEntry? _overlayEntry;
  bool isOffline = false;
  bool isLoading = true;
  bool isVerify = false;

  @override
  void initState() {
    pageControllerchild.addListener(() {
      setState(() {
        currentPage = pageControllerchild.page!.toInt() + 1;
      });
    });

    internetConnection.internetStatus().listen((status) {
      //if(status == ConnectionStatus.online){
      //  //llamada a la verificacion del estado de los servicios
      //  isVerify = true;
      //  verifyStatusServices();
      //}

      if (mounted) {
        setState(() {
          isOffline = (status == ConnectionStatus.offline);
        });
      }
    });
    context.read<OptionBloc>().getDataInitial();
    super.initState();
  }

  @override
  void dispose() {
    pageControllerchild.dispose();
    super.dispose();
  }

  Future<void> verifyStatusServices(ForeignProcessSendModel send) async {
    showLoadingOverlay();
    final repository = getItApp.get<IUtilRepository>();
    final response = await repository.getStatusServices(1);
    hideLoadingOverlay();
    if (!response.status) {
      // no esta el servicio activo
      // mostrar el mensaje que corresponda
    }
    final data = response.data as StatusServicesResponseModel;
    final isActive = data.value.servicios.any((servicio) => !servicio.rptaBool);

    if (isActive) {
      // se crea el mensaje a enviar
      final elements = data.value.servicios
          .where((element) => element.rptaBool == false)
          .toList();

      final message = elements.first.mensaje;
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorRequestServerWidget(
            message: message,
            ontap: () {
              Navigator.pop(context);
              widget.pageController.jumpToPage(4);
            },
          );
        },
      );
    } else {
      await context.read<ProcesarDataBloc>().procesarRespuesta(send);
    }
  }

  Widget createWidgetPage(int i, SeccionEntity s, OptionCompleteState state) {
    s.preguntas = state.questions!
        .where((element) => element.seccionId == s.seccionId)
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TitleSubPageWidget(
            title: s.nombre!,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ScrollConfiguration(
            behavior: AppCustomScrollBehavior(),
            child: Expanded(
              child: ListView.builder(
                itemCount: s.preguntas!.length,
                itemBuilder: (context, index) {
                  final p = s.preguntas![index]; //pregunta
                  //respuestaValues
                  RespuestaEntity? respuesta = RespuestaEntity();
                  var opcionSelected = PreguntaOpcionesEntity(valor: '');
                  var isDesableDropDown = false;
                  //respuesta ya procesada
                  final rptProcess = state.respuestasProcesadas!
                      .where((e) => e.idPregunta == p.preguntaId)
                      .firstOrNull;
                  if (rptProcess != null) {
                    if (rptProcess.valorRespuesta != 0) {
                      opcionSelected = p.opciones!
                          .where(
                            (element) =>
                                element.preguntaId == rptProcess.idPregunta &&
                                element.alternativaId ==
                                    rptProcess.valorRespuesta,
                          )
                          .first;
                    }
                  } else {
                    respuesta = state.respuestas! //respuesta
                        .where(
                          (element) =>
                              element.preguntaId == p.preguntaId &&
                              element.respuestaAutomatica!,
                        )
                        .firstOrNull;
                    opcionSelected = respuesta == null
                        ? PreguntaOpcionesEntity(valor: '')
                        : respuesta.alternativaRespuesta == 0
                            ? PreguntaOpcionesEntity(valor: '')
                            : (p.opciones!
                                .where(
                                  (element) =>
                                      element.preguntaId ==
                                          respuesta!.preguntaId &&
                                      element.alternativaId ==
                                          respuesta.alternativaRespuesta,
                                )
                                .first);
                  }

                  ToggleListBotonWidget toggle;
                  if ((respuesta != null &&
                          respuesta.alternativaRespuesta != null) &&
                      p.preguntaId == respuesta.preguntaId) {
                    isDesableDropDown = true;
                    toggle = ToggleListBotonWidget(
                      list: p.opciones!,
                      selected: opcionSelected,
                      isDisabled: true,
                      pregunta: p,
                    );
                  } else if (rptProcess != null &&
                      rptProcess.valorRespuesta != 0 &&
                      p.preguntaId == rptProcess.idPregunta) {
                    toggle = ToggleListBotonWidget(
                      list: p.opciones!,
                      selected: opcionSelected,
                      isDisabled: false,
                      pregunta: p,
                    );
                  } else {
                    toggle = ToggleListBotonWidget(
                      list: p.opciones!,
                      selected: PreguntaOpcionesEntity(valor: ''),
                      isDisabled: false,
                      pregunta: p,
                    );
                  }

                  if (p.tipoId == 1) {
                    String? selectedValue = '';
                    selectedValue = opcionSelected.valor.isEmpty
                        ? ((respuesta == null ||
                                respuesta.alternativaRespuesta == null)
                            ? ''
                            : respuesta.texto)
                        : opcionSelected.valor;
                    final dropdown = DropdownButtonFormField2(
                      isExpanded: true,
                      hint: Text(
                        selectedValue!.isEmpty ? 'Seleccione' : selectedValue,
                      ),
                      decoration:
                          GenericStylesApp().newInputDecorationOutlineDropdown(
                        label: p.titulolista,
                        enabled: isDesableDropDown,
                        placeholder: '',
                        selected: selectedValue.isEmpty,
                      ),
                      items: p.opciones!
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item.valor,
                              child: Text(
                                item.valor,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: ConstantsApp.colorBlackSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) async {
                        selectedValue = value.toString();
                        final option = p.opciones!
                            .where((element) => element.valor == value)
                            .first;

                        final respuesta = RespuestaProcesada(
                          idPregunta: p.preguntaId,
                          valorRespuesta: option.alternativaId,
                        );
                        context
                            .read<OptionBloc>()
                            .add(AddRespuestaProcesada(respuesta: respuesta));

                        if (setValueForException(
                            p.preguntaId!, option.alternativaId!,)) {
                          final respuesta = RespuestaProcesada(
                            idPregunta: ConstantsApp.idQuestionHide,
                            valorRespuesta: 0,
                          );
                          context
                              .read<OptionBloc>()
                              .add(AddRespuestaProcesada(respuesta: respuesta));
                        } else {
                          if (p.preguntaId == ConstantsApp.idQuestionPrimary) {
                            final respuesta = RespuestaProcesada(
                              idPregunta: ConstantsApp.idQuestionHide,
                              valorRespuesta: 0,
                            );
                            context.read<OptionBloc>().add(
                                RemoveRespuestaProcesada(respuesta: respuesta),);
                          }
                        }

                        setState(() {});
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                        iconEnabledColor: ConstantsApp.purpleSecondaryColor,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        offset: const Offset(0, -4),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: WidgetStateProperty.all(6),
                          thumbVisibility: WidgetStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 30,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    );

                    return Column(
                      children: [
                        Visibility(
                          visible: !(respuesta != null &&
                              rptProcess != null &&
                              rptProcess.valorRespuesta == 0),
                          child: CardPageTwoChildrenWidget(
                            children: [
                              TitleCardPageTwoWidget(
                                title: p.enunciado!,
                                subtitle: p.detalle,
                                icon: isOffline
                                    ? p.enlaceImgOffline
                                    : p.enlaceImg,
                                isOffline: isOffline,
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              SizedBox(height: 50, child: dropdown),
                            ],
                          ),
                        ),
                        if ((s.preguntas!.length - 1 == index) &&
                            i == state.sections!.length - 1)
                          messageFinal()
                        else
                          const SizedBox.shrink(),
                        bottonButtons(
                            i, index, s.preguntas!.length, state, s.seccionId!,),
                      ],
                    );
                  }

                  if (p.tipoId == 2) {
                    return Column(
                      children: [
                        CardPageTwoChildrenWidget(
                          children: [
                            TitleCardPageTwoWidget(
                              title: p.enunciado!,
                              subtitle: p.detalle,
                              icon:
                                  isOffline ? p.enlaceImgOffline : p.enlaceImg,
                              isOffline: isOffline,
                            ),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            if (respuesta != null &&
                                respuesta.preguntaId != null)
                              AddicionaInformation(respuesta: respuesta)
                            else
                              const SizedBox.shrink(),
                            toggle,
                          ],
                        ),
                        //message final
                        if ((s.preguntas!.length - 1 == index) &&
                            i == state.sections!.length - 1)
                          messageFinal()
                        else
                          const SizedBox.shrink(),
                        bottonButtons(
                            i, index, s.preguntas!.length, state, s.seccionId!,),
                      ],
                    );
                  }

                  if (p.tipoId == 3) {
                    return Column(
                      children: [
                        CardPageTwoChildrenWidget(
                          children: [
                            TitleCardPageTwoWidget(
                              title: p.enunciado!,
                              subtitle: p.detalle,
                              icon:
                                  isOffline ? p.enlaceImgOffline : p.enlaceImg,
                              isOffline: isOffline,
                            ),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            if (respuesta != null &&
                                respuesta.preguntaId != null)
                              AddicionaInformation(respuesta: respuesta)
                            else
                              const SizedBox.shrink(),
                            toggle,
                          ],
                        ),
                        //message final
                        if ((s.preguntas!.length - 1 == index) &&
                            i == state.sections!.length - 1)
                          messageFinal()
                        else
                          const SizedBox.shrink(),
                        bottonButtons(
                            i, index, s.preguntas!.length, state, s.seccionId!,),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool setValueForException(int idquestion, int idResponse) {
    if (idquestion == ConstantsApp.idQuestionPrimary &&
        ConstantsApp.listOptionExeption.contains(idResponse)) {
      return true;
    }
    return false;
  }

  Widget messageFinal() {
    return //message
        Container(
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10, bottom: 10),
            child: Icon(
              Icons.info,
              color: Color(0xffEB8C0A),
            ),
          ),
          Expanded(
            child: Text(
              'Cuando postules, deberás acreditar la información brindada con el documento correspondiente.',
              style: TextStyle(
                color: Color(0xff373E49),
                fontFamily: ConstantsApp.OPSemiBold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottonButtons(int i, int index, int preguntasLength,
      OptionCompleteState state, int sectionId,) {
    return Visibility(
      visible: index == preguntasLength - 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottonLeftIconWidget(
                ontap: () {
                  if (i == 0) {
                    if (isOffline) {
                      widget.pageController.jumpToPage(0);
                    } else {
                      registerPageAnalytics('/Performance');
                      widget.pageController.jumpToPage(4);
                    }
                  } else {
                    pageControllerchild.jumpToPage(i - 1);
                  }
                },
                text: 'Anterior',
                icon: Icons.navigate_before,
              ),
              BottonRightIconWidget(
                ontap: isActivate(sectionId, state)
                    ? (i == state.sections!.length - 1
                        ? () {
                            sendDataProcess(state);
                          }
                        : () {
                            pageControllerchild.jumpToPage(i + 1);
                          })
                    : () {},
                text: i == state.sections!.length - 1 ? 'Enviar' : 'Siguiente',
                icon: Icons.navigate_next,
                isEnabled: isActivate(sectionId, state),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  bool isActivate(int section, OptionCompleteState state) {
    var response = false;
    final preguntas = state.questions!
        .where((element) => element.seccionId == section)
        .toList();

    for (final element in preguntas) {
      final result = state.respuestasProcesadas!
          .where((e) => e.idPregunta == element.preguntaId)
          .firstOrNull;
      final respuesta = state.respuestas!
          .where((e) => e.preguntaId == element.preguntaId)
          .firstOrNull;
      if (result != null || respuesta != null) {
        response = true;
      } else {
        response = false;
        break;
      }
    }
    return response;
  }

  void sendDataProcess(OptionCompleteState state) {
    final list = state.respuestasProcesadas!.toList();
    for (final element in state.respuestas!) {
      final e =
          list.where((ele) => ele.idPregunta == element.preguntaId).firstOrNull;
      if (e == null) {
        list.add(RespuestaProcesada(
            idPregunta: element.preguntaId,
            valorRespuesta: element.alternativaRespuesta,),);
      }
    }

    final send = ForeignProcessSendModel(
      nroDocumento: state.user!.numDocumento,
      respuestas: list,
      apePaterno: state.user!.apellidoPaterno,
      apeMaterno: state.user!.apellidoMaterno,
      extranjero: false,
      nombres: state.user!.nombres,
      nroCelular: state.user!.numCelular,
      pais: '33',
      bDeclaracionInformacion: true,
      bTerminosCondiciones: true,
    );

    final birthday = state.user!.fechaNacimiento!;
    if (isOffline) {
      context.read<ProcesarDataBloc>().procesarRespuestaLocal(send, birthday);
    } else {
      //aqui hay que validar el servicio
      verifyStatusServices(send);
    }
  }

  void errorMessage(ErrorResponseModel error, bool isSpecial) {
    context.read<ProcesarDataBloc>().initialState();
    if (error.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
      // no hay internet
      UtilCommon().noInternetNoDataModal(
        context: context,
        ontap: () {
          Navigator.pop(context);
        },
      );
      return;
    }

    if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) &&
        error.statusCode! < 900) {
      //error de servidor
      UtilCommon().erroServerModal(context: context);
      return;
    }
    String? messages = '';
    for (final e in error.value) {
      messages = (messages!.isEmpty ? e.message : '$messages\n${e.message}');
    }

    final alert = AlertImageMessageGenericWidget(
      title: isSpecial ? error.value.first.title : 'ERROR!',
      message: messages!,
      consultaId: 0,
      onTap: () {
        Navigator.pop(context);
        setState(() {});
      },
      bottonTitle: 'Entendido',
      image: 'assets/alert_app.svg',
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
    return Stack(
      children: [
        BlocConsumer<OptionBloc, OptionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OptionCompleteState) {
              isLoading = false;
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      BackAppBarCommon(
                        title: 'Becas y créditos educativos',
                        subtitle: '',
                        backString: 'Regresar al menú',
                        ontap: () {
                          // widget.pageController.jumpToPage(0);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: (constraints.maxWidth > 1000)
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: GenericStylesApp().trackingText(
                                textblack: 'Paso $currentPage ',
                                textNormal: 'de ${state.sections!.length}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        child: TitlePageWidget(
                            text:
                                '${state.user!.nombres!.split(' ').first} ${state.user!.apellidoPaterno!}',),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: (constraints.maxWidth > 1000)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.sections!.length,
                            controller: pageControllerchild,
                            itemBuilder: (context, index) {
                              return createWidgetPage(
                                  index, state.sections![index], state,);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
        BlocConsumer<ProcesarDataBloc, ProcesarDataState>(
          listener: (context, state) {
            // Puedes agregar lógica adicional cuando el estado cambie si es necesario
          },
          builder: (context, state) {
            if (state is ErrorState) {
              //error al obtener los resultados del api de reniec
              // _overlayEntry = null;
              hideLoadingOverlay();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                errorMessage(state.error, state.isSpecial);
              });
            }

            if (state is ProcesarDataLoadCompleteState) {
              //data obtenida correctamente
              WidgetsBinding.instance.addPostFrameCallback((_) {
                //successMessage();
                hideLoadingOverlay();
                context.read<ProcesarDataBloc>().initialState();
                registerPageAnalytics('/AllScholarshipAllowed');
                widget.pageController.jumpToPage(2);
              });
            }

            if (state is ProcesarDataLoadingState) {
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
    );
  }
}

class AddicionaInformation extends StatelessWidget {
  const AddicionaInformation({
    required this.respuesta,
    super.key,
  });

  final RespuestaEntity? respuesta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (respuesta!.rptIcono!)
          const Icon(
            Icons.check_circle,
            color: Color(0xff0D5E3F),
          )
        else
          const Icon(
            Icons.warning_rounded,
            color: Color(0xff9D211B),
          ),
        Expanded(child: Html(data: respuesta!.texto)),
      ],
    );
  }
}
