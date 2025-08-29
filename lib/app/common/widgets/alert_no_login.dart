// ignore_for_file: avoid_dynamic_calls, directives_ordering,, always_put_required_named_parameters_first, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

// ignore: must_be_immutable
class AlertNoLoginDialog extends StatelessWidget {
  AlertNoLoginDialog({
    required this.onPressed, super.key,
  });
  final Color _color = Colors.white;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: _color,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/login/no_login.png', scale: 1.4),
          const Text(
            'Ups! Aun no inicias sesión',
            style: TextStyle(
              fontFamily: ConstantsApp.OPBold,
              fontSize: 18,
              color: ConstantsApp.colorBlackPrimary,
            ),
          ),
          const Text(
            'Para ingresar al contenido de prepárate debes ingresar a:',
            style: TextStyle(
              fontFamily: ConstantsApp.OPRegular,
              fontSize: 14,
              color: ConstantsApp.colorBlackSecondary,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottonRightWidget(
                size: 250,
                ontap: () {
                  onPressed();
                },
                text: 'Iniciar sesión',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
