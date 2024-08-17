import 'dart:math' show pi;

import 'package:flutter/material.dart';

class PercentWidget extends StatelessWidget {
  final Color color;
  final double percent;
  final double size;
  final double thickness;
  const PercentWidget({
    super.key,
    required this.color,
    required this.percent,
    required this.size,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: percent),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) => Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.rotationY(pi),
            alignment: Alignment.center,
            child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: value,
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: thickness,
                backgroundColor: Colors.grey.shade500,
              ),
            ),
          ),
          Text(
            '${(value * 100).round()}',
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
