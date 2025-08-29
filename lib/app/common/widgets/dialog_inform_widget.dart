// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DialogInformWidget extends StatelessWidget {
  DialogInformWidget({
    required this.title,
    required this.message,
    required this.ontap,
    super.key,
  });

  String title;
  String message;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
      ),
      actions: [
        TextButton(
          onPressed: ontap,
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
