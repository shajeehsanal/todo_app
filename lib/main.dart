import 'package:flutter/material.dart';
import 'package:todo_app/features/home/home.dart';
import 'package:todo_app/global/global_variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.blue.shade900),
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade900),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: Colors.blue),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
