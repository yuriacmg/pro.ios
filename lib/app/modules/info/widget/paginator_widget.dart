// ignore_for_file: lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/material.dart';

class PaginatorWidget extends StatelessWidget {
  PaginatorWidget({
    required this.position,
    super.key,
  });
  int position;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: position == 1 ? const Color(0xffF59D24) : const Color.fromARGB(255, 221, 198, 164),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: position == 2 ? const Color(0xffF59D24) : const Color.fromARGB(255, 221, 198, 164),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: position == 3 ? const Color(0xffF59D24) : const Color.fromARGB(255, 221, 198, 164),
          ),
        ),
      ],
    );
  }
}
