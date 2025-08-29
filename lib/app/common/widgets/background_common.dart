// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class BackgroundCommon extends StatelessWidget {
  BackgroundCommon({required this.child, super.key});
  Widget child;
  final fondoApp = kIsWeb ? ConstantsApp.fondoAppWeb : ConstantsApp.fondoApp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(fondoApp),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
