// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, inference_failure_on_function_invocation, avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/widget/input_label_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({required this.registerId, super.key});
  int registerId;

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
   bool viewPassword = true;
  bool viewPassword2 = true;

    //validaPassword
 bool _minLength = false;
 bool _containUppercase = false;
 bool _containLowercase = false;
 bool _containNumber = false;
 bool _containSpecial = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: SingleChildScrollView(
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
                        SizedBox(
                          width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              const Divider(color: Colors.transparent),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text: 'Restablecer la contraseña',
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
                                      Expanded(
                                        child: Text(
                                          'La contraseña debe tener como mínimo8 caracteres, un número, una letra mayúscula, una letra minúscula y un símbolo.',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: ConstantsApp.OPRegular,
                                            fontSize: 16,
                                            color: ConstantsApp.colorBlackPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const Divider(color: Colors.transparent),
                              InputLabelWidget(
                                controller: passwordController,
                                label: 'Nueva contraseña',
                                placeholder: '***********',
                                obscureText: viewPassword,
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
                              InputLabelWidget(
                                controller: repeatPasswordController,
                                label: 'Vuelve a escribir la contraseña',
                                placeholder: '***********',
                                obscureText: viewPassword2,
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
                              ),
                              validPasswordMessage('¿Tiene un mínimo de 8 caracteres?', _minLength),
                              validPasswordMessage(r'¿Contiene un símbolo (@, #, & o $)?',  _containSpecial),
                              validPasswordMessage('¿Contiene una letra mayúscula?', _containUppercase),
                              validPasswordMessage('¿Tiene un mínimo número?', _containNumber ),
                              validPasswordMessage('¿Contiene una letra minúscula?', _containLowercase),
                              const Divider(color: Colors.transparent),
                              Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: BottonCenterWidget(
                                  ontap: () {
                                    if(_formKey.currentState!.validate()){
                                      FocusScope.of(context).unfocus();
                                      final send = PasswordProfileUpdateSendModel(
                                        iAccion: 2,
                                        iRegistroId: widget.registerId,
                                        vContrasenia: passwordController.text,
                                        vPrefijo: '',
                                        vTelefono: '',
                                      );

                                      context.read<LoginBloc>().add(UpdatePasswordProfileEvent(send));
                                    }
                                }, 
                                text: 'Continuar',
                                ),
                              ),
                            
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
                if(state is LoginLoadingState){
                  context.read<LoaderCubit>().showLoader();
                }

                if(state is UpdatePasswordProfileSuccessState){
                  context.read<LoaderCubit>().hideLoader();
                  //message
                   final alert = DialogInformWidget(
                    title: 'Información',
                    message: 'Contraseña actualizado correctamente',
                    ontap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

                if(state is ErrorUpdatePasswordProfileState){
                  context.read<LoaderCubit>().hideLoader();
                  UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL ACTUALIZAR LA CONTRASEÑA');
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget validPasswordMessage( String text, bool valid){
    return Container( 
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(children: [
      Image.asset( valid? 'assets/login/check.png' : 'assets/login/close.png', scale: 1.6),
      Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Text(text, style: const TextStyle(fontFamily: ConstantsApp.RBRegular, fontSize: 15, color: ConstantsApp.colorBlackPrimary),),
      ),
    ],
    ),
    );
  }
}
