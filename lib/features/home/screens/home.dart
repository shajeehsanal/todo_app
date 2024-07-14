import 'package:flutter/material.dart';
import 'package:todo_app/features/home/widgets/in_progress_widget.dart';
import 'package:todo_app/features/home/widgets/task_progress_widget.dart';
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
            SizedBox(height: height * 0.05),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                Text(
                  'In Progress',
                  style: TextStyle(
                    fontSize: fontSize * 0.15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.02),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 200, 176, 245),
                  radius: 12,
                  child: Text(
                    '6',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: fontSize * 0.1,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.2,
              width: width,
              child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index.isEven) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        left: index == 0 ? width * 0.07 : null,
                        right: index == 5 ? width * 0.07 : null,
                      ),
                      child: InProgressWidget(
                        backgroundColor: Colors.blue.shade100,
                        icon: Icons.cases_sharp,
                        title: 'Grocery shopping app design',
                        category: 'Office Project',
                        progressBarColor: Colors.blue,
                        iconColor: Colors.pink,
                        percent: 0.7,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        left: index == 0 ? width * 0.07 : null,
                        right: index == 5 ? width * 0.07 : null,
                      ),
                      child: InProgressWidget(
                        backgroundColor: Colors.orange.shade100,
                        icon: Icons.person,
                        title: 'Uber Eats design challenge',
                        category: 'Personal Project',
                        progressBarColor: Colors.orange,
                        iconColor: Colors.purple,
                        percent: 0.5,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
