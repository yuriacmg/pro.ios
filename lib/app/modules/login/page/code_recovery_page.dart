// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/botton_right_outline_ligth_widget.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/login/bloc/code_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_response_model.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/model/valid_account_send_model.dart';
import 'package:perubeca/app/modules/login/widget/custom_code_input.dart';
import 'package:perubeca/app/modules/login/widget/text_local_widget.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CodeRecoveryPage extends StatefulWidget {
  CodeRecoveryPage({required this.model, super.key});
  RecoveryPasswordResponseModel model;
  @override
  State<CodeRecoveryPage> createState() => _CodeRecoveryPageState();
}

class _CodeRecoveryPageState extends State<CodeRecoveryPage> {
  final _timerController = CountdownController(autoStart: true);
  bool newCode = false;

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
                      SizedBox(
                        width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                        child: Column(
                        children: [
                          const Divider(color: Colors.transparent),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: 'Mensaje enviado',
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
                                  child: TextLocalWidget(
                                    text:'Te enviamos un código para que puedas recuperar tu cuenta.',
                                    align: TextAlign.justify,
                                    ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                child: Text(
                                  hiddenCorreo(widget.model.value!.vCorreo!),
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
                                          //reenviar cocodigo
                                          final send = RecoveryPasswordSendModel(
                                            vNroDocumento: widget.model.value!.vNroDocumento,
                                            uiDTransacion: '',
                                          );
                                          context.read<LoginBloc>().add(LoginRecoveryPasswordCodeEvent(send, true));
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
                                    isEnabled: state is CodeChangeState
                                        ? state.code.length == 6
                                        : false,
                                    ontap: state is CodeChangeState &&
                                            state.code.length == 6
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            final send = ValidAccountSendModel(
                                              uiDTransacion: '',
                                              vCodigo: state.code,
                                              vCorreo: widget.model.value!.vCorreo,
                                              vNroDocumento: widget.model.value!.vNroDocumento,
                                            );
                                            context.read<LoginBloc>().add(ValidAccountRecoveryEvent(send));
                                          }
                                        : () {},
                                    text: 'Aceptar',
                                  ),
                                ],
                              );
                            },
                          )
                                            
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

                if (state is ValidAccountRecoverySuccessState) {
                  context.read<LoaderCubit>().hideLoader();
                  Navigator.pushNamed(context, RoutesApp.recoveryPassword, arguments: state.registerId);
                }
                
                if(state is RecoveryPasswordCodeSuccessState){
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
