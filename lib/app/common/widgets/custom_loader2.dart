// ignore_for_file: use_super_parameters, sort_constructors_first, must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/arc.dart';
import 'package:perubeca/app/common/widgets/infinity_rotation.dart';

class CustomLoader2 extends StatelessWidget {
  CustomLoader2({
    this.color,
    Key? key,
  }) : super(key: key);

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        //Loader
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfiniteRotation(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.6),
                          width: 10,
                        ),
                      ),
                    ),
                    Arc(
                      startAngle: 45,
                      sweepAngle: 90,
                      radius: 26,
                      color: color ?? Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Cargando',
                  style: TextStyle(
                    // fontFamily: ConstantsApp.OPSemiBold,
                    fontSize: 16,
                    color: color ?? Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
