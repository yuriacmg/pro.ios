// ignore_for_file: lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class BackAppBardCommoMini extends StatelessWidget {
  BackAppBardCommoMini({
    this.ontap,
    super.key,
  });

  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: ConstantsApp.boxRadialDecoratioBottonBorderPrimary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -43,
            bottom: -5,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: -50,
            top: -7,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            left: 10,
            child: InkWell(
              onTap: ontap ?? () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Volver',
                    style: TextStyle(
                      fontFamily: ConstantsApp.OPMedium,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
