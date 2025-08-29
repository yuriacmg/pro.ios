// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SvgPicture.asset(
                      ConstantsApp.peluchinUpdate,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Nueva actualización disponible',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ConstantsApp.textBluePrimary,
                        fontFamily: ConstantsApp.OPBold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      'Una nueva versión de la aplicación se descargará e instalará.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ConstantsApp.colorBlackSecondary,
                        fontFamily: ConstantsApp.QSMedium,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottonCenterWidget(
              ontap: () async {
                final url = Platform.isAndroid
                    ? 'https://play.google.com/store/apps/details?id=com.perubeca.app'
                    : 'https://apps.apple.com/us/app/pronabec/id6459058855';

                final uri = Uri.parse(url);

                try {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  // print("");
                }
              },
              text: 'Ir a',
            ),
          ],
        ),
      ),
    );
  }
}
