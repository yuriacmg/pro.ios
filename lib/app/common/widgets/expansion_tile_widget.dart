// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/title_expansion_tile.widget.dart';

class ExpansionTileWidget extends StatefulWidget {
  ExpansionTileWidget({
    required this.child,
    required this.title,
    required this.fisrtTime,
    super.key,
  });
  Widget child;
  String title;
  bool fisrtTime;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  // VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleExpansionTileWidget(
          title: widget.title,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: widget.child,
        ),
      ],
    );
  }
}
