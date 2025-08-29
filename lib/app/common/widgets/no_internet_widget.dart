// ignore_for_file: lines_longer_than_80_chars, must_be_immutable, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class NoInternetWidget extends StatelessWidget {
  NoInternetWidget({
    this.ontap,
    this.visibleMessage,
    super.key,
  });

  VoidCallback? ontap;
  bool? visibleMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ontap == null
          ? () async {
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              return true;
            }
          : () async {
              ontap!();
              return false;
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
                      ConstantsApp.peluchinNoInternet,
                      height: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Sin conexión a internet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ConstantsApp.textBluePrimary,
                        fontFamily: ConstantsApp.OPBold,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      'Comprueba tu conexión  Wi-Fi o de datos móbiles. Por favor, verifica y vuelva a intentar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ConstantsApp.colorBlackSecondary,
                        fontFamily: ConstantsApp.QSMedium,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibleMessage ?? false,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Text(
                        'Para ingresar a Preparate, solo necesitarás internet la primera vez que accedas, luego si deseas puedes desactivar el plan de datos de tu celular o el wifi y podrás seguir usando el aplicativo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstantsApp.colorBlackSecondary,
                          fontFamily: ConstantsApp.QSMedium,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottonCenterWidget(
              ontap: ontap == null
                  ? () async {
                      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    }
                  : () async {
                      ontap!();
                    },
              text: 'Entendido',
            ),
          ],
        ),
      ),
    );
  }
}
