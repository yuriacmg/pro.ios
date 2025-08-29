// ignore_for_file: must_be_immutable, omit_local_variable_types, prefer_single_quotes, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class CardScholarshipLauchWidget extends StatelessWidget {
  CardScholarshipLauchWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    super.key,
  });

  String title;
  String? subtitle;
  String icon;
  VoidCallback onTap;

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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
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
                              Text(
                                subtitle ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: ConstantsApp.OPRegular,
                                  fontSize: 16,
                                  color: ConstantsApp.textBlackQuaternary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            onPressed: onTap,
                            child: Row(
                              children: [
                                const Text(
                                  'Ver más',
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPBold,
                                    color: ConstantsApp.purpleTerctiaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    'assets/scholarship/detail/launch.png',
                                    scale: 2,
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
                      child: Image.asset(icon, scale: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
