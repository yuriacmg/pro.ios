// ignore_for_file: must_be_immutable, omit_local_variable_types, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class CardIconTitleWidget extends StatelessWidget {
  CardIconTitleWidget({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.url,
    super.key,
  });

  String title;
  String icon;
  String subtitle;
  String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          final Uri uri = Uri.parse(
            (title.contains('Whatsapp') || title.contains('Facebook'))
                ? geUrl(title, subtitle)
                : url,
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
        child: Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0x29E71D73),
                  Color(0x290895EA),
                  Color(0x29004A92),
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (icon.split('.').last == 'svg')
                  (icon.contains('gob.svg')
                      ? SizedBox(
                          height: 42,
                          width: 132,
                          child: SvgPicture.asset(icon),
                        )
                      : SizedBox(
                          height: 60,
                          width: 60,
                          child: SvgPicture.asset(icon),
                        ))
                else
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                Text(
                  subtitle,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: ConstantsApp.OPSemiBold,
                    fontSize: 16,
                    color: ConstantsApp.textBlackSecondary,
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
