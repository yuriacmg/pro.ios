// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/botton_right_outline_ligth_widget.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/modules/login/bloc/code_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/register_account_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/widget/custom_code_input.dart';
import 'package:perubeca/app/modules/login/widget/text_local_widget.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CodePage extends StatefulWidget {
  CodePage({required this.register, super.key});
  RegisterAccountSendModel register;

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final _timerController = CountdownController(autoStart: true);
  bool newCode = false;
  @override
  void initState() {
    super.initState();
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
                  child: Column(
                    children: [
                      BackAppBardCommoMini(),
                      const Divider(color: Colors.transparent),
                      SizedBox(
                          width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: 'Confirmar código de validación',
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
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 10,
                                top: 20,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextLocalWidget(text:'Hemos enviado un código de validación al correo electrónico del representante legal o apoderado:'),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                  child: Text(
                                    hiddenCorreo(widget.register.vCorreo!),
                                    textAlign: TextAlign.left,
                                    maxLines: 5,
                                    style: const TextStyle(
                                      fontFamily: ConstantsApp.OPRegular,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ConstantsApp.purpleTerctiaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 40,
                                  ),
                                  child: TextLocalWidget(
                                    text: 'Por favor ingresa código:',
                                  ),
                                ),
                              ],
                            ),
                            const CustomCodeInput(length: 6),
                            const Divider(color: Colors.transparent),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              //color: const Color(0xff9B1C6D),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: !newCode
                                        ? null
                                        : () {
                                            //reenviar codigo
                                           context.read<LoginBloc>().add(RegisterAccountEvent(widget.register, true));
                                          },
                                    child: Text(
                                      'Reenviar código',
                                      style: TextStyle(
                                        color: newCode
                                            ? ConstantsApp.purpleTerctiaryColor
                                            : Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: ConstantsApp.OPMedium,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Countdown(
                                    controller: _timerController,
                                    seconds: 180,
                                    build: (_, double time) {
                                      final duracion = Duration(seconds: time.toInt());
                                      final tiempoFormateado = "${duracion.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duracion.inSeconds.remainder(60).toString().padLeft(2, '0')}";

                                      return Text(
                                        tiempoFormateado,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: ConstantsApp.OPMedium,
                                        ),
                                      );
                                    },
                                    onFinished: () async {
                                      // que hacer cuando finaliza el timer
                                      context.read<CodeBloc>().add(CodeCleanEvent());
                                      setState(() {
                                        newCode = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<CodeBloc, CodeState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BottonRightOutlineLigthWidget(
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'Cancelar',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    BottonCenterWidget(
                                      isEnabled: state is CodeChangeState ? state.code.length == 6: false,
                                      ontap: state is CodeChangeState && state.code.length == 6
                                          ? () {
                                              FocusScope.of(context).unfocus();
                                              final send = ValidAccountSendModel(
                                                uiDTransacion:widget.register.uiDTransacion,
                                                vCodigo: state.code,
                                                vCorreo: widget.register.vCorreo,
                                                vNroDocumento: widget.register.vNroDocumento,
                                              );

                                              context.read<LoginBloc>().add(ValidAccountEvent(send));
                                            }
                                          : () {},
                                      text: 'Aceptar',
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoadingState) {
                  context.read<LoaderCubit>().showLoader();
                }

                if (state is ValidAccountSuccessState) {
                  context.read<LoaderCubit>().hideLoader();
                  //mostrar mensaje de registro exitoso
                  final alert = DialogInformWidget(
                    title: 'Información',
                    message: 'Registro Exitoso',
                    ontap: () {
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

                if (state is RegisterAccountSuccessState) {
                  context.read<LoaderCubit>().hideLoader();
                  if(state.isResend){
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
                    _timerController.onRestart!();    
                    setState(() {
                       newCode = false;
                    }); 
                  }
                }

                if (state is ErrorValidAccountState) {
                  context.read<LoaderCubit>().hideLoader();
                  context.read<CodeBloc>().add(CodeCleanEvent());
                  UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL VALIDAR EL CÓDIGO');
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
