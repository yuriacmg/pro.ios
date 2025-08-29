// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perubeca/app/utils/constans.dart';

class InputLabelWidget extends StatelessWidget {
  InputLabelWidget({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.placeholder = '',
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.autovalidateMode,
    this.onChange,
    this.maxLength,
    this.viewPassword,
    this.inputFormatters,
    super.key,
  });
  String label;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  String placeholder;
  VoidCallback? onTap;
  bool readOnly;
  bool obscureText;
  AutovalidateMode? autovalidateMode;
  String? Function(String)? onChange;
  int? maxLength;
  Widget? viewPassword;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3, left: 7),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: ConstantsApp.OPSemiBold,
                fontSize: 14,
                color: ConstantsApp.textBlackQuaternary,
              ),
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: TextFormField(
              controller: controller,
              validator: validator,
              onTap: onTap,
              keyboardType: keyboardType,
              readOnly: readOnly,
              obscureText: obscureText,
              autovalidateMode: autovalidateMode,
              onChanged: onChange,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              style: const TextStyle(
                color: ConstantsApp.textBlackSecondary,
                fontFamily: ConstantsApp.OPRegular,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: placeholder,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                counterText: '',
                suffixIcon: viewPassword,
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
                floatingLabelStyle: const TextStyle(
                  backgroundColor: Colors.transparent,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  InputWidget({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.placeholder = '',
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.autovalidateMode,
    this.onChange,
    this.maxLength,
    this.viewPassword,
    super.key,
    this.inputFormatters,
  });
  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  String placeholder;
  VoidCallback? onTap;
  bool readOnly;
  bool obscureText;
  AutovalidateMode? autovalidateMode;
  String? Function(String)? onChange;
  int? maxLength;
  Widget? viewPassword;
  List<TextInputFormatter>?  inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: ColoredBox(
        color: Colors.white,
        child: TextFormField(
          controller: controller,
          validator: validator,
          onTap: onTap,
          keyboardType: keyboardType,
          readOnly: readOnly,
          obscureText: obscureText,
          autovalidateMode: autovalidateMode,
          onChanged: onChange,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            color: ConstantsApp.textBlackSecondary,
            fontFamily: ConstantsApp.OPRegular,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: placeholder,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            counterText: '',
            suffixIcon: viewPassword,
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
            floatingLabelStyle: const TextStyle(
              backgroundColor: Colors.transparent,
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
          ),
        ),
      ),
    );
  }
}
