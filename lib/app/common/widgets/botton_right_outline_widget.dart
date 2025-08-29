// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class BottonRightOutlineWidget extends StatelessWidget {
  BottonRightOutlineWidget({
    required this.ontap,
    required this.text,
    this.isEnabled,
    this.size,
    super.key,
  });

  VoidCallback ontap;
  String text;
  bool? isEnabled;
  double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: size == null ? 130 : size!,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ConstantsApp.purpleTerctiaryColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: ConstantsApp.purpleTerctiaryColor,
                  fontFamily: ConstantsApp.OPBold,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
