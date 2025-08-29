// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  BodyWidget({
    required this.children,
    super.key,
  });

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: children,
    );
  }
}
