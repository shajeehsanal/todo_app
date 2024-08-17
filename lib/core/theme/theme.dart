import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/palette.dart';

class AppTheme {
  static final _primaryColor = Palette.primaryColor.toColor();
  static final _primaryColorLight = Palette.primaryColorLight.toColor();
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: _primaryColor),
    appBarTheme: AppBarTheme(color: _primaryColor),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: _primaryColorLight,
    colorScheme: ColorScheme.dark(primary: _primaryColorLight),
    scaffoldBackgroundColor: const Color.fromARGB(136, 58, 58, 58),
  );
}
