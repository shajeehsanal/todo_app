import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/widgets/percent_widget.dart';
import 'package:todo_app/global/global_providers.dart';

class TaskProgressWidget extends ConsumerWidget {
  const TaskProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var value = width > height;
    double fontSize = value ? width * 0.2 : height * 0.2;
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.system
        ? MediaQuery.of(context).platformBrightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    final color = isDarkMode ? Colors.black : Colors.white;

    return Container(
      width: width * 0.85,
      height: height * 0.25,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.4,
                child: Text(
                  "Your today's task almost done!",
                  style: TextStyle(
                    color: color,
                    fontSize: fontSize * 0.1,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Task',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          PercentWidget(
            color: color,
            percent: 0.85,
            size: value ? height * 0.15 : width * 0.2,
            thickness: 10,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.more_horiz,
                  color: color,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
