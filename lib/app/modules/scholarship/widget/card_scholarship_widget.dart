// ignore_for_file: must_be_immutable, omit_local_variable_types, prefer_single_quotes, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class CardScholarshipWidget extends StatelessWidget {
  CardScholarshipWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.gradientColors, // 👈 colores del gradiente
    required this.gradientStops,  // 👈 stops del gradiente
    this.textButton,
    this.bannerView = false,
    super.key,
  });

  String title;
  String icon;
  VoidCallback onTap;
  String? textButton;
  bool bannerView;
  List<Color> gradientColors;
  List<double> gradientStops; // 👈 valores entre 0.0 y 1.0

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.transparent,
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              stops: gradientStops,
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
                      Padding(
                        padding: EdgeInsets.only(top: bannerView ? 20 : 0),
                        child: Text(
                          title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
                            color: ConstantsApp.textBlackQuaternary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              textButton ?? 'Ver más',
                              style: const TextStyle(
                                fontFamily: ConstantsApp.OPBold,
                                color: ConstantsApp.purpleTerctiaryColor,
                                fontSize: 16,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 19,
                                color: ConstantsApp.purpleTerctiaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
