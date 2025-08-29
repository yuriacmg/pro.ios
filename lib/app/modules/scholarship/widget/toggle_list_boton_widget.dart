// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/database/entities/pregunta_entity.dart';
import 'package:perubeca/app/database/entities/pregunta_opciones_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/option_bloc/option_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/utils/constans.dart';

class ToggleListBotonWidget extends StatefulWidget {
  ToggleListBotonWidget({
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
  State<ToggleListBotonWidget> createState() => _ToggleListBotonWidgetState();
}

class _ToggleListBotonWidgetState extends State<ToggleListBotonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.list.length, (index) {
        return InkWell(
          onTap: widget.isDisabled
              ? () {}
              : () {
                  setState(() {
                    widget.selected = widget.list[index];
                  });
                  final respuesta =
                      RespuestaProcesada(idPregunta: widget.pregunta.preguntaId, valorRespuesta: widget.selected.alternativaId);
                  context.read<OptionBloc>().add(AddRespuestaProcesada(respuesta: respuesta));
                },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: (widget.selected == widget.list[index])
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: ConstantsApp.purpleTerctiaryColor,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                  )
                : BoxDecoration(
                    border: Border.all(color: ConstantsApp.blueBorderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: widget.isDisabled ? const Color(0xffD0D8E0) : Colors.white,
                  ),
            child: Text(
              widget.list[index].valor,
              textAlign: TextAlign.center,
              style: (widget.selected == widget.list[index])
                  ? const TextStyle(
                      fontFamily: ConstantsApp.OPBold,
                      fontSize: 18,
                      color: ConstantsApp.purpleTerctiaryColor,
                    )
                  : const TextStyle(
                      fontFamily: ConstantsApp.OPRegular,
                      fontSize: 18,
                      color: ConstantsApp.textBlackQuaternary,
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
