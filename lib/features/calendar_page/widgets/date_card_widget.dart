import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/global/global_providers.dart';

class DateCardWidget extends ConsumerWidget {
  final String month;
  final int date;
  final String day;
  final bool selected;
  const DateCardWidget({
    super.key,
    required this.month,
    required this.date,
    required this.day,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.system
        ? theme.brightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    final Color? textColor;
    if (selected) {
      textColor = Colors.white;
    } else {
      textColor = isDarkMode ? null : Colors.black;
    }
    final color = selected ? theme.primaryColor : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: Card(
        color: color,
        child: SizedBox(
          width: width * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                month,
                style: TextStyle(fontSize: 15, color: textColor),
              ),
              Text(
                date.toString(),
                style: TextStyle(fontSize: 20, color: textColor),
              ),
              Text(
                day,
                style: TextStyle(fontSize: 15, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
