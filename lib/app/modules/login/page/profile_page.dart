// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation

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
import 'package:perubeca/app/modules/login/bloc/profile_bloc.dart';
import 'package:perubeca/app/modules/login/model/password_profile_update_send_model.dart';
import 'package:perubeca/app/modules/login/widget/input_label_widget.dart';
import 'package:perubeca/app/modules/login/widget/text_local_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final perfixCcontroller = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileDataEvent());
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
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if(state is ProfileInitialState){
                        return const Center(
                          child: CircularProgressIndicator(color: ConstantsApp.purplePrimaryColor,),
                        );
                      }
                      
                      if (state is ProfileDataState) {
                        final model = state.entity;
                        perfixCcontroller.text = model.vPrefijo ?? '';
                        phoneController.text =  model.vCelular ?? '';
                        return  Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              BackAppBardCommoMini(),
                              SizedBox(
                                width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Padding(
                                  padding:  const EdgeInsets.all(10),
                                  child: RichText(
                                    text:  const TextSpan(
                                      text: 'Mi perfil',
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextLocalWidget(text: 'Actualiza tus datos personales.'),
                                ),
                                LabelTextWidget(label: 'Nombres', text: capitalizeFirstLetter(model.vNombres!)),
                                LabelTextWidget( label: 'Apellidos', text: capitalizeFirstLetter(model.vApellidos!)),
                                LabelTextWidget(label: 'DNI', text: model.vNroDocumento!),
                                LabelTextWidget(label: 'Fecha de nacimiento', text: model.vFechaNacimiento!),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelTextWidget(label: 'Ubigeo', text: model.vUbigeo!),
                                    LabelTextWidget(label: 'Dígito verificador',text: model.vDigitoVerificador!),
                                  ],
                                ),
                                LabelTextWidget(label: 'Correo', text: model.vEmail!),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10, left: 15, top: 15),
                                        child: Icon(Icons.check_circle, color: Color(0xff3DC285), size: 18,),
                                      ), 
                                      Text('Tu correo ha sido validado', style: TextStyle(
                                        fontFamily: ConstantsApp.OPRegular,
                                        fontSize: 16,
                                        color: Color(0xff3DC285),
                                      ),
                                      ),
                                    ],
                                  ),
                                  //update
                                  const Padding(
                                    padding: EdgeInsets.only(left: 25, top: 10, bottom: 5, right: 10),
                                    child:   Text(
                                      'Celular',
                                      style:  TextStyle(
                                        fontFamily: ConstantsApp.OPSemiBold,
                                        fontSize: 16,
                                        color: ConstantsApp.textBlackQuaternary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 15, bottom: 5, right: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: InputWidget(
                                            controller: perfixCcontroller, 
                                            maxLength: 3,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp('[+0-9]')),
                                            ],
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            validator: (value) {
                                              if(phoneController.text.isNotEmpty &&  value == null || value == ''){
                                                return 'Ingrese el prefijo del teléfono';
                                              }
                                              return null;
                                            },
                                            onChange: (value){
                                               final text = perfixCcontroller.text;
                                                if (text.isNotEmpty && (text[0] != '+' || text.length > 3)) {
                                                  perfixCcontroller.value = perfixCcontroller.value.copyWith(
                                                    text: text.length > 1 ? '+${text.substring(1, 3)}' : '+',
                                                    selection: TextSelection.collapsed(offset: perfixCcontroller.text.length),
                                                  );
                                                } else if (text.length >= 2 && !RegExp(r'\d').hasMatch(text[1])) {
                                                  perfixCcontroller.value = perfixCcontroller.value.copyWith(
                                                    text: '+',
                                                    selection: TextSelection.collapsed(offset: perfixCcontroller.text.length),
                                                  );
                                                } else if (text.length == 3 && !RegExp(r'\d').hasMatch(text[2])) {
                                                  perfixCcontroller.value = perfixCcontroller.value.copyWith(
                                                    text: text.substring(0, 2),
                                                    selection: TextSelection.collapsed(offset: perfixCcontroller.text.length),
                                                  );
                                                }
                                                return null;
                                             },
                                            ),
                                          ),
                                        Expanded(child: InputWidget(
                                          controller: phoneController,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          maxLength: 9,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          validator: (value){
                                            if(perfixCcontroller.text.isNotEmpty && (value == null || value == '')){
                                              return 'Ingrese su número de celular';
                                            }

                                            if(value!.length != 9){
                                              return 'El número de celular debe tener 9 dígitos';
                                            }

                                            return null;
                                          },
                                          ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  
                                   Center(
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 20),
                                       child: BottonCenterWidget(
                                        sized: MediaQuery.of(context).size.width *0.88,
                                        ontap: (){
                                          if(perfixCcontroller.text.isNotEmpty && _formKey.currentState!.validate()){
                                          FocusScope.of(context).unfocus();
                                          final send = PasswordProfileUpdateSendModel(
                                            iAccion: 1,
                                            iRegistroId: model.iRegistroId,
                                            vContrasenia: '',
                                            vPrefijo: perfixCcontroller.text,
                                            vTelefono: phoneController.text,
                                          );
                                                                 
                                          context.read<LoginBloc>().add(UpdateProfileEvent(send));
                                        }
                                        },
                                        text: 'Guardar',
                                        icon: Icons.save_outlined,
                                       ),
                                     ),
                                   ),

                                     Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 10, top: 30, bottom: 20),
                                    child: InkWell(
                                      onTap: (){
                                        context.read<LoginBloc>().add(LogOutEvent());
                                      },
                                      child: const Row(
                                      children: [
                                          Icon(
                                            Icons.logout, 
                                            color: Color(0xff692A6D), 
                                            size: 25,
                                            weight: 10,
                                            ), 
                                            SizedBox(width: 10),
                                          Text('Cerrar sesión', style: TextStyle(
                                            fontFamily: ConstantsApp.OPRegular,
                                            fontSize: 16,
                                            color: Color(0xff692A6D),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {

                if (state is LoginLoadingState) {
                  context.read<LoaderCubit>().showLoader();
                }

                if (state is LogOutSuccessState) {
                   Future.delayed(const Duration(seconds: 1), () {
                    context.read<LoaderCubit>().hideLoader();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutesApp.login);
                  });
                 
                }

                if(state is UpdateProfileSuccessState){
                  context.read<LoaderCubit>().hideLoader();
                  context.read<ProfileBloc>().updateDataProfile(state.prefix, state.num);
                  context.read<LoginBloc>().add(LoginValidStatusEvent());
                    final alert = DialogInformWidget(
                      title: 'Información',
                      message: 'Los datos se actualizaron correctamente',
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
                }

                if(state is ErrorRecoveryPasswordCodeState){
                   context.read<LoaderCubit>().hideLoader();
                   UtilCommon().handleErrorResponse(context, state.error, 'ERROR AL ACTUALIZAR LOS DATOS');
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

class LabelTextWidget extends StatelessWidget {
  LabelTextWidget({
    required this.label,
    required this.text,
    super.key,
  });

  String label;
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 10, bottom: 5, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: ConstantsApp.OPSemiBold,
              fontSize: 16,
              color: ConstantsApp.textBlackQuaternary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: ConstantsApp.textBlackSecondary,
              fontFamily: ConstantsApp.OPRegular,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; 
  }
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}
