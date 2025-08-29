// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class BottonRightIconWidget extends StatelessWidget {
  BottonRightIconWidget({
    required this.ontap,
    required this.text,
    required this.icon,
    this.isEnabled,
    super.key,
  });

  VoidCallback ontap;
  String text;
  IconData icon;
  bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 45,
        width: 130,
        decoration: BoxDecoration(
          color: (isEnabled == null)
              ? ConstantsApp.purpleSecondaryColor
              : (isEnabled! ? ConstantsApp.purpleSecondaryColor : ConstantsApp.colorBlackSecondary),
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
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
