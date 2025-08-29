// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class TitlePageWidget extends StatelessWidget {
  TitlePageWidget({
    required this.text,
    super.key,
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '¡',
        style: const TextStyle(
          fontSize: 26,
          fontFamily: ConstantsApp.OPSemiBold,
          color: ConstantsApp.textBluePrimary,
          fontWeight: FontWeight.w900,
        ),
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const TextSpan(text: ', queremos conocerte!'),
        ],
      ),
    );
  }
}
