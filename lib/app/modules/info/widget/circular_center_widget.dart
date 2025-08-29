import 'package:flutter/material.dart';
import 'package:perubeca/app/modules/info/widget/circular_widget.dart';

class CircularCenterWidget extends StatelessWidget {
  const CircularCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -MediaQuery.of(context).size.height * 0.7,
      child: CircularWidget(radius: MediaQuery.of(context).size.height * 0.99),
    );
  }
}
