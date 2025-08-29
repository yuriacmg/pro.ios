// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, file_names

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class BottonCenterMinorWidget extends StatelessWidget {
  BottonCenterMinorWidget({
    required this.ontap,
    required this.text,
    this.sized,
    this.color,
    this.isEnabled,
    super.key,
  });

  VoidCallback ontap;
  String text;
  double? sized;
  Color? color;
  bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 45,
        width: sized ?? 130,
        decoration: BoxDecoration(
          color: (color == null) ? ConstantsApp.purpleSecondaryColor : color,
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
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: ConstantsApp.OPBold,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
