// ignore_for_file: must_be_immutable, omit_local_variable_types, lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/modules/scholarship/bloc/email_bloc/email_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/email_send_model.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class CardTitleSubtitleEmailHistoryWidget extends StatefulWidget {
  CardTitleSubtitleEmailHistoryWidget({
    required this.title,
    required this.subtitle,
    required this.url,
    required this.ontap,
    required this.dni,
    required this.parametro,
    required this.formKey,
    this.isModal = false,
    super.key,
  });

  String title;
  String subtitle;
  String url;
  String dni;
  int parametro;

  VoidCallback ontap;

  bool isModal;
  GlobalKey<FormState> formKey;

  @override
  State<CardTitleSubtitleEmailHistoryWidget> createState() => _CardTitleSubtitleEmailHistoryWidgetState();
}

class _CardTitleSubtitleEmailHistoryWidgetState extends State<CardTitleSubtitleEmailHistoryWidget> {
  //para el envio del email
  TextEditingController emailController = TextEditingController();
  //final widget.formKey = GlobalKey<FormState>();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ConstantsApp.cardBGColor,
                border: Border.all(
                  width: 5,
                  color: ConstantsApp.cardBorderColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset(
                      'assets/card-header.png',
                      height: widget.isModal ? 130 : null,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Divider(
                        color: Colors.transparent,
                        height: 20,
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: ConstantsApp.OPBold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ConstantsApp.textBlackQuaternary,
                        ),
                      ),

                      Visibility(
                        visible: widget.isModal,
                        child: Column(
                          children: [
                            const Divider(color: Colors.transparent),
                            Image.asset(ConstantsApp.email),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: ConstantsApp.OPRegular,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ConstantsApp.colorBlackPrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Form(
                        key: widget.formKey,
                        onChanged: () {
                          setState(() {
                            isValid = widget.formKey.currentState!.validate();
                          });
                        },
                        child: email(),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      //button
                      InkWell(
                        onTap: () {
                          if (widget.formKey.currentState!.validate()) {
                            if (widget.isModal) Navigator.pop(context);
                            FocusScope.of(context).unfocus();
                            final send = EmailSendModel(
                              correo: emailController.text,
                              nroDocumento: widget.dni,
                              nroConsultaCiudadana: widget.parametro,
                            );
                            context.read<EmailBloc>().sendEmail(send);
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 200,
                          decoration: BoxDecoration(
                            color: isValid ? Colors.white : Colors.grey.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            border: Border.all(
                              color: isValid ? ConstantsApp.purpleTerctiaryColor : Colors.grey,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enviar',
                                style: TextStyle(
                                  color: isValid ? ConstantsApp.purpleTerctiaryColor : Colors.black54,
                                  fontFamily: ConstantsApp.OPBold,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: widget.isModal,
                        child: Column(
                          children: [
                            const Divider(color: Colors.transparent),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Omitir',
                                style: TextStyle(
                                  color: ConstantsApp.purpleSecondaryColor,
                                  fontFamily: ConstantsApp.RBRegular,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                   BlocListener<EmailBloc, EmailState>(
                    listener: (_, state) {
                      if (state is EmailSendCompleteState) {
                        emailController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget email() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.text,
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'Correo electrónico',
          enabled: true,
          placeholder: 'Ej.: usuario@ejemplo.com',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su correo electrónico.';
          }

          if (!isValidEmail(value)) {
            return 'El correo electrónico es inválido.';
          }

          return null;
        },
      ),
    );
  }
}
