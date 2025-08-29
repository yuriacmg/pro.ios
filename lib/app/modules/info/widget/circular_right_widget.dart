import 'package:flutter/material.dart';
import 'package:perubeca/app/modules/info/widget/circular_widget.dart';

class CircularRightWidget extends StatelessWidget {
  const CircularRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -160,
      top: -84,
      child: CircularWidget(radius: 400),
    );
  }
}
