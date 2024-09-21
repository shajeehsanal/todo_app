import 'package:flutter/material.dart';
import 'package:todo_app/global/global_variables.dart';

class DateCardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : Colors.black;
    final color = selected ? Theme.of(context).primaryColor : Colors.white;
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
