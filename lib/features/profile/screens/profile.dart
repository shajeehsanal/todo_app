import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/profile/widgets/profile_list_tile.dart';
import 'package:todo_app/features/profile/widgets/task_statistics_widget.dart';
import 'package:todo_app/features/settings_page/settings_page.dart';
import 'package:todo_app/global/global_providers.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final fontSize = width > height ? width * 0.2 : height * 0.2;
    final radius = (width < height ? width : height) * 0.1;
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.system
        ? theme.brightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    const whiteColor = Colors.white;
    final textColor = isDarkMode ? whiteColor : Colors.black;

    var centerLeft = Alignment.centerLeft;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Align(
                alignment: centerLeft,
                child: Wrap(
                  children: [
                    CircleAvatar(radius: radius),
                    SizedBox(width: width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shajeeh Sanal',
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize * 0.18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'shajeehsanal@gmail.com',
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize * 0.08,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: centerLeft,
                    child: Text(
                      'Task Stats',
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize * 0.13,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Wrap(
                    spacing: width * 0.05,
                    children: [
                      TaskStatisticsWidget(
                        textColor: textColor,
                        count: 20,
                        status: 'Completed',
                        fontSize: fontSize,
                      ),
                      TaskStatisticsWidget(
                        textColor: textColor,
                        count: 5,
                        status: 'In Progress',
                        fontSize: fontSize,
                      ),
                      TaskStatisticsWidget(
                        textColor: textColor,
                        count: 25,
                        status: 'To Do',
                        fontSize: fontSize,
                      ),
                      TaskStatisticsWidget(
                        textColor: textColor,
                        count: 3,
                        status: 'Cancelled',
                        fontSize: fontSize,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              const Divider(),
              SizedBox(height: height * 0.02),
              ProfileListTile(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                scrHeight: height,
                onTap: () {},
              ),
              ProfileListTile(
                icon: Icons.settings,
                title: 'Settings',
                scrHeight: height,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.06),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(
                    width < height ? width * 0.5 : width * 0.2,
                    width < height ? height * 0.05 : height * 0.1,
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.logout, color: whiteColor),
                label: const Text(
                  "Log Out",
                  style: TextStyle(color: whiteColor),
                ),
              ),
              SizedBox(height: height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
