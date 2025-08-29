// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class TitleSubPageWidget extends StatelessWidget {
  TitleSubPageWidget({
    required this.title,
    this.subTitle,
    this.position,
    super.key,
  });
  String title;
  String? subTitle;
  int? position;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: ConstantsApp.OPSemiBold,
                fontSize: 16,
                color: ConstantsApp.textBluePrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
