// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class GenericCardWidget extends StatelessWidget {
  GenericCardWidget({required this.child, super.key});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ConstantsApp.cardBGColor,
                border: Border.all(
                  width: 5,
                  color: ConstantsApp.cardBorderColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset('assets/card-header.png'),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/card-bottom.png'),
                  ),
                  SingleChildScrollView(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
