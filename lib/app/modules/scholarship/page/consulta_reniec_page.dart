// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, omit_local_variable_types, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, cascade_invocations, use_colored_box, use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/modules/scholarship/bloc/reniec_bloc/reniec_review_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/widget/termn_condition_modal.dart';
// import 'package:perubeca/app/modules/scholarship/page/performance/performance_detail_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_sub_page_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ConsultaReniecPage extends StatefulWidget {
  ConsultaReniecPage({
    // required this.fatherPageController,
    required this.pageControllerChild,
    required this.value,
    super.key,
  });
  // PageController fatherPageController;
  PageController pageControllerChild;
  String value;

  @override
  State<ConsultaReniecPage> createState() => _ConsultaReniecPageState();
}

class _ConsultaReniecPageState extends State<ConsultaReniecPage>
    with SingleTickerProviderStateMixin {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  final documentController = TextEditingController();
  final nameLastNameController = TextEditingController();
  final birthdayController = MaskedTextController(mask: '00/00/0000');
  final ubigeoController = TextEditingController();
  final digitoController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController lastNameController2 = TextEditingController();

  final _controllerTooltip = SuperTooltipController();
  late TabController _tabController;

  DateTime? _selectedDate;
  DateTime? _selectedDateAux;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isValidate = false;
  bool firstime = true;

  bool isAcepted = false;
  bool isRead = false;

  bool isVisible = false;
  bool isVisiblePrepare = false;

  //para mostrar los errores
  bool errorDNI = false;
  bool errorDate = false;
  bool errorUbigeo = false;
  bool errorDigito = false;

  OverlayEntry? _overlayEntry;
  bool isloading = true;
  bool isVerify = false;

  @override
  void initState() {
    if (kDebugMode) {
      documentController.text = '72850117';
      ubigeoController.text = '240102';
      digitoController.text = '6';
      _selectedDateAux = DateTime.now();
      _selectedDate = DateTime(2005, 05, 09);
      // documentController.text = '70375530';
      // ubigeoController.text = '080705';
      // digitoController.text = '1';
      // _selectedDate = DateTime(1989, 12, 27);
      birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      isAcepted = true;
      isRead = true;
    }

    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      internetConnection.internetStatus().listen((status) {
        if(status == ConnectionStatus.online && widget.value == '2'){
          //llamada a la verificacion del estado de los servicios
          isVerify = true;
          verifyStatusServices();
        }
        setState(() {
          isVisible = (status == ConnectionStatus.offline);
          isVisiblePrepare =
              (widget.value == '2' && (status == ConnectionStatus.offline))
                  ? (status == ConnectionStatus.offline)
                  : true;
          if (isVisiblePrepare) {
            if (!kIsWeb) {
              _selectedDate = DateTime(2005, 05, 09);
            }
          }
        });
        _validateForm();
      });
      pageController.addListener(_handlePageChange);
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!isVerify) {
        isloading = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    resetAllDatos();
    internetConnection.close();
    scrollController.dispose();
    documentController.dispose();
    nameLastNameController.dispose();
    birthdayController.dispose();
    digitoController.dispose();
    ubigeoController.dispose();
    lastNameController.dispose();
    lastNameController2.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    if (pageController.page!.round() == 0) {
      //clear controller
      resetAllDatos();
    }
  }

  void resetAllDatos() {
    // _formKey.currentState!.reset();
    documentController.clear();
    nameLastNameController.clear();
    birthdayController.clear();
    digitoController.clear();
    ubigeoController.clear();
    lastNameController.clear();
    lastNameController2.clear();
    nameController.clear();
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

  void _validateForm() {
    if (!firstime) {
      if (
          documentController.text.isNotEmpty &&
          (!isVisible ? lastNameController.text.isNotEmpty : true) &&
          (!isVisible ? nameController.text.isNotEmpty : true) &&
          (!isVisible ? birthdayController.text.isNotEmpty : true) &&
          (!isVisible ? ubigeoController.text.isNotEmpty : true) &&
          (!isVisible ? digitoController.text.isNotEmpty : true) &&
          isAcepted &&
          isRead) {
        setState(() {
          isValidate = _formKey.currentState != null
              ? _formKey.currentState!.validate()
              : false;
        });
      } else {
        setState(() {
          isValidate = false;
        });
      }
    } else {
      firstime = !firstime;
    }
  }

  void errorMessage(ErrorResponseModel error, bool isSpecial) {
    context.read<ReniecReviewBloc>().initialState();
    if (error.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
      // no hay internet
      UtilCommon().noInternetNoDataModal(
        context: context,
        ontap: () {
          Navigator.pop(context);
        },
        visibleMessage: widget.value == '2' ? true : null,
      );
      return;
    }

    if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) &&
        error.statusCode! < 900 &&
        error.statusCode != getAppStatusCodeError(AppStatusCode.NOUSER)) {
      //error de servidor
      UtilCommon().erroServerModal(context: context);
      return;
    }

    String? messages = '';
    for (final e in error.value) {
      messages = (messages!.isEmpty ? e.message : '$messages\n${e.message}');
      if (e.message.contains('Documento')) {
        errorDNI = true;
      }

      if (e.message.contains('Fecha de Nacimiento')) {
        errorDate = true;
      }

      if (e.message.contains('Ubigeo')) {
        errorUbigeo = true;
      }

      if (e.message.contains('Código')) {
        errorDigito = true;
      }
    }

    final alert = AlertImageMessageGenericWidget(
      title: isSpecial ? error.value.first.title  : (error.statusCode == getAppStatusCodeError(AppStatusCode.NOUSER)
          ? 'Su DNI no ha sido registrado'
          : 'NO PUDIMOS VALIDAR TU IDENTIDAD'),
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

  String getTitle() {
    switch (widget.value) {
      case '0':
        return 'Revisa y firma tu postulación de la beca';
      case '1':
        return 'Consulta tu rendimiento académico';
      case '2':
        return 'Prepárate';
      default:
        throw Exception('Error');
    }
  }

  String getTitleSection() {
    switch (widget.value) {
      case '0':
        return 'Revisa y firma tu postulación de la beca';
      case '1':
        return 'Conoce tu información académica';
      case '2':
        return '¡Pon a prueba tus conocimientos!';
      default:
        throw Exception('Error');
    }
  }

  String getMessageSection() {
    switch (widget.value) {
      case '0':
        return 'Revisa y firma tu postulación de la beca';
      case '1':
        return 'Según la información proporcionada por tu colegio.';
      case '2':
        return 'Aquí te apoyaremos a reforzar tus conocimientos y prepararte para rendir los exámenes de admisión.';
      default:
        throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackAppBarCommon(
          title: getTitle(),
          subtitle: '',
          ontap: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: isloading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: scrollController,
                  physics: const ScrollPhysics(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 1000) {
                            _willPopCallback();
                          } else {
                            _willPopCallback();
                          }
                          return SizedBox(
                            width: (constraints.maxWidth > 1000)
                                ? MediaQuery.of(context).size.width * 0.5
                                : MediaQuery.of(context).size.width,
                            child: Form(
                              key: _formKey,
                              onChanged: _validateForm,
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20, left: 10,),
                                    child: GenericStylesApp().title(
                                      text:
                                          getTitleSection(), // el valor de 0 no se usa
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    child: GenericStylesApp().messagePage(
                                      text: getMessageSection(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 10,
                                      top: 10,
                                    ),
                                    child: TitleSubPageWidget(
                                      title: 'Datos personales',
                                    ),
                                  ),
                                  
                                   Visibility(
                                     visible: !isVisible,
                                     child: Column(
                                      children:[
                                        name(),
                                        lastName(),
                                        lastName2(),
                                        birthday(),
                                      ],
                                     ),
                                   ),
                                   document(),
                                  Visibility(
                                    visible: !isVisible,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: ubigeo()),
                                            Expanded(
                                                child: digitoVerificador(),),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ubicacionDigito(constraints),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10,),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.93,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8,
                                                  // top: 10,
                                                  bottom: 5,
                                                ),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2,),
                                                    border: Border.all(
                                                      color: isAcepted
                                                          ? Colors.blue
                                                          : Colors.grey[500]!,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      unselectedWidgetColor:
                                                          Colors.transparent,
                                                    ),
                                                    child: Checkbox(
                                                      value: isAcepted,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      checkColor: Colors.blue,
                                                      activeColor:
                                                          Colors.transparent,
                                                      onChanged: (value) {
                                                        isAcepted = value!;
                                                        if (firstime) {
                                                          setState(() {});
                                                        }
                                                        _validateForm();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.zero,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Acepto los ',
                                                      style: const TextStyle(
                                                        fontFamily: ConstantsApp
                                                            .OPMedium,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff343434),
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context,) {
                                                                      return TermsAndCondditionsModal(
                                                                        constraints:
                                                                            constraints,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                          text:
                                                              'Términos y condiciones de uso de datos personales.',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                ConstantsApp
                                                                    .OPSemiBold,
                                                            fontSize: 16,
                                                            color: ConstantsApp
                                                                .purpleTerctiaryColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                              color: Colors.transparent,
                                              height: 7,),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8,
                                                  // top: 20,
                                                  bottom: 10,
                                                ),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2,),
                                                    border: Border.all(
                                                      color: isRead
                                                          ? Colors.blue
                                                          : Colors.grey[500]!,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      unselectedWidgetColor:
                                                          Colors.transparent,
                                                    ),
                                                    child: Checkbox(
                                                      value: isRead,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      checkColor: Colors.blue,
                                                      activeColor:
                                                          Colors.transparent,
                                                      onChanged: (value) {
                                                        isRead = value!;
                                                        if (firstime) {
                                                          setState(() {});
                                                        }
                                                        _validateForm();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.zero,
                                                  child: RichText(
                                                    textAlign:
                                                        TextAlign.justify,
                                                    text: const TextSpan(
                                                      text:
                                                          'Declaro que mis respuestas contienen información verdadera',
                                                      style: TextStyle(
                                                        fontFamily: ConstantsApp
                                                            .OPMedium,
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff343434),
                                                      ),
                                                      children: [],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.transparent,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BottonRightWidget(
                                          isEnabled: isValidate,
                                          ontap: isValidate
                                              ? () {
                                                  final send = ReniecSendModel();
                                                  send.vNroDocumento = documentController.text;
                                                  send.dFechaNacimiento = DateFormat('yyyy-MM-dd').format(_selectedDate ?? DateTime .now());
                                                  send.vCodigoVerificacion = digitoController.text;
                                                  send.vUbigeo = ubigeoController.text;
                                                  send.vNombres = nameController.text.trim();
                                                  send.vApellidoPaterno = lastNameController.text.trim();
                                                  send.vApellidoMaterno = lastNameController2.text.trim();

                                                  FocusScope.of(context).unfocus();
                                                  if (widget.value == '0') {
                                                    context.read<ReniecReviewBloc>().getUserReniecFirma(send);
                                                  }

                                                  if (widget.value == '2') {
                                                    //prepare exam
                                                    if (!isVisible) {
                                                      final sendPrepare = ReniecPrepareSendModel();
                                                      sendPrepare.vNroDocumento = documentController.text;
                                                      sendPrepare.vNombres = nameController.text.trim();
                                                      sendPrepare.vApellidoPaterno = lastNameController.text.trim();
                                                      sendPrepare.vApellidoMaterno = lastNameController2.text.trim();
                                                      sendPrepare.dFechaNacimiento = DateFormat('yyyy-MM-dd') .format( _selectedDate ?? DateTime.now());
                                                      sendPrepare.vCodigoVerificacion = digitoController.text;
                                                      sendPrepare.vUbigeo = ubigeoController.text;
                                                      sendPrepare.bTerminosCondiciones = true;
                                                      sendPrepare.bDeclaracionInformacion = true;

                                                      context.read<ReniecReviewBloc>().getUserReniecPrepareExam(sendPrepare);
                                                    } else {
                                                      //cuando no hay internet
                                                      context.read<ReniecReviewBloc>().validUserPrepareExist( documentController.text);
                                                    }
                                                  }
                                                }
                                              : () {},
                                          text: 'Consultar',
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      BlocConsumer<ReniecReviewBloc, ReniecReviewState>(
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

                          if (state is ReniecReviewLoadCompleteState) {
                            //data obtenida correctamente
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              hideLoadingOverlay();
                              context.read<ReniecReviewBloc>().initialState();
                              widget.pageControllerChild.jumpToPage(1);
                            });
                          }

                          if (state is ReniecPrepareExamLoadCompleteState) {
                            //data obtenida correctamente
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              hideLoadingOverlay();
                              context.read<ReniecReviewBloc>().initialState();
                              registerPageAnalytics('/PrepareGeneral');
                              widget.pageControllerChild.jumpToPage(1);
                            });
                          }

                          if (state is ReniecReviewLoadingState) {
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
                ),
        ),
      ],
    );
  }

  Widget document() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: documentController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 8,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'DNI',
          enabled: true,
          placeholder: 'Ej.: 12345678',
        ),
        onChanged: (value) {
          if (errorDNI) {
            setState(() {
              errorDNI = false;
            });
          }
        },
        validator: (value) {
          if (!errorDNI) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su DNI.';
            }

            if (value.length != 8) {
              return 'El DNI tiene que tener 8 dígitos';
            }
            return null;
          } else {
            return 'Vuelva a ingresar su DNI (Ej.: 12345678)';
          }
        },
      ),
    );
  }

  Widget nameLastName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: nameLastNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[^0-9]')),
        ],
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'Ingresar nombres y apellidos',
          label: 'Nombres y apellidos',
        ),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (isVisible && (value == null || value.isEmpty)) {
            return 'Ingrese su nombre y apellido.';
          }
          return null;
        },
      ),
    );
  }

    Widget name() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: nameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúñÑÁÉÍÓÚüÜ\s]')),
        ],
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'Ingresar nombres ',
          label: 'Nombres',
        ),
        validator: (value) {
          if (isVisible && (value == null || value.isEmpty)) {
            return 'Ingrese su nombre.';
          }
          return null;
        },
      ),
    );
  }

  Widget lastName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: lastNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúñÑÁÉÍÓÚüÜ\s]')),
        ],
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'Ingresar apellido paterno',
          label: 'Apellido paterno',
        ),
        validator: (value) {
          if (isVisible && (value == null || value.isEmpty)) {
            return 'Ingrese su apellido paterno';
          }
          return null;
        },
      ),
    );
  }

  Widget lastName2() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: lastNameController2,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúñÑÁÉÍÓÚüÜ\s]')),
        ],
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'Ingresar apellido materno',
          label: 'Apellido materno',
        ),
        validator: (value) {
          return null;
        },
      ),
    );
  }

  Widget birthday() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: birthdayController,
        keyboardType: TextInputType.datetime,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: kIsWeb ? false : true,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
        ],
        onTap: () {
          if (kIsWeb) {
            //_showDatePickerWeb(context);
          } else {
            _showDatePicker(context);
          }
        },
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'dd/mm/aaaa',
          label: 'Fecha de nacimiento',
          icon: InkWell(
            onTap: () {
              if (kIsWeb) {
                _showDatePickerWeb(context);
              }
            },
            child: const Icon(
              Icons.calendar_month,
              color: ConstantsApp.purpleSecondaryColor,
            ),
          ),
        ),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          if (errorDate) {
            setState(() {
              errorDate = false;
            });
          }
          setState(() {
            _selectedDate = DateFormat('dd/MM/yyyy').parse(value);
          });
        },
        validator: (value) {
          if (!errorDate) {
            if (!validarFecha(value!)) {
              return 'Ingrese una fecha valida';
            }
            if (value.isEmpty) {
              return 'Ingrese su fecha de nacimiento.';
            }
            _selectedDate =
                DateFormat('dd/MM/yyyy').parse(birthdayController.text);
            return null;
          } else {
            return 'Vuelva a ingresar su fecha de nacimiento (Ej.: 01/12/2000)';
          }
        },
      ),
    );
  }

  Widget ubigeo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: ubigeoController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 6,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'Ubigeo',
          enabled: true,
          placeholder: 'Ej.: 123456',
        ),
        onChanged: (value) {
          if (errorUbigeo) {
            setState(() {
              errorUbigeo = false;
            });
          }
        },
        validator: (value) {
          if (!errorUbigeo) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su n° de ubigeo';
            }
            if (value.length != 6) {
              return 'Necesita 6 dígitos';
            }

            return null;
          } else {
            return 'Vuelva a ingresar su número \nde ubigeo.';
          }
        },
      ),
    );
  }

  Widget digitoVerificador() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: digitoController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'Dígito verificador',
          enabled: true,
          placeholder: 'Ej.: 1',
        ),
        onChanged: (value) {
          if (errorDigito) {
            setState(() {
              errorDigito = false;
            });
          }
        },
        validator: (value) {
          if (!errorDigito) {
            if (value == null || value.isEmpty) {
              return 'Ingrese el n° verificador';
            }

            if (value.length != 1) {
              return 'Necesita 1 dígito.';
            }

            return null;
          } else {
            return 'Vuelva a ingresar su digito \nverificador.';
          }
        },
      ),
    );
  }

  Widget ubicacionDigito(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: clipcontainer(constraints),
    );
  }

  Widget clipcontainer(BoxConstraints constraints) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: SuperTooltip(
        showBarrier: true,
        showCloseButton: true,
        controller: _controllerTooltip,
        borderColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: ConstantsApp.barrierColor,
        constraints: constraints,
        // left: 10,
        // right: 10,
        arrowTipDistance: 10,
        // popupDirection: TooltipDirection.down,
        //showCloseButton: ShowCloseButton.inside,
        closeButtonSize: 20,
        closeButtonColor: const Color(0xff083E6B),
        // touchThroughAreaShape: ClipAreaShape.oval,
        touchThroughAreaCornerRadius: 30,
        barrierColor: Colors.transparent,
        onHide: () async {
          await scrollController.animateTo(
            -94,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
        content: Container(
          margin: const EdgeInsets.only(top: 5),
          height: MediaQuery.of(context).size.height * 0.35,
          width: (constraints.maxWidth > 1000)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                padding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff083E6B).withOpacity(0.3),
                ),
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                indicatorWeight: 1,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff083E6B),
                  fontFamily: ConstantsApp.QSRegular,
                  fontWeight: FontWeight.bold,
                ),
                labelColor: const Color(0xff083E6B),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff083E6B),
                  fontFamily: ConstantsApp.QSRegular,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: '  DNI Azul  '),
                  Tab(text: '  DNI Electrónico  '),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Divider(
                  color: Color(0xff083E6B),
                  thickness: 1,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SvgPicture.asset(
                      ConstantsApp.dniA,
                      fit: BoxFit.fitHeight,
                    ),
                    Image.asset(
                      ConstantsApp.dniE2,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        child: InkWell(
          onTap: () async {
            final screenHeight = MediaQuery.of(context).size.height;
            final targetOffset = screenHeight * 0.45;
            await scrollController.animateTo(
              targetOffset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
            await _controllerTooltip.showTooltip();
          },
          child: const Center(
            child: Text(
              '¿Dónde está el ubigeo y dígito verificador?',
              style: TextStyle(
                color: ConstantsApp.purpleSecondaryColor,
                fontSize: 16,
                fontFamily: ConstantsApp.OPMedium,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    if (_controllerTooltip.isVisible) {
      await _controllerTooltip.hideTooltip();
      return false;
    }
    return true;
  }

  Future<void> _showDatePicker(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 350,
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: AppCustomScrollBehavior(),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _selectedDate ?? DateTime.now(),
                    minimumYear: 1925,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      _selectedDateAux = newDate;
                      _selectedDateAux = newDate;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectedDate = _selectedDateAux ?? DateTime.now();
                  birthdayController.text =
                      DateFormat('dd/MM/yyyy').format(_selectedDate!);
                  if (errorDate) {
                    setState(() {
                      errorDate = false;
                    });
                  }
                  _validateForm();
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDatePickerWeb(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1925),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _selectedDate = _selectedDate ?? DateTime.now();
      birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      if (errorDate) {
        setState(() {
          errorDate = false;
        });
      }
      _validateForm();
    }
  }

  void validateForm() {
    isValidate = _formKey.currentState!.validate();
  }

  bool validarFecha(String input) {
    try {
      final formattedDate = input.split('/').reversed.join('-');
      DateFormat('dd/MM/yyyy').parseStrict(input);
      DateTime.parse(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> verifyStatusServices() async {
    final repository = getItApp.get<IUtilRepository>();
    final response = await repository.getStatusServices(2);
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
              Navigator.pop(context);
            },
          );
        },
      );
    } else {
      setState(() {
        isloading = false;
      });
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
