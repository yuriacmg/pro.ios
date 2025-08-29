// ignore_for_file: use_super_parameters, sort_constructors_first, library_private_types_in_public_api, lines_longer_than_80_chars

import 'package:flutter/material.dart';

class InfiniteRotation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const InfiniteRotation({
    required this.child,
    Key? key,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _InfiniteRotationState createState() => _InfiniteRotationState();
}

class _InfiniteRotationState extends State<InfiniteRotation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
