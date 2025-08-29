// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation, avoid_positional_boolean_parameters, avoid_bool_literals_in_conditional_expressions

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/widget/input_label_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/termn_condition_modal.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:super_tooltip/super_tooltip.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final documentController = TextEditingController();
  final birthdayController = MaskedTextController(mask: '00/00/0000');
  final ubigeoController = TextEditingController();
  final digitController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final scrollController = ScrollController();
  final _controllerTooltip = SuperTooltipController();
  late TabController _tabController;

  DateTime? _selectedDate;
  bool isValidate = false;
  bool firstime = true;
  bool isAcepted = false;
  bool isRead = false;
  bool errorDNI = false;
  bool errorDate = false;
  bool errorUbigeo = false;
  bool errorDigito = false;

  bool viewPassword = true;
  bool viewPassword2 = true;

  //validaPassword
  bool _minLength = false;
  bool _containUppercase = false;
  bool _containLowercase = false;
  bool _containNumber = false;
  bool _containSpecial = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    //if (kDebugMode) {
    //  documentController.text = '70375530';
    //  ubigeoController.text = '080705';
    //  digitController.text = '1';
    //  emailController.text = 'narvencito@gmail.com';
    //  passwordController.text = 'Sistemas1*';
    //  repeatPasswordController.text = 'Sistemas1*';
    //  _selectedDate = DateTime(1989, 12, 27);
    //  birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    //  isAcepted = true;
    //  isRead = true;
    //}
  }

  void _validateForm() {
    if (!firstime) {
      if (documentController.text.isNotEmpty &
          birthdayController.text.isNotEmpty &
          ubigeoController.text.isNotEmpty &
          digitController.text.isNotEmpty &
          emailController.text.isNotEmpty &
          passwordController.text.isNotEmpty &
          repeatPasswordController.text.isNotEmpty &
          isAcepted &
          isRead) {
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
    context.read<LoginBloc>().add(LoginInitialEvent());
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
      title: 'NO PUDIMOS VALIDAR TU IDENTIDAD',
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

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BackAppBardCommoMini(),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width:
                              (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: 'Crea tu cuenta',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: ConstantsApp.OPBold,
                                    fontWeight: FontWeight.bold,
                                    color: ConstantsApp.textBluePrimary,
                                  ),
                                ),
                                textScaler: TextScaler.linear(
                                  (constraints.maxWidth > 1000) ? 2 : 1,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 10,
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Actualiza tus datos personales.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: ConstantsApp.OPRegular,
                                        fontSize: 16,
                                        color: ConstantsApp.colorBlackPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InputLabelWidget(
                                controller: documentController,
                                label: 'DNI',
                                placeholder: 'Ej.: 12345678',
                                maxLength: 8,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese su DNI';
                                  }

                                  if (value.length != 8) {
                                    return 'El DNI debe tener 8 dígitos';
                                  }

                                  return null;
                                },
                                onChange: (value) {
                                  _validateForm();
                                  return null;
                                },
                              ),
                              InputLabelWidget(
                                controller: birthdayController,
                                label: 'Fecha de nacimiento',
                                placeholder: 'Ej.: 15/07/1999',
                                readOnly: kIsWeb ? false : true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                                ],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                viewPassword: InkWell(
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
                                onTap: () {
                                  if (kIsWeb) {
                                    //_showDatePickerWeb(context);
                                  } else {
                                    _showDatePicker(context);
                                  }
                                },
                                onChange: (value) {
                                  if (errorDate) {
                                    setState(() {
                                      errorDate = false;
                                    });
                                  }
                                  setState(() {
                                    _selectedDate = DateFormat('dd/MM/yyyy').parse(value);
                                  });
                                  return null;
                                },
                                validator: (value) {
                                  if (!errorDate) {
                                    if (!validarFecha(value!)) {
                                      return 'Ingrese una fecha valida';
                                    }
                                    if (value.isEmpty) {
                                      return 'Ingrese su fecha de nacimiento.';
                                    }
                                    _selectedDate = DateFormat('dd/MM/yyyy').parse(birthdayController.text);
                                    return null;
                                  } else {
                                    return 'Vuelva a ingresar su fecha de nacimiento (Ej.: 01/12/2000)';
                                  }
                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InputLabelWidget(
                                      controller: ubigeoController,
                                      label: 'Ubigeo',
                                      placeholder: 'Ej.: 123456',
                                      maxLength: 6,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese su código de ubigeo';
                                        }
                                        if (value.length < 6) {
                                          return 'El código de ubigeo debe tener 6 digitos';
                                        }

                                        return null;
                                      },
                                      onChange: (value) {
                                        _validateForm();
                                        return null;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: InputLabelWidget(
                                      controller: digitController,
                                      label: 'Digito',
                                      placeholder: 'Ej.: 15/07/1999',
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 1,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese código de validación';
                                        }

                                        return null;
                                      },
                                      onChange: (value) {
                                        _validateForm();
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ubicacionDigito(constraints),
                              ),
                              InputLabelWidget(
                                controller: emailController,
                                label: 'Correo',
                                placeholder: 'Ej.: ejemplo@gmail.com',
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese su correo electronico';
                                  }

                                  if (!isValidEmail(value)) {
                                    return 'El correo electrónico no es valido.';
                                  }

                                  return null;
                                },
                                onChange: (value) {
                                  _validateForm();
                                  return null;
                                },
                              ),
                              InputLabelWidget(
                                controller: passwordController,
                                label: 'Ingresa tu contraseña',
                                placeholder: '***********',
                                obscureText: viewPassword,
                                maxLength: 12,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                viewPassword: IconButton(
                                  icon: viewPassword
                                      ? const Icon(Icons.visibility_off, color: Colors.grey)
                                      : const Icon(Icons.visibility, color: ConstantsApp.purplePrimaryColor),
                                  onPressed: () {
                                    setState(() {
                                      viewPassword = !viewPassword;
                                    });
                                  },
                                ),
                                onChange: (value) {
                                  _validateForm();
                                  setState(() {
                                    // Reiniciamos los estados de validación
                                    _minLength = false;
                                    _containUppercase = false;
                                    _containLowercase = false;
                                    _containNumber = false;
                                    _containSpecial = false;

                                    // Validación de longitud mínima
                                    if (value.length > 8) {
                                      _minLength = true;
                                    }

                                    // Validación de contenido
                                    for (final char in value.runes) {
                                      if (!_containUppercase && char >= 65 && char <= 90) {
                                        _containUppercase = true;
                                      } else if (!_containLowercase && char >= 97 && char <= 122) {
                                        _containLowercase = true;
                                      } else if (!_containNumber && char >= 48 && char <= 57) {
                                        _containNumber = true;
                                      } else if (!_containSpecial && (r'@#&$'.contains(String.fromCharCode(char)))) {
                                        _containSpecial = true;
                                      }
                                    }
                                  });
                                  return null;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La contraseña es requerida';
                                  }

                                  // Construir el mensaje de error
                                  String? errorMessage;
                                  if (!_minLength || !_containUppercase || !_containLowercase || !_containNumber || !_containSpecial) {
                                    return 'La contraseña no cumple con los criterios de seguridad';
                                  }

                                  return errorMessage;
                                },
                              ),
                              const Divider(),
                              InputLabelWidget(
                                controller: repeatPasswordController,
                                label: 'Ingrese nuevamente tu contraseña',
                                placeholder: '***********',
                                obscureText: viewPassword2,
                                maxLength: 12,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                viewPassword: IconButton(
                                  icon: viewPassword2
                                      ? const Icon(Icons.visibility_off, color: Colors.grey)
                                      : const Icon(Icons.visibility, color: ConstantsApp.purplePrimaryColor),
                                  onPressed: () {
                                    setState(() {
                                      viewPassword2 = !viewPassword2;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese su contraseña nuevamente';
                                  }

                                  if (value != passwordController.text) {
                                    return 'las contraseñas no son iguales';
                                  }

                                  return null;
                                },
                                onChange: (value) {
                                  _validateForm();
                                  return null;
                                },
                              ),
                              validPasswordMessage('¿Tiene un mínimo de 8 caracteres?', _minLength),
                              validPasswordMessage(r'¿Contiene un símbolo (@, #, & o $)?', _containSpecial),
                              validPasswordMessage('¿Contiene una letra mayúscula?', _containUppercase),
                              validPasswordMessage('¿Tiene un mínimo número?', _containNumber),
                              validPasswordMessage('¿Contiene una letra minúscula?', _containLowercase),
                              const Divider(color: Colors.transparent),
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
                              const Divider(color: Colors.transparent),
                              BottonCenterWidget(
                                isEnabled: isValidate,
                                ontap: isValidate
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          final send = RegisterAccountSendModel(
                                            vNroDocumento: documentController.text,
                                            vCorreo: emailController.text,
                                            vContrasenia: passwordController.text,
                                            vUbigeo: ubigeoController.text,
                                            vDigitoVerificador: digitController.text,
                                            uiDTransacion: '',
                                            dFechaNacimiento: DateFormat('yyyy-MM-dd').format(_selectedDate!),
                                            bDeclaracionInformacion: true,
                                            bTerminosCondiciones: true,
                                          );

                                          context.read<LoginBloc>().add(RegisterAccountEvent(send, false));
                                        }
                                      }
                                    : () {},
                                text: 'Crear cuenta',
                              ),
                              const Divider(color: Colors.transparent),
                              const Divider(color: Colors.transparent),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoadingState) {
                  context.read<LoaderCubit>().showLoader();
                }

                if (state is RegisterAccountSuccessState) {
                  context.read<LoaderCubit>().hideLoader();
                  if (state.isResend) {
                    //message ressend message
                    final alert = DialogInformWidget(
                      title: 'Información',
                      message: 'Se envio nuevamente el código',
                      ontap: () {
                        Navigator.pop(context);
                      },
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    Navigator.pushNamed(context, RoutesApp.code, arguments: state.send);
                  }
                }

                if (state is ErrorRegisterAccountState) {
                  context.read<LoaderCubit>().hideLoader();
                  errorMessage(state.error);
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget validPasswordMessage(String text, bool valid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Image.asset(valid ? 'assets/login/check.png' : 'assets/login/close.png', scale: 1.6),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              text,
              style: const TextStyle(fontFamily: ConstantsApp.RBRegular, fontSize: 15, color: ConstantsApp.colorBlackPrimary),
            ),
          ),
        ],
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
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectedDate = _selectedDate ?? DateTime.now();
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
    final picked = await showDatePicker(
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

  Future<bool> _willPopCallback() async {
    if (_controllerTooltip.isVisible) {
      await _controllerTooltip.hideTooltip();
      return false;
    }
    return true;
  }
}
