import 'package:flutter/material.dart';

class TaskStatisticsWidget extends StatelessWidget {
  final int count;
  final String status;
  final double fontSize;
  final Color textColor;
  const TaskStatisticsWidget({
    super.key,
    required this.count,
    required this.status,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: fontSize * 0.08,
          ),
        ),
        Text(
          status,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize * 0.1,
          ),
        ),
      ],
    );
  }
}
