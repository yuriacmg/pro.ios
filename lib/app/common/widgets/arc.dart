// ignore_for_file: lines_longer_than_80_chars, use_super_parameters, sort_constructors_first

import 'dart:math' as math;
import 'package:flutter/material.dart';

class Arc extends StatelessWidget {
  final double startAngle;
  final double sweepAngle;
  final double radius;
  final Color color;

  const Arc({
    required this.startAngle,
    required this.sweepAngle,
    required this.radius,
    Key? key,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: _ArcPainter(startAngle, sweepAngle, radius, color),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final double radius;
  final Color color;

  _ArcPainter(this.startAngle, this.sweepAngle, this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngleRadians = _degreesToRadians(startAngle);
    final sweepAngleRadians = _degreesToRadians(sweepAngle);

    canvas.drawArc(rect, startAngleRadians, sweepAngleRadians, false, paint);
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) => false;
}
