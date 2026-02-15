import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/widgets/in_progress_widget.dart';
import 'package:todo_app/features/home/widgets/task_group_widget.dart';
import 'package:todo_app/features/home/widgets/task_progress_widget.dart';
import 'package:todo_app/global/global_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final fontSize = width > height ? width * 0.2 : height * 0.2;
    final iconSize = width > height ? width * 0.1 : height * 0.1;
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final bool isDarkMode;
    if (themeMode == ThemeMode.system) {
      isDarkMode = theme.brightness == Brightness.dark;
    } else {
      isDarkMode = themeMode == ThemeMode.dark;
    }
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final primaryColor = theme.primaryColor;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              leading: Padding(
                padding: EdgeInsets.only(left: width * 0.01),
                child: const CircleAvatar(radius: 30),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: fontSize * 0.1,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Shajeeh Sanal',
                    style: TextStyle(
                      fontSize: fontSize * 0.15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: width * 0.01),
                  child: Badge(
                    isLabelVisible: true,
                    smallSize: 18,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.notifications,
                      size: iconSize * 0.45,
                    ),
                  ),
                ),
              ],
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.03),
                const TaskProgressWidget(),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    SizedBox(width: width * 0.05),
                    Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: fontSize * 0.15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
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
                          padding: EdgeInsets.only(
                            left: index == 0 ? width * 0.07 : 8,
                            right: index == 5 ? width * 0.07 : 8,
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
                          padding: EdgeInsets.only(
                            left: index == 0 ? width * 0.07 : 8,
                            right: index == 5 ? width * 0.07 : 8,
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
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    SizedBox(width: width * 0.05),
                    Text(
                      'Task Groups',
                      style: TextStyle(
                        fontSize: fontSize * 0.15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 200, 176, 245),
                      radius: 12,
                      child: Text(
                        '4',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: fontSize * 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        TaskGroupWidget(
                          icon: Icons.cases_rounded,
                          iconColor: Colors.pink.shade500,
                          title: 'Office Project',
                          subtitle: '23 Tasks',
                          percent: 0.70,
                        ),
                        const TaskGroupWidget(
                          icon: Icons.person,
                          iconColor: Colors.purple,
                          title: 'Personal Project',
                          subtitle: '30 Tasks',
                          percent: 0.52,
                        ),
                        TaskGroupWidget(
                          icon: Icons.menu_book_outlined,
                          iconColor: Colors.orange.shade800,
                          title: 'Daily Study',
                          subtitle: '30 Tasks',
                          percent: 0.87,
                        ),
                        TaskGroupWidget(
                          icon: Icons.show_chart_outlined,
                          iconColor: Colors.yellow.shade700,
                          title: 'Test Todo',
                          subtitle: '15 Tasks',
                          percent: 0.13,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
