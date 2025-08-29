// ignore_for_file: cascade_invocations, lines_longer_than_80_chars, directives_ordering
import 'package:flutter/material.dart';
import 'package:perubeca/app/utils/constans.dart';

class CurvedPainterTopRigth extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ConstantsApp.primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.22, size.width * 0.43, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.85, -size.height * 0.01, size.width * 0.88, size.height * 0.16);
    path.quadraticBezierTo(size.width * 0.88, size.height * 0.3, size.width * 0.7, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.55, size.width * 0.63, size.height * 0.59);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.63, size.width * 0.9, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.97, size.height * 0.85, size.width * 0.93, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    final path = Path();

    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
