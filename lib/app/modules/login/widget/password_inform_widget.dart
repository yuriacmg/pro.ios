// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class PasswordInformWidget extends StatelessWidget {
  const PasswordInformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.info, color: Colors.black, size: 17),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              r'Asegúrate de que tu contraseña tenga al menos 8 caracteres, una letra mayúscula, un número y un carácter especial (@, #, & o $)',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color(0xff343434),
                fontFamily: ConstantsApp.OPRegular,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
