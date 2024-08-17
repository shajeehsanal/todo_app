import 'package:flutter/material.dart';
import 'package:todo_app/features/home/widgets/percent_widget.dart';
import 'package:todo_app/global/global_variables.dart';

class TaskGroupWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double percent;
  const TaskGroupWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Icon(icon, color: iconColor),
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: SizedBox(
        width: 50,
        height: 50,
        child: PercentWidget(
          color: iconColor,
          percent: percent,
          size: width * 0.12,
          thickness: 5,
        ),
      ),
    );
  }
}
