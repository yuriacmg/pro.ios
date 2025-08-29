// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/login_send_model.dart';
import 'package:perubeca/app/modules/login/model/recode_account_email_send_model.dart';
import 'package:perubeca/app/modules/login/widget/input_label_widget.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool viewPassword = true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      emailController.text = 'narvencito@gmail.com';
      passwordController.text = r'Sistemas1$';
      //emailController.text = 'valeria.flores.73@outlook.com.pe';
      //passwordController.text = r'D3m0l234$';
    }
  }

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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Image.asset(
                                  'assets/login/login_image.png',
                                  height: 150,
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: 'Iniciar sesión',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: ConstantsApp.OPBold,
                                    fontWeight: FontWeight.bold,
                                    color: ConstantsApp.textBluePrimary,
                                  ),
                                ),
                                textScaler: TextScaler.linear(
                                  (constraints.maxWidth > 1000) ? 2 : 1,
                                ),
                              ),
                              InputLabelWidget(
                                controller: emailController,
                                label: 'Correo',
                                placeholder: 'ejemplo@gmail.com',
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese su correo electronico';
                                  }

                                  if (!isValidEmail(value)) {
                                    return 'El correo electrónico no es valido.';
                                  }

                                  return null;
                                },
                              ),
                              InputLabelWidget(
                                controller: passwordController,
                                label: 'Contraseña',
                                placeholder: '***********',
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: viewPassword,
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
                              ),
                              const Divider(color: Colors.transparent),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesApp.recovery);
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    color: Color(0xff323232),
                                    fontFamily: ConstantsApp.OPRegular,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.transparent),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed( context, RoutesApp.register);
                                },
                                child: const Text(
                                  'Crear cuenta',
                                  style: TextStyle(
                                    color: Color(0xff323232),
                                    fontFamily: ConstantsApp.OPRegular,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.transparent),
                              const Divider(color: Colors.transparent),
                              BottonCenterWidget(
                                ontap: () {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    final send = LoginSendModel(
                                      vContrasenia: passwordController.text,
                                      vCorreo: emailController.text,
                                    );
                                    context.read<LoginBloc>().add(LoginInitEvent(send));
                                  }
                                },
                                text: 'Siguiente',
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
                if (state is LoginLoadingState) {
                  context.read<LoaderCubit>().showLoader();
                }

                if (state is LoginSuccessState) {
                  context.read<LoaderCubit>().hideLoader();
                  context.read<LoginBloc>().setUserLocalLogin();
                  //context.read<LoginBloc>().activatePrepareUserLogin();
                  //vamos al perfil?
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesApp.profile);
                }

                if(state is RecodeAccountEmailInitSuccessState){
                  context.read<LoaderCubit>().hideLoader();
                  final send = RecodeAccountEmailSendModel(
                    uiDTransacion: '',
                    vCorreo: emailController.text,
                  );
                  Navigator.pushNamed( context, RoutesApp.codeRevalid, arguments: send);
                }

                if (state is ErrorRecodeAccountEmailState) {
                  context.read<LoaderCubit>().hideLoader();
                  UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL INICIAR SESIÓN');
                }

                if (state is ErrorState) {
                  context.read<LoaderCubit>().hideLoader();
                  if(state.error.value.first.errorCode == 108 ){
                      //redigirir a la pagina de pedir codigo
                      final alert = AlertImageMessageGenericWidget(
                      title: 'ERROR AL INICIAR SESIÓN',
                      message: 'Valida tu correo electrónico para iniciar sesión',
                      consultaId: 0,
                      onTap: () {
                        Navigator.pop(context);
                        //llamada servicio
                          final send = RecodeAccountEmailSendModel(
                            vCorreo: emailController.text,
                            uiDTransacion: '',
                          );
                        context.read<LoginBloc>().add(RecodeEmailInitEvent(send));
                      },
                      bottonTitle: 'Validar',
                      image: 'assets/alert_app.svg',
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                      
                  }else{
                    UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL INICIAR SESIÓN');
                  }
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
