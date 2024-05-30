import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: Colors.blue.shade900,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Colors.blue.shade900),
    appBarTheme: AppBarTheme(
      color: Colors.blue.shade900,
    ),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
    scaffoldBackgroundColor: const Color.fromARGB(137, 33, 33, 33),
  );
}
