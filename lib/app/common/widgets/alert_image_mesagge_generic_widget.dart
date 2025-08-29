// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class AlertImageMessageGenericWidget extends StatelessWidget {
  AlertImageMessageGenericWidget({
    required this.title,
    required this.message,
    required this.image,
    required this.onTap,
    required this.bottonTitle,
    required this.consultaId,
    this.onTapClose,
    super.key,
  });

  String title;
  String message;
  String image;
  VoidCallback onTap;
  VoidCallback? onTapClose;
  String bottonTitle;
  int consultaId;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: onTapClose == null
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : () {
                                    onTapClose!();
                                  },
                            child: const Icon(
                              Icons.close_sharp,
                              size: 20,
                              weight: 10,
                              color: ConstantsApp.purpleTerctiaryColor,
                            ),
                          ),
                        ],
                      ),
                      if (image.split('.').last == 'svg')
                        SvgPicture.asset(
                          image,
                        )
                      else
                        Image.asset(
                          image,
                          scale: 2.5,
                        ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      if (consultaId != 0)
                        Text(
                          'N° de consulta $consultaId',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: ConstantsApp.OPBold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ConstantsApp.textBluePrimary,
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: ConstantsApp.OPBold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ConstantsApp.textBluePrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: ConstantsApp.OPMedium,
                          fontSize: 16,
                          color: ConstantsApp.colorBlackPrimary,
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      BottonCenterWidget(
                        ontap: onTap,
                        text: bottonTitle,
                        color: ConstantsApp.purpleTerctiaryColor,
                        sized: 152,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
