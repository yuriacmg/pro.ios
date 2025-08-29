// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class BottonCenterShadowWidget extends StatelessWidget {
  BottonCenterShadowWidget({
    required this.ontap,
    required this.text,
    this.sized,
    super.key,
  });

  VoidCallback ontap;
  String text;
  double? sized;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: ontap,
          child: Container(
            height: (constraints.maxWidth > 1000) ? 50 : 45,
            width: (constraints.maxWidth > 1000) ? (sized ?? 250) : (sized ?? 130),
            decoration: const BoxDecoration(
              color: ConstantsApp.purplePrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(
                    2,
                    2,
                  ),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textScaleFactor: (constraints.maxWidth > 1000) ? 1.3 : 1,
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
      },
    );
  }
}
