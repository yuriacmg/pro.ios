// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/utils/constans.dart';

class JumpWidget extends StatelessWidget {
  JumpWidget({
    required this.colortext,
    super.key,
  });
  Color colortext;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15,
      top: 30,
      child: InkWell(
        child: Text(
          'Saltar',
          style: TextStyle(
            fontSize: 16,
            color: colortext,
            fontFamily: ConstantsApp.OPSemiBold,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          //go to home
          Navigator.pushReplacementNamed(context, RoutesApp.home);
        },
      ),
    );
  }
}
