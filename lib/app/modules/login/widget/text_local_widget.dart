// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class TextLocalWidget extends StatelessWidget {
  TextLocalWidget({
    required this.text,
    this.align = TextAlign.left,
    super.key,
  });

  String text;
  TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: 5,
      style: const TextStyle(
        fontFamily: ConstantsApp.OPRegular,
        fontSize: 16,
        color: ConstantsApp.colorBlackPrimary,
      ),
    );
  }
}
