import 'package:flutter/material.dart';
import 'package:todo_app/features/home/task_progress_widget.dart';
import 'package:todo_app/global/global_variables.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = width > height ? width * 0.2 : height * 0.2;
    double iconSize = width > height ? width * 0.1 : height * 0.1;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(radius: 30),
                    SizedBox(width: width * 0.025),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: fontSize * 0.1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Shajeeh Sanal',
                          style: TextStyle(
                            fontSize: fontSize * 0.15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(
                      Icons.notifications,
                      size: iconSize * 0.45,
                      color: Colors.black,
                    ),
                    Positioned(
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
            const TaskProgressWidget(),
          ],
        ),
      ),
    );
  }
}
