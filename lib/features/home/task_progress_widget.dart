import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/global/global_variables.dart';

class TaskProgressWidget extends StatelessWidget {
  const TaskProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = width > height ? width * 0.2 : height * 0.2;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
          CircularPercentIndicator(
            animation: true,
            radius: 45,
            reverse: true,
            animationDuration: 600,
            percent: 0.85,
            progressColor: color,
            lineWidth: 8,
            backgroundColor: Colors.grey.shade500,
            center: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 85),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Text(
                    '${value.round()}%',
                    style: TextStyle(
                      color: color,
                      fontSize: fontSize * 0.12,
                    ),
                  );
                }),
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
