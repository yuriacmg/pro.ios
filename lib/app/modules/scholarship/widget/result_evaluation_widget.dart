// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation, use_build_context_synchronously, inference_failure_on_instance_creation, omit_local_variable_types, prefer_final_locals

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class ResultEvaluationWidget extends StatelessWidget {
  const ResultEvaluationWidget({
    required this.imageKey,
    required this.total,
    required this.area,
    super.key,
  });

  final GlobalKey<State<StatefulWidget>> imageKey;
  final String total;
  final String area;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: RepaintBoundary(
          key: imageKey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                ConstantsApp.resultadoCourseSharedImage,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    const Text(
                      'Resultado de la evaluación',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: ConstantsApp.textBlackQuaternary,
                        fontFamily: ConstantsApp.OPMedium,
                      ),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: ConstantsApp.textBlackQuaternary,
                          fontFamily: ConstantsApp.OPMedium,
                        ),
                        text: 'Obtuviste ',
                        children: [
                          TextSpan(
                            text: total,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: ' puntos en el simulacro\n '),
                          TextSpan(text: 'de $area'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
