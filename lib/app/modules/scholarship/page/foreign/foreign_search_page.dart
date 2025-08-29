// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, omit_local_variable_types, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, cascade_invocations, use_colored_box, use_build_context_synchronously, unnecessary_string_escapes, prefer_final_locals

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/static_data_constants.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/combo_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/scholarship_bloc/scholarship_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_send_model.dart';
import 'package:perubeca/app/modules/scholarship/widget/termn_condition_modal.dart';
import 'package:perubeca/app/modules/scholarship/widget/title_sub_page_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class ForeignSearchPage extends StatefulWidget {
  ForeignSearchPage({
    required this.pageController,
    super.key,
  });
  PageController pageController;

  @override
  State<ForeignSearchPage> createState() => _ForeignSearchPageState();
}

class _ForeignSearchPageState extends State<ForeignSearchPage> with SingleTickerProviderStateMixin {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  TextEditingController documentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController paternalSurnameController = TextEditingController();
  TextEditingController maternalSurnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isValidate = false;
  bool firstime = true;

  bool isAcepted = false;
  bool isRead = false;

  //para mostrar los errores
  bool errorDocument = false;

  List<ComboEntity> countries = [];
  List<ComboEntity> documentTypes = [];

  ComboEntity? selectedCountryValue = ComboEntity(generalId: 0, nombre: '');
  ComboEntity? selectedDocumentTypeValue = ComboEntity(generalId: 0, nombre: '');

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    if (kDebugMode) {
      documentController.text = '1600013101';
      nameController.text = 'Dante';
      paternalSurnameController.text = 'Quispe';
      maternalSurnameController.text = 'Mendez';
      phoneController.text = '966966966';
      isAcepted = true;
      isRead = true;
    }
    initData();
    super.initState();
    internetConnection.internetStatus().listen((status) {
      _validateForm();
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.pageController.addListener(_handlePageChange);
    });
  }

  @override
  void dispose() {
    resetAllDatos();
    internetConnection.close();
    documentController.dispose();
    nameController.dispose();
    paternalSurnameController.dispose();
    maternalSurnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> initData() async {
    final combobox = await Hive.openBox<ComboEntity>('comboBox');
    final list = combobox.values.toList();

    countries = list.where((element) => element.type == StaticDataConstants().typeCountry).toList();
    documentTypes = list.where((element) => element.type == StaticDataConstants().typeTramite).toList();

    setState(() {});
  }

  void _handlePageChange() {
    if (widget.pageController.page!.round() == 0) {
      //clear controller
      resetAllDatos();
    }
  }

  void resetAllDatos() {
    _formKey.currentState?.reset();
    documentController.clear();
    nameController.clear();
    paternalSurnameController.clear();
    maternalSurnameController.clear();
    phoneController.clear();
    selectedCountryValue = ComboEntity(generalId: 0, nombre: '');
    selectedDocumentTypeValue = ComboEntity(generalId: 0, nombre: '');
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
      if (selectedCountryValue!.nombre!.isNotEmpty && selectedDocumentTypeValue!.nombre!.isNotEmpty && isAcepted & isRead) {
        setState(() {
          isValidate = _formKey.currentState!.validate();
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

  void errorMessage(ErrorResponseModel error) {
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
    // for (final e in error.value) {
    //   messages = (messages!.isEmpty ? e.message : '$messages\n${e.message}');
    //   if (e.message.contains('Documento')) {
    //     errorDocument = true;
    //   }

    //   if (e.message.contains('Fecha de Nacimiento')) {
    //     errorDate = true;
    //   }

    //   if (e.message.contains('Ubigeo')) {
    //     errorUbigeo = true;
    //   }

    //   if (e.message.contains('Código')) {
    //     errorDigito = true;
    //   }
    // }

    final alert = AlertImageMessageGenericWidget(
      title: 'NO PUDIMOS VALIDAR TU IDENTIDAD',
      message: messages,
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

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: Column(
        children: [
          BackAppBarCommon(
            title: 'Beca para extranjeros',
            subtitle: '',
            backString: 'Regresar al menú',
            ontap: () {
              // widget.pageController.jumpToPage(0);
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              // controller: scrollController,
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
                        width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                        child: Form(
                          key: _formKey,
                          onChanged: _validateForm,
                          autovalidateMode: AutovalidateMode.disabled,
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
                              country(),
                              documentType(),
                              document(),
                              name(),
                              paternalSurname(),
                              maternalSurname(),
                              phone(),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BottonCenterWidget(
                                      isEnabled: isValidate,
                                      ontap: isValidate
                                          ? () {
                                              FocusScope.of(context).unfocus();
                                              final send = ForeignSendModel();
                                              send.vNroDocumento = documentController.text;
                                              send.vPais = selectedCountryValue!.generalId.toString();
                                              send.vTipoDocumento = selectedDocumentTypeValue!.generalId.toString();
                                              send.vNombres = nameController.text.trim();
                                              send.vApellidoPaterno = paternalSurnameController.text;
                                              send.vApellidoMaterno = maternalSurnameController.text;
                                              send.numCelular = phoneController.text.trim();
                                              send.bTerminosCondiciones = isAcepted;
                                              send.bDeclaracionInformacion = isRead;
                                              context.read<ScholarshipBloc>().getForeignSearch(send);
                                            }
                                          : () {},
                                      text: 'Continuar',
                                      // icon: Icons.navigate_next,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
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
                          errorMessage(state.error);
                        });
                      }

                      if (state is ScholarshipForeignLoadCompleteState) {
                        //data obtenida correctamente
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          //successMessage();
                          hideLoadingOverlay();
                          context.read<ScholarshipBloc>().initialState();
                          //movernos a la pagina de validacion
                          await registerPageAnalytics('/AllScholarshipAllowed');
                          widget.pageController.jumpToPage(1);
                        });
                      }

                      if (state is ScholarshipLoadingState) {
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
      ),
    );
  }

  Widget name() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: nameController,
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ\s]')),
        ],
        maxLength: 50,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          enabled: true,
          placeholder: 'Ingresar nombres',
          label: 'Nombres',
        ),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese sus nombres.';
          }
          return null;
        },
      ),
    );
  }

  Widget paternalSurname() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: paternalSurnameController,
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ\s]')),
        ],
        maxLength: 50,
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
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su apellido paterno.';
          }
          return null;
        },
      ),
    );
  }

  Widget maternalSurname() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: TextFormField(
        controller: maternalSurnameController,
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ\s]')),
        ],
        maxLength: 50,
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
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          // if (value == null || value.isEmpty) {
          //   return 'Ingrese su apellido materno.';
          // }
          return null;
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
        maxLength: 20,
        autovalidateMode: AutovalidateMode.disabled,
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'Número de documento',
          enabled: true,
          placeholder: 'Ej.: 12345678',
        ),
        onChanged: (value) {
          if (errorDocument) {
            setState(() {
              errorDocument = false;
            });
          }
        },
        validator: (value) {
          if (!errorDocument) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su número de documento.';
            }

            if (value.length < 8 || value.length > 20) {
              return 'El documento debe tener entre 8 y 20 dígitos';
            }
            return null;
          } else {
            return 'Vuelva a ingresar su documento (Ej.: 123456789)';
          }
        },
      ),
    );
  }

  Widget country() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: DropdownButtonFormField2(
        isExpanded: true,
        hint: Text(
          selectedCountryValue != null ? 'Seleccione país' : selectedCountryValue!.nombre!,
        ),
        decoration: GenericStylesApp().newInputDecorationOutlineDropdown2(
          label: 'País',
          enabled: true,
          placeholder: '',
        ),
        items: countries
            .map(
              (item) => DropdownMenuItem<ComboEntity>(
                value: item,
                child: dropdownMenu(item),
              ),
            )
            .toList(),
        onChanged: (value) async {
          setState(() {
            selectedCountryValue = value;
          });
          _validateForm();
        },
        iconStyleData: iconStyleDropdown(),
        dropdownStyleData: dropdownStyleData(),
        menuItemStyleData: menuStyleData(),
      ),
    );
  }

  Widget documentType() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: DropdownButtonFormField2(
        isExpanded: true,
        hint: Text(
          selectedDocumentTypeValue != null ? 'Seleccione tipo de documento' : selectedDocumentTypeValue!.nombre!,
        ),
        decoration: GenericStylesApp().newInputDecorationOutlineDropdown2(
          label: 'Tipo de documento',
          enabled: true,
          placeholder: '',
        ),
        items: documentTypes
            .map(
              (item) => DropdownMenuItem<ComboEntity>(
                value: item,
                child: dropdownMenu(item),
              ),
            )
            .toList(),
        onChanged: (value) async {
          setState(() {
            selectedDocumentTypeValue = value;
          });
          _validateForm();
        },
        iconStyleData: iconStyleDropdown(),
        dropdownStyleData: dropdownStyleData(),
        menuItemStyleData: menuStyleData(),
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
        maxLength: 16,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su número de celular.';
          }

          // if (value.length != 12) {
          //   return 'El Celular tiene que tener 9 dígitos';
          // }
          return null;
        },
      ),
    );
  }

  MenuItemStyleData menuStyleData() {
    return const MenuItemStyleData(
      height: 30,
      padding: EdgeInsets.only(left: 5),
    );
  }

  Widget dropdownMenu(ComboEntity item) {
    return Text(
      item.nombre!,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ConstantsApp.colorBlackSecondary,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  DropdownStyleData dropdownStyleData() {
    return DropdownStyleData(
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
    );
  }

  IconStyleData iconStyleDropdown() {
    return const IconStyleData(
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
      ),
      iconEnabledColor: ConstantsApp.purpleSecondaryColor,
      iconDisabledColor: Colors.grey,
    );
  }

  Future<bool> _willPopCallback() async {
    // if (_controllerTooltip.isVisible) {
    //   await _controllerTooltip.hideTooltip();
    //   return false;
    // }
    return true;
  }

  void validateForm() {
    isValidate = _formKey.currentState!.validate();
  }

  bool validarFecha(String input) {
    try {
      final formattedDate = input.split('/').reversed.join('-');
      DateTime.parse(formattedDate);
      return true;
    } catch (e) {
      return false;
    }
  }
}
