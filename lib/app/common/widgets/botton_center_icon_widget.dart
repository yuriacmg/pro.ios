// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class BottonCenterIconWidget extends StatelessWidget {
  BottonCenterIconWidget({
    required this.ontap,
    required this.text,
    required this.icon,
    super.key,
  });

  VoidCallback ontap;
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 45,
        width: 130,
        decoration: const BoxDecoration(
          color: Color(0xffF59D24),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
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
