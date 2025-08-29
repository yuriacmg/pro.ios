// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/utils/constans.dart';

class AppBarBackCommonWebSingleWidget extends StatelessWidget {
  AppBarBackCommonWebSingleWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: -45,
                top: 12,
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
                left: MediaQuery.of(context).size.width * 0.05,
                top: -3,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.13,
                top: -7,
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.24,
                bottom: -40,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.38,
                bottom: 10,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.38,
                top: -12,
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.26,
                bottom: 12,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.1,
                top: -24,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                right: -10,
                bottom: -10,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Divider(
                    color: Colors.transparent,
                  ),
                  SvgPicture.asset(
                    ConstantsApp.logoIcon,
                    fit: BoxFit.cover,
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
        ),
      ],
    );
  }
}
