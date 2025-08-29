// ignore_for_file: must_be_immutable, omit_local_variable_types, prefer_single_quotes, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class CardIconTitleSubtitleWidget extends StatelessWidget {
  CardIconTitleSubtitleWidget({
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.url,
    super.key,
  });

  String title;
  String subtitle;
  String icon;
  String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          if (title.toLowerCase() == 'sede central') {
            await openGoogleMaps();
          }

          if (title.contains('Whatsapp')) {
            final Uri uri = Uri.parse(
              (title.contains("Whatsapp") || subtitle.contains("Facebook"))
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
          } else if (int.parse(
                      subtitle.replaceAll(' ', '').replaceAll('-', '')) >
                  0 &&
              !kIsWeb) {
            await makePhoneCall(subtitle);
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (icon.split('.').last == 'svg')
                  SvgPicture.asset(icon)
                else
                  Image.asset(icon),
                FittedBox(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: ConstantsApp.OPSemiBold,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ConstantsApp.textBlackSecondary,
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: ConstantsApp.QSRegular,
                    fontSize: 16,
                    color: ConstantsApp.textBlackPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openGoogleMaps() async {
    const googleMapsUrl =
        'https://www.google.com.pe/maps/place/Oficina+BECA+18/@-12.0840035,-77.0343309,18z/data=!4m6!3m5!1s0x9105c915343fcf3f:0xf6cfb8b22a4bd993!8m2!3d-12.0839393!4d-77.03416!16s%2Fg%2F11trhjr8qy?hl=es&entry=ttu';
    await launchUrl(Uri.parse(googleMapsUrl));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    await launchUrl(Uri.parse("tel:$phoneNumber"));
  }
}
