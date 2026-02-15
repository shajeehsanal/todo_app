import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/global/global_providers.dart';

class TaskWidget extends ConsumerWidget {
  final String taskGroup;
  final IconData icon;
  final String task;
  final String time;
  final int status;
  final Color iconColor;

  const TaskWidget({
    super.key,
    required this.taskGroup,
    required this.icon,
    required this.task,
    required this.time,
    required this.status,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainSpaceBetween = MainAxisAlignment.spaceBetween;
    late final String statusString;
    if (status == 1) {
      statusString = 'To Do';
    } else if (status == 2) {
      statusString = 'In Progress';
    } else {
      statusString = 'Done';
    }
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final iconSize = width > height ? width * 0.1 : height * 0.1;
    final textColor = theme.iconTheme.color?.withOpacity(0.7);
    final fontSize = width > height ? width * 0.1 : height * 0.2;
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.system
        ? theme.brightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    final taskColor = isDarkMode ? Colors.white : Colors.black;
    const timeColor = Color(0xffab94ff);
    final Color statusColor;
    if (status == 1) {
      statusColor = Colors.blue;
    } else {
      statusColor = status == 2 ? Colors.orange : const Color(0xffab94ff);
    }
    final borderRadius = BorderRadius.circular(15);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: () {},
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.01,
          ),
          child: Column(
            mainAxisAlignment: mainSpaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: mainSpaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskGroup,
                    style:
                        TextStyle(color: textColor, fontSize: fontSize * 0.07),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        (width < height ? width : height) * 0.01),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: iconSize * 0.25,
                    ),
                  ),
                ],
              ),
              Text(
                task,
                style: TextStyle(
                  color: taskColor,
                  fontSize: fontSize * 0.09,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: mainSpaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.access_time_filled,
                            size: iconSize * 0.2,
                            color: timeColor,
                          ),
                        ),
                        TextSpan(
                          text: '  $time',
                          style: TextStyle(
                            color: timeColor,
                            fontSize: fontSize * 0.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        (width < height ? width : height) * 0.01),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      statusString,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: fontSize * 0.08,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
