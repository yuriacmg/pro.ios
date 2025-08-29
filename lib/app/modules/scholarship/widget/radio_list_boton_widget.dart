// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/utils/constans.dart';

class RadioListBotonWidget extends StatefulWidget {
  RadioListBotonWidget({
    required this.list,
    required this.selected,
    required this.isDisabled,
    required this.pregunta,
    super.key,
  });

  List<PreguntaOpcionesEntity> list;
  PreguntaOpcionesEntity selected;
  bool isDisabled;
  PreguntaEntity pregunta;

  @override
  State<RadioListBotonWidget> createState() => _RadioListBotonWidgetState();
}

class _RadioListBotonWidgetState extends State<RadioListBotonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.list.length, (index) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: ConstantsApp.blueBorderColor),
              borderRadius: BorderRadius.circular(10),
              color: widget.isDisabled ? const Color(0xffD0D8E0) : Colors.white,
            ),
            child: RadioMenuButton(
              value: true,
              groupValue: index.toString(),
              onChanged: (value) {},
              child: const Text('Button radio'),
            ),
          ),
        );
      }).toList(),
    );
  }
}
