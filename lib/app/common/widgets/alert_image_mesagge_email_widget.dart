// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class AlertImageMessageEmailWidget extends StatefulWidget {
  AlertImageMessageEmailWidget({
    required this.title,
    required this.message,
    required this.image,
    required this.onTap,
    required this.bottonTitle,
    super.key,
  });

  String title;
  String message;
  String image;
  VoidCallback onTap;
  String bottonTitle;

  @override
  State<AlertImageMessageEmailWidget> createState() => _AlertImageMessageEmailWidgetState();
}

class _AlertImageMessageEmailWidgetState extends State<AlertImageMessageEmailWidget> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Color(0xff888888),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      widget.image,
                      scale: 1.9,
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPSemiBold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 14,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    email(),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    BottonCenterWidget(
                      ontap: widget.onTap,
                      text: widget.bottonTitle,
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          placeholder: 'Ingresar correo electrónico',
          icon: Image.asset(
            ConstantsApp.atIcon,
            scale: 1.5,
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su correo electrónico.';
          }

          if (!isValidEmail(value)) {
            return 'El correo electrónico no es válido.';
          }

          return null;
        },
      ),
    );
  }
}
