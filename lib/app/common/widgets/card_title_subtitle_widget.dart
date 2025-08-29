// ignore_for_file: must_be_immutable, omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class CardTitleSubtitleWidget extends StatelessWidget {
  CardTitleSubtitleWidget({
    required this.title,
    required this.subtitle,
    required this.url,
    super.key,
  });

  String title;
  String subtitle;
  String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(
          (title.contains('Whatsapp') || subtitle.contains('Facebook')) ? geUrl(title, subtitle) : url,
        );

        try {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          // print("");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // elevation: 0,
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
                Positioned(left: 0, top: 0, child: Image.asset('assets/card-header.png')),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Divider(color: Colors.transparent,),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPBold,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ConstantsApp.textBlackQuaternary,
                      ),
                    ),
                    const Divider(color: Colors.transparent,),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                    ),
                    const Divider(color: Colors.transparent,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
