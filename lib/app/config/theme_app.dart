// ignore_for_file: directives_ordering

import 'package:perubeca/app/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perubeca/app/utils/constans.dart';

class ThemeApp {
  final light = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      centerTitle: true,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: ConstantsApp.primaryColor,
    fontFamily: 'OpenSans',
    brightness: Brightness.light,
    textTheme: const TextTheme(),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColorGenerator.from(ConstantsApp.primaryColor),
    ).copyWith(secondary: const Color.fromARGB(255, 34, 125, 209)).copyWith(
          surface: const Color.fromARGB(255, 34, 125, 209),
        ),
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarThemeData(
      labelColor: Colors.black,
      labelStyle: ConstantsApp.labelStyle,
      unselectedLabelStyle: ConstantsApp.unselectedLabelStyle,
    ),
  );
}
