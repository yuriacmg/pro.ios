// ignore_for_file: always_put_required_named_parameters_first, must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class TitleSubtitleWidget extends StatelessWidget {
  TitleSubtitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  String title;
  String subtitle;
  double? paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 20),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ConstantsApp.textBluePrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: ConstantsApp.OPBold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ConstantsApp.textBlackPrimary,
              fontSize: 14,
              fontFamily: ConstantsApp.QSMedium,
            ),
          ),
        ],
      ),
    );
  }
}
