import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: const Color(0xff5F33E1),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Color(0xff5F33E1)),
    appBarTheme: const AppBarTheme(
      color: Color(0xff5F33E1),
    ),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
    scaffoldBackgroundColor: const Color.fromARGB(136, 58, 58, 58),
  );
}
