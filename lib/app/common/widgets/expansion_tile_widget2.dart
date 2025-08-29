// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/title_expansion_tile.widget2.dart';

class ExpansionTileWidget2 extends StatefulWidget {
  ExpansionTileWidget2({
    required this.child,
    required this.title,
    required this.fisrtTime,
    super.key,
  });
  Widget child;
  String title;
  bool fisrtTime;

  @override
  State<ExpansionTileWidget2> createState() => _ExpansionTileWidget2State();
}

class _ExpansionTileWidget2State extends State<ExpansionTileWidget2> {
  // VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleExpansionTileWidget2(
          title: widget.title,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 16,
          ),
          child: widget.child,
        ),
      ],
    );
  }
}
