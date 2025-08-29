// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perubeca/app/utils/constans.dart';

class AppBarCommonWebWidget extends StatelessWidget {
  AppBarCommonWebWidget({
    required this.title,
    required this.subtitle,
    required this.scaffoldKey,
    super.key,
  });

  String title;
  String subtitle;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 94,
          width: MediaQuery.of(context).size.width,
          decoration: ConstantsApp.boxRadialDecoratioBottonBorderPrimary,
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
              SvgPicture.asset(
                ConstantsApp.logoIcon,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Container(
          height: 94,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 32,
                ),
                color: Colors.white,
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
