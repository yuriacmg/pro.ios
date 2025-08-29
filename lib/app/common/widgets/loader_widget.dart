// ignore_for_file: library_private_types_in_public_api, lines_longer_than_80_chars, omit_local_variable_types, prefer_final_locals

import 'dart:math';

import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double waveAmplitude = 30; // Amplitud de la onda
  double waveFrequency = 0.5; // Frecuencia de la onda
  double waveSpeed = 0.9; // Velocidad de la onda

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(0, Colors.red),
                const SizedBox(height: 16),
                buildContainer(1, Colors.blue),
                const SizedBox(height: 16),
                buildContainer(2, Colors.green),
                const SizedBox(height: 16),
                buildContainer(3, Colors.orange),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildContainer(int index, Color color) {
    var radianes = (2 * pi * waveFrequency * index) + (waveSpeed * _animation.value * 2 * pi);
    double xOffset = waveAmplitude * sin(radianes);

    return Transform.translate(
      offset: Offset(1, xOffset),
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
