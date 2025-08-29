import 'package:flutter/material.dart';
import 'package:perubeca/app/modules/info/widget/circular_widget.dart';

class CircularLeftWidget extends StatelessWidget {
  const CircularLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -160,
      top: -84,
      child: CircularWidget(radius: 400),
    );
  }
}
