import 'package:flutter/material.dart';
import 'package:todo_app/features/completed_tasks/widgets/task_tile.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: width * 0.02)
            .copyWith(bottom: height * 0.05),
        itemBuilder: (context, index) => TaskTile(
          index: index + 1,
          taskTitle: 'Title ${index + 1}',
          taskSubtitle: 'Subtitle ${index + 1}',
        ),
      ),
    );
  }
}
