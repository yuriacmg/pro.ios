// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, omit_local_variable_types, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, cascade_invocations, use_colored_box, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/seccion_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/scholarship_bloc/scholarship_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/reniec_send_model.dart';
import 'package:perubeca/app/modules/scholarship/widget/termn_condition_modal.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_sub_page_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:super_tooltip/super_tooltip.dart';

class PageOne extends StatefulWidget {
  PageOne({
    required this.pageController,
    super.key,
  });
  PageController pageController;

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with SingleTickerProviderStateMixin {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  ScrollController scrollController = ScrollController();
  TextEditingController documentController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController ubigeoController = TextEditingController();
  TextEditingController digitoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController lastNameController2 = TextEditingController();

  final _controllerTooltip = SuperTooltipController();
  late TabController _tabController;

  DateTime? _selectedDate;
  DateTime? _selectedDateAux;

  final _formKey = GlobalKey<FormState>();

  bool isValidate = false;
  bool firstime = true;

  bool isAcepted = false;
  bool isRead = false;

  bool isVisible = true;

  //para mostrar los errores
  bool errorDNI = false;
  bool errorDate = false;
  bool errorUbigeo = false;
  bool errorDigito = false;
  bool errorPhone = false;

  List<SeccionEntity> sections = [];

  OverlayEntry? _overlayEntry;
  bool isloading = true;
  bool isVerify = false;

  @override
  void initState() {
    if (kDebugMode) {
      nameController.text = 'ZHARICK DE LOS ANGELES';
      lastNameController.text = 'VELIZ';
      lastNameController2.text = 'REYES';
      documentController.text = '77589081';
      ubigeoController.text = '190101';
      digitoController.text = '4';
      phoneController.text = '966966966';
      _selectedDateAux = DateTime.now();
      _selectedDate = DateTime(2012, 02, 08);
      // documentController.text = '80962771';
      // ubigeoController.text = '920411';
      // digitoController.text = '9';
      // _selectedDate = DateTime(2006, 05, 04);
      birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      isAcepted = true;
      isRead = true;
    }

    getDataInitial();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    internetConnection.internetStatus().listen((status) {
      if(status == ConnectionStatus.online){
        //llamada a la verificacion del estado de los servicios
        isVerify = true;
        verifyStatusServices();
      }

      setState(() {
        isVisible = (status == ConnectionStatus.offline);
      });
      _validateForm();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if(!isVerify){
        isloading = false;
        setState(() {});
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.pageController.addListener(_handlePageChange);
    });
  }

  @override
  void dispose() {
    resetAllDatos();
    internetConnection.close();
    scrollController.dispose();
    documentController.dispose();
    lastNameController.dispose();
    lastNameController2.dispose();
    nameController.dispose();
    birthdayController.dispose();
    digitoController.dispose();
    ubigeoController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> getDataInitial() async {
    final sectionbox = await Hive.openBox<SeccionEntity>('seccionBox');
    sections = sectionbox.values.toList();
    setState(() {});
  }

  void _handlePageChange() {
    if (widget.pageController.page!.round() == 0) {
      //clear controller
      resetAllDatos();
    }
  }

  void resetAllDatos() {
    // _formKey.currentState!.reset();
    documentController.clear();
    lastNameController.clear();
    lastNameController2.clear();
    nameController.clear();
    birthdayController.clear();
    digitoController.clear();
    ubigeoController.clear();
    phoneController.clear();
  }

  void showLoadingOverlay() {
    // Crear el OverlayEntry para mostrar el CircularProgressIndicator
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
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
      if (documentController.text.isNotEmpty &&
          birthdayController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          ubigeoController.text.isNotEmpty &&
          digitoController.text.isNotEmpty &&
          isAcepted &&
          isRead) {
        setState(() {
          isValidate = _formKey.currentState != null ? _formKey.currentState!.validate() : false;
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
    context.read<ScholarshipBloc>().initialState();
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

    if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) && error.statusCode! < 900) {
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
      title: isSpecial ?  error.value.first.title :  'NO PUDIMOS VALIDAR TU IDENTIDAD',
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

    isSpecial = false;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: Column(
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
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 20,
                                        left: 10,
                                        top: 10,
                                      ),
                                      child: GenericStylesApp().title(
                                        text: 'Ingresa tus datos \npersonales',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 20,
                                      ),
                                      child: GenericStylesApp().messagePage(
                                        text: 'Completa los campos para buscar las mejores opciones para tu perfil.',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10, left: 10),
                                      child: TitleSubPageWidget(
                                        title: 'Datos Personales',
                                      ),
                                    ),
                                    name(),
                                    lastName(),
                                    lastName2(),
                                    phone(),
                                    birthday(),
                                    document(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: ubigeo()),
                                        Expanded(child: digitoVerificador()),
                                      ],
                                    ),
                                    
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ubicacionDigito(constraints),
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.93,
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      borderRadius: BorderRadius.circular(2),
                                                      border: Border.all(
                                                        color: isAcepted ? Colors.blue : Colors.grey[500]!,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.transparent,
                                                      ),
                                                      child: Checkbox(
                                                        value: isAcepted,
                                                        hoverColor: Colors.transparent,
                                                        checkColor: Colors.blue,
                                                        activeColor: Colors.transparent,
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
                                                          fontFamily: ConstantsApp.OPMedium,
                                                          fontSize: 16,
                                                          color: Color(0xff343434),
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            recognizer: TapGestureRecognizer()
                                                              ..onTap = () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return TermsAndCondditionsModal(
                                                                      constraints: constraints,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            text: 'Términos y condiciones de uso de datos personales.',
                                                            style: const TextStyle(
                                                              fontFamily: ConstantsApp.OPSemiBold,
                                                              fontSize: 16,
                                                              color: ConstantsApp.purpleTerctiaryColor,
                                                              decoration: TextDecoration.underline,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(color: Colors.transparent, height: 7),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      borderRadius: BorderRadius.circular(2),
                                                      border: Border.all(
                                                        color: isRead ? Colors.blue : Colors.grey[500]!,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Theme(
                                                      data: Theme.of(context).copyWith(
                                                        unselectedWidgetColor: Colors.transparent,
                                                      ),
                                                      child: Checkbox(
                                                        value: isRead,
                                                        hoverColor: Colors.transparent,
                                                        checkColor: Colors.blue,
                                                        activeColor: Colors.transparent,
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
                                                      textAlign: TextAlign.justify,
                                                      text: const TextSpan(
                                                        text: 'Declaro que mis respuestas contienen información verdadera',
                                                        style: TextStyle(
                                                          fontFamily: ConstantsApp.OPMedium,
                                                          fontSize: 16,
                                                          color: Color(0xff343434),
                                                        ),
                                                        children: [
                                                          // TextSpan(
                                                          //   recognizer: TapGestureRecognizer()
                                                          //     ..onTap = () {
                                                          //       //print(                                                                'abriendo enlace');
                                                          //     },
                                                          //   text: 'Política de privacidad y tratamiento de datos.',
                                                          //   style: const TextStyle(
                                                          //     fontFamily: ConstantsApp.OPSemiBold,
                                                          //     fontSize: 16,
                                                          //     color: ConstantsApp.purpleTerctiaryColor,
                                                          //     decoration: TextDecoration.underline,
                                                          //   ),
                                                          // ),
                                                        ],
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BottonCenterWidget(
                                            isEnabled: isValidate,
                                            ontap: isValidate
                                                ? () {
                                                    FocusScope.of(context).unfocus();
                                                    final send = ReniecSendModel();
                                                    send.vNroDocumento = documentController.text;
                                                    send.vNombres = nameController.text.trim();
                                                    send.vApellidoPaterno = lastNameController.text.trim();
                                                    send.vApellidoMaterno = lastNameController2.text.trim();
                                                    send.dFechaNacimiento = DateFormat('yyyy-MM-dd').format(_selectedDate!);
                                                    send.vCodigoVerificacion = digitoController.text;
                                                    send.vUbigeo = ubigeoController.text;
                                                    send.vNroCelular = phoneController.text;
                                                    send.bTerminosCondiciones = isAcepted;
                                                    send.bDeclaracionInformacion = isRead;

                                                    if (isVisible) {
                                                      context.read<ScholarshipBloc>().setLocalUserReniec(
                                                          send, nameController.text, lastNameController.text, lastNameController2.text,);
                                                    } else {
                                                      context.read<ScholarshipBloc>().getUserReniecIsMinor(send);
                                                    }
                                                    //
                                                  }
                                                : () {},
                                            text: 'Continuar',
                                            // icon: Icons.navigate_next,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.22,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        BlocConsumer<ScholarshipBloc, ScholarshipState>(
                          listener: (context, state) {
                            // Puedes agregar lógica adicional cuando el estado cambie si es necesario
                          },
                          builder: (context, state) {
                            if (state is ErrorState) {
                              //error al obtener los resultados del api de reniec
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                hideLoadingOverlay();
                                errorMessage(state.error, state.isSpecial);
                              });
                            }

                            if (state is ScholarshipMinorLoadCompleteState) {
                              //data obtenida correctamente
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                //successMessage();
                                hideLoadingOverlay();
                                context.read<ScholarshipBloc>().initialState();
                                //movernos a la pagina de validacion
                                registerPageAnalytics('/Minor');
                                widget.pageController.jumpToPage(3);
                              });
                            }

                            if (state is ReniecPerformanceLoadCompleteState) {
                              //data obtenida correctamente
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                //successMessage();
                                hideLoadingOverlay();
                                context.read<ScholarshipBloc>().initialState();
                                //movernos a la pagina de performance
                                registerPageAnalytics('/Performance');
                                widget.pageController.jumpToPage(4);
                              });
                            }

                            if (state is ScholarshipLoadingState) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_overlayEntry == null) {
                                  showLoadingOverlay();
                                }
                              });
                            }

                            if (state is ScholarshipLocalSetState) {
                              context.read<ScholarshipBloc>().initialState();
                              widget.pageController.jumpToPage(1);
                            }

                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget phone() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 9,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'Celular',
          enabled: true,
          placeholder: 'Ej.: 966966966',
        ),
        onChanged: (value) {
          if (errorPhone) {
            setState(() {
              errorPhone = false;
            });
          }
        },
        validator: (value) {
          if (!errorPhone) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su número de celular.';
            }

            if (value.length != 9) {
              return 'El Celular tiene que tener 9 dígitos';
            }
            return null;
          } else {
            return 'Vuelva a ingresar su DNI (Ej.: 12345678)';
          }
        },
      ),
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
        readOnly: !kIsWeb,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
          DateInputFormatter(),
        ],
        showCursor: true,
        enableInteractiveSelection: kIsWeb,
        maxLength: 10,
        onTap: () {
          if (!kIsWeb) {
            _showDatePicker(context);
          }
        },
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          placeholder: 'dd/mm/aaaa',
          enabled: true,
          label: 'Fecha de nacimiento',
          icon: InkWell(
            onTap: () {
              if (kIsWeb) {
                _showDatePickerWeb(context);
              }
            },
            child: const Icon(
              Icons.calendar_month,
              color: Colors.purple,
            ),
          ),
        ),
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            if (value.length != 10 || !isValidDate(value)) {
              return 'Ingrese una fecha válida.';
            } else {
              _selectedDate = DateFormat('dd/MM/yyyy').parseStrict(value);
            }
          }
          return null;
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
          height: MediaQuery.of(context).size.height * 0.33,
          width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                padding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff083E6B).withOpacity(0.3),
                ),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                  _selectedDate = _selectedDateAux ?? DateTime.now();
                  birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
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
      DateFormat('dd/MM/yyyy').parseStrict(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isValidDate(String date) {
    // Validar la fecha
    try {
      DateFormat('dd/MM/yyyy').parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }

    Future<void> verifyStatusServices() async{
    final repository = getItApp.get<IUtilRepository>();
    final response = await repository.getStatusServices(1);
    if(!response.status){
      // no esta el servicio activo
      // mostrar el mensaje que corresponda
    }
    final data = response.data as StatusServicesResponseModel;
    final isActive = data.value.servicios.any((servicio) => !servicio.rptaBool);

  if (isActive) {
    // se crea el mensaje a enviar
    final elements = data.value.servicios.where((element) => element.rptaBool == false).toList();
  
    final message = elements.first.mensaje;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorRequestServerWidget(message: message, ontap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        },);
      },
    );
  } else{
    setState(() {
      isloading = false;
    });
  }

  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.text.length > oldValue.text.length && newValue.text.length < 10) {
      if (newValue.text.length == 2 || newValue.text.length == 5) {
        text += '/';
      }
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
