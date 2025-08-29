// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class TitleExpansionTileWidget2 extends StatelessWidget {
  TitleExpansionTileWidget2({
    required this.title,
    super.key,
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: ConstantsApp.textBluePrimary,
                fontSize: 16,
                fontFamily: ConstantsApp.OPSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
