// ignore: lines_longer_than_80_chars
// ignore_for_file: must_be_immutable, always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class CircularWidget extends StatelessWidget {
  CircularWidget({
    super.key,
    required this.radius,
  });

  double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [
            ConstantsApp.purplePrimaryColor,
            ConstantsApp.purpleSecondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
