// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class BackAppBarCommon extends StatelessWidget {
  BackAppBarCommon({
    required this.title,
    required this.subtitle,
    required this.ontap,
    this.backString,
    super.key,
  });

  String title;
  String subtitle;
  VoidCallback ontap;
  String? backString;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 1.8,
          center: Alignment.topCenter,
          colors: [
            ConstantsApp.purplePrimaryColor,
            ConstantsApp.purpleSecondaryColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -30,
            top: 21,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: -30,
            top: 7,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            top: -30,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: ontap,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      backString ?? 'Volver',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: ConstantsApp.OPBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
