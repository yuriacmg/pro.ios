// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class TitleExpansionTileWidget extends StatelessWidget {
  TitleExpansionTileWidget({
    required this.title,
    super.key,
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
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
                  color: ConstantsApp.textBlackQuaternary,
                  fontSize: 16,
                  fontFamily: ConstantsApp.OPBold,
                ),
              ),
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 2, bottom: 2),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
