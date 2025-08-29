// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class BackAppBarRectangleCommon extends StatelessWidget {
  BackAppBarRectangleCommon({
    required this.ontap,
    this.viewOntap = true,
    super.key,
  });

  VoidCallback ontap;

  bool viewOntap;

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
            left: -35,
            bottom: 12,
            child: Container(
              height: 60,
              width: 60,
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
            top: -30,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          if (viewOntap)
            GestureDetector(
              onTap: () {
                ontap();
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
                      color: Colors.white,
                      fontFamily: ConstantsApp.OPRegular,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
