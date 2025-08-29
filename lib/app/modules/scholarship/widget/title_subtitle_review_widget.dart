// ignore_for_file: always_put_required_named_parameters_first, must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class TitleSubtitleReviewWidget extends StatelessWidget {
  TitleSubtitleReviewWidget({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.transparent),
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: ConstantsApp.textBlackQuaternary,
              fontSize: 16,
              fontFamily: ConstantsApp.OPSemiBold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: ConstantsApp.colorBlackPrimary,
              fontSize: 18,
              fontFamily: ConstantsApp.OPRegular,
            ),
          ),
        ],
      ),
    );
  }
}
