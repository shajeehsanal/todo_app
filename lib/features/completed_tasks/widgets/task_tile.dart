import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final int index;
  final String taskTitle;
  final String taskSubtitle;
  const TaskTile({
    super.key,
    required this.index,
    required this.taskTitle,
    required this.taskSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        onTap: () {},
        leading: CircleAvatar(child: Text(index.toString())),
        title: Text(taskTitle),
        subtitle: Text(taskSubtitle),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
