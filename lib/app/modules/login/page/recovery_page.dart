// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/cubit/loader_cubit.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/back_app_common_mini.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/dialog_inform_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/model/recovery_password_send_model.dart';
import 'package:perubeca/app/modules/login/widget/input_label_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  final documentController = TextEditingController();
  final scrollController = ScrollController();

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
                        SizedBox(
                          width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                               const Divider(color: Colors.transparent),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text: 'Recupera tu contraseña',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: ConstantsApp.OPBold,
                                      fontWeight: FontWeight.bold,
                                      color: ConstantsApp.textBluePrimary,
                                    ),
                                  ),
                                  textScaler: TextScaler.linear((constraints.maxWidth > 1000) ? 2 : 1,
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
                                          'Te enviamos un código para que puedas recuperar tu cuenta.',
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
                                controller: documentController,
                                label: 'DNI',
                                placeholder: 'Ej.: 12345678',
                                maxLength: 8,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Ingrese su DNI';
                                  }

                                  if(value.length != 8){
                                    return 'El DNI debe tener 8 dígitos';
                                  }

                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: BottonCenterWidget(ontap: () {
                                    if(_formKey.currentState!.validate()){
                                      FocusScope.of(context).unfocus();
                                      final send = RecoveryPasswordSendModel(
                                        vNroDocumento: documentController.text,
                                        uiDTransacion: '',
                                      );
                                      context.read<LoginBloc>().add(LoginRecoveryPasswordCodeEvent(send, false));
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
              listener:  (context, state) {
              if(state is LoginLoadingState){
                context.read<LoaderCubit>().showLoader();
              }

              if(state is RecoveryPasswordCodeSuccessState){
                context.read<LoaderCubit>().hideLoader();
                if(state.isResend){
                  //message resend code
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
                }else{
                  Navigator.pushNamed(context, RoutesApp.codeRecovery, arguments: state.data);
                }
              }

              if(state is ErrorRecoveryPasswordCodeState){
                context.read<LoaderCubit>().hideLoader();
                UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL VALIDAR LA CUENTA');
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
