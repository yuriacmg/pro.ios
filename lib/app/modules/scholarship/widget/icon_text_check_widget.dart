// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:perubeca/app/utils/constans.dart';

class IconTextCheckWidget extends StatelessWidget {
  IconTextCheckWidget({
    required this.text,
    required this.icon,
    required this.value,
    this.selectedColor,
    super.key,
  });

  String text;
  String icon;
  bool value;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: value ? (selectedColor ?? Colors.green[400]) : Colors.white,
        border: Border.all(
          color: ConstantsApp.blueBorderColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: const Color(0xffE1E8EF),
                child: Image.asset(
                  icon,
                  scale: 1.2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: ConstantsApp.OPRegular,
                  color: value ? Colors.white : ConstantsApp.textBlackSecondary,
                ),
              ),
            ],
          ),
          Checkbox(
            checkColor: selectedColor ?? Colors.green[400],
            fillColor: value ? WidgetStateProperty.all(Colors.white) : WidgetStateProperty.all(ConstantsApp.blueBorderColor),
            value: value,
            shape: const CircleBorder(
              side: BorderSide(
                color: ConstantsApp.blueBorderColor,
                width: 5,
              ),
            ),
            onChanged: (bool? value) {},
          ),
        ],
      ),
    );
  }
}
