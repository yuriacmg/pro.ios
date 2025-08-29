// ignore_for_file: lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class ErrorRequestServerWidget extends StatelessWidget {
  ErrorRequestServerWidget({
    this.ontap,
    this.message = 'Lo sentimos, el servicio no está disponible.\n¡Intente más tarde!',
    super.key,
  });
  VoidCallback? ontap;
  String message;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ontap == null
          ? () async {
              Navigator.pop(context);
              return true;
            }
          : () async {
              ontap!();
              return true;
            },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        '¡Uy! Peluchín se escapó',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstantsApp.textBluePrimary,
                          fontFamily: ConstantsApp.OPBold,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
                ontap: ontap == null
                    ? () async {
                        Navigator.pop(context);
                      }
                    : () {
                        ontap!();
                      },
                text: 'Regresar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
