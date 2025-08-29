// ignore_for_file: must_be_immutable, omit_local_variable_types, prefer_single_quotes, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:perubeca/app/utils/constans.dart';

class CardPrepareScholarshipOfflineWidget extends StatelessWidget {
  CardPrepareScholarshipOfflineWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.constraints,
    this.textButton,
    this.visiblePanel = false,
    super.key,
  });

  String title;
  String icon;
  VoidCallback onTap;
  BoxConstraints constraints;
  String? textButton;
  bool visiblePanel;

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
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset('assets/card-header.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: visiblePanel ? 40 : 20, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const SizedBox(
                                height: 15,
                              ),
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
                        if (icon.split('.').last == 'svg')
                          SvgPicture.asset('assets$icon',width: MediaQuery.of(context).size.width * 0.25)
                        else
                          Image.asset(
                            'assets$icon',
                            width: (constraints.maxWidth > 1000)
                                ? MediaQuery.of(context).size.width * 0.07
                                : MediaQuery.of(context).size.width * 0.2,
                            height: (constraints.maxWidth > 1000)
                                ? MediaQuery.of(context).size.height * 0.1
                                : MediaQuery.of(context).size.height * 0.12,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: visiblePanel,
                 child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xff318F3D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: Text(
                      'Contenido libre',
                      style: TextStyle(
                        fontFamily: ConstantsApp.OPSemiBold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                               ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
