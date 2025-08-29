// ignore_for_file: library_private_types_in_public_api, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/modules/login/bloc/code_bloc.dart';
import 'package:perubeca/app/utils/constans.dart';

class CustomCodeInput extends StatefulWidget {
  const CustomCodeInput({required this.length, super.key});
  final int length;

  @override
  _CustomCodeInputState createState() => _CustomCodeInputState();
}

class _CustomCodeInputState extends State<CustomCodeInput> {
  final controller = TextEditingController();
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: List.generate(
            widget.length,
            (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ColoredBox(
                  color: Colors.white,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontFamily: ConstantsApp.OPSemiBold,
                      color: ConstantsApp.colorBlackPrimary,
                    ),
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                    isDense: true,
                    counterText: '',
                    contentPadding:const  EdgeInsets.symmetric(vertical: 10),
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
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ConstantsApp.blueBorderColor,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ConstantsApp.cardBorderColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ConstantsApp.blueBorderColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ConstantsApp.blueBorderColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.text = _controllers.map((controller) => controller.text).join();
                        if (index < widget.length - 1) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      }else{
                        controller.text = _controllers.map((controller) => controller.text).join();
                        _focusNodes[index == 0 ? 0 : index - 1].requestFocus();
                      }
                      context.read<CodeBloc>().add(CodeChangeEvent(controller.text));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        BlocListener<CodeBloc, CodeState>(
          listener: (context, state) {
            if(state is CodeCleanState){
              for (final controller in _controllers) {
                  controller.clear();
              }
              FocusScope.of(context).unfocus();
            }
          },
          child: Container(),
        ),
      ],
    );
  }
}
