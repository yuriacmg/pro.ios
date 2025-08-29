// ignore_for_file: avoid_positional_boolean_parameters, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class GenericStylesApp {
  InputDecoration inputDecorationApp(bool enabled) {
    return InputDecoration(
      enabled: enabled,
      isCollapsed: true,
      alignLabelWithHint: false,
      focusColor: ConstantsApp.colorBlackSecondary,
      hoverColor: ConstantsApp.colorBlackSecondary,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 2,
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 2,
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 2,
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 2,
          color: ConstantsApp.cardBorderColor,
        ),
      ),
    );
  }

  InputDecoration inputDecorationOutline({
    bool? enabled,
    String? placeholder,
  }) {
    return InputDecoration(
      enabled: enabled!,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      suffixIconConstraints: const BoxConstraints(minHeight: 30, minWidth: 30),
      hintText: placeholder,
      hintStyle: const TextStyle(
        color: ConstantsApp.colorBlackInputHidden,
        fontSize: 14,
        // fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPRegular,
      ),
      floatingLabelStyle: const TextStyle(
        color: ConstantsApp.colorBlackTerciary,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusColor: ConstantsApp.colorBlackSecondary,
      hoverColor: ConstantsApp.colorBlackSecondary,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  InputDecoration newInputDecorationOutline({
    required String label,
    required String placeholder,
    required bool enabled,
    Widget? icon,
  }) {
    return InputDecoration(
      enabled: enabled,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: label,
      hintText: placeholder,
      alignLabelWithHint: true,
      counterText: '',
      suffixIcon: icon ?? const SizedBox.shrink(),
      labelStyle: const TextStyle(
        backgroundColor: Colors.transparent,
        color: ConstantsApp.colorBlackPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      hintStyle: const TextStyle(
        color: ConstantsApp.colorBlackInputHidden,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      floatingLabelStyle: TextStyle(
        backgroundColor: enabled ? Colors.transparent : Colors.transparent,
        color: ConstantsApp.colorBlackPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  InputDecoration newInputDecorationOutlineDropdown({
    required String? label,
    required String placeholder,
    required bool enabled,
    required bool selected,
    Widget? icon,
  }) {
    return InputDecoration(
      enabled: enabled,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: label ?? '',
      hintText: placeholder,
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        backgroundColor: Colors.transparent,
        color: ConstantsApp.colorBlackPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      hintStyle: const TextStyle(
        color: ConstantsApp.colorBlackInputHidden,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      floatingLabelStyle: TextStyle(
        backgroundColor: enabled ? Colors.transparent : Colors.transparent,
        color: ConstantsApp.textBlackQuaternary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.purpleTerctiaryColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:  BorderSide(
          color: selected ? ConstantsApp.cardBorderColor : ConstantsApp.purpleTerctiaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  InputDecoration newInputDecorationOutlineDropdown2({
    required String? label,
    required String placeholder,
    required bool enabled,
    Widget? icon,
  }) {
    return InputDecoration(
      enabled: enabled,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: label ?? '',
      hintText: placeholder,
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        backgroundColor: Colors.transparent,
        color: ConstantsApp.colorBlackPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      hintStyle: const TextStyle(
        color: ConstantsApp.colorBlackInputHidden,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      floatingLabelStyle: TextStyle(
        backgroundColor: enabled ? Colors.transparent : Colors.transparent,
        color: ConstantsApp.textBlackQuaternary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: ConstantsApp.OPSemiBold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.cardBorderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: ConstantsApp.blueBorderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  Widget label({
    String? text,
    bool? enabled,
    double? position,
    bool? required,
  }) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: position ?? 25, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 3),
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 2,
                color: Colors.red,
                margin: const EdgeInsets.only(
                  left: 18,
                  top: 10,
                  right: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3),
              ),
              Row(
                children: [
                  Text(
                    text!,
                    style: TextStyle(
                      backgroundColor: enabled! ? Colors.white : Colors.transparent,
                      color: ConstantsApp.colorBlackSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: ConstantsApp.OPSemiBold,
                    ),
                  ),
                  if (required!)
                    Text(
                      ' *',
                      style: TextStyle(
                        backgroundColor: enabled ? Colors.white : Colors.transparent,
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: ConstantsApp.OPSemiBold,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget title({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 26,
        fontFamily: ConstantsApp.OPSemiBold,
        fontWeight: FontWeight.w500,
        color: ConstantsApp.textBluePrimary,
      ),
    );
  }

  Widget titleBold({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 26,
        fontFamily: ConstantsApp.OPBold,
        // fontWeight: FontWeight.w500,
        color: ConstantsApp.textBluePrimary,
      ),
    );
  }

  Widget titleLeft({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 26,
        fontFamily: ConstantsApp.OPSemiBold,
        fontWeight: FontWeight.w500,
        color: ConstantsApp.textBluePrimary,
      ),
    );
  }

  Widget subTitle({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 26,
        fontFamily: ConstantsApp.OPSemiBold,
        fontWeight: FontWeight.w500,
        color: ConstantsApp.textBluePrimary,
      ),
    );
  }

  Widget subTitle2({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: ConstantsApp.OPSemiBold,
        fontWeight: FontWeight.w500,
        color: ConstantsApp.textBluePrimary,
      ),
    );
  }

  Widget messagePage({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: ConstantsApp.OPRegular,
        fontSize: 16,
        color: ConstantsApp.colorBlackPrimary,
      ),
    );
  }

  Widget messageLeftPage({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: ConstantsApp.OPRegular,
        fontSize: 16,
        color: ConstantsApp.colorBlackPrimary,
      ),
    );
  }

  Widget messageJustifyPage({String? text}) {
    return Text(
      text!,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontFamily: ConstantsApp.OPRegular,
        fontSize: 16,
        color: ConstantsApp.colorBlackPrimary,
      ),
    );
  }

  Widget trackingText({String? textblack, String? textNormal}) {
    return RichText(
      text: TextSpan(
        text: textblack,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: ConstantsApp.OPSemiBold,
          fontWeight: FontWeight.w500,
          color: ConstantsApp.colorBlackPrimary,
        ),
        children: [
          TextSpan(
            text: textNormal,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: ConstantsApp.OPRegular,
              color: ConstantsApp.colorBlackPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
