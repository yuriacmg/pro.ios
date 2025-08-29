// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class TitleExpansionTileWidget3 extends StatelessWidget {
  TitleExpansionTileWidget3({
    required this.title,
    super.key,
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: Text(
                title,
                style: const TextStyle(
                  color: ConstantsApp.bluePrimary,
                  fontSize: 16,
                  fontFamily: ConstantsApp.OPBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
