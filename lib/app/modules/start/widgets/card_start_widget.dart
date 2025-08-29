// ignore_for_file: must_be_immutable, omit_local_variable_types, prefer_single_quotes, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class CardStartWidget extends StatelessWidget {
  CardStartWidget({
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.onTap,
    required this.gradientColors,
    super.key,
  });

  String title;
  String subtitle;
  String icon;
  VoidCallback onTap;
  List<Color> gradientColors; // 👈 se reciben los colores

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
                            color: ConstantsApp.textBlackQuaternary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          subtitle,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: const TextStyle(
                            fontFamily: ConstantsApp.QSRegular,
                            fontSize: 14,
                            color: ConstantsApp.colorBlackPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      icon,
                      scale: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
