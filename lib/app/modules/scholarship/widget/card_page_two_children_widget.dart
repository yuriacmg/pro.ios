// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class CardPageTwoChildrenWidget extends StatelessWidget {
  CardPageTwoChildrenWidget({
    required this.children,
    super.key,
  });
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
              Positioned(left: 0, top: 0, child: Image.asset('assets/card-header.png')),
              Positioned(right: 0, top: 30, child: Image.asset('assets/card-bottom.png')),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
