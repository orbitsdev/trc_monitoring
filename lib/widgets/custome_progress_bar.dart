import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final BorderRadius borderRadius;
   CustomProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderRadius,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
