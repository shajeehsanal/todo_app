import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/theme/palette.dart';

final lightThemeProvider = StateProvider<ThemeData>(
    (ref) => AppTheme.lightTheme(Palette.defaultPrimaryColor.toColor()));
final darkThemeProvider = StateProvider<ThemeData>(
    (ref) => AppTheme.darkTheme(Palette.defaultPrimaryColorLight.toColor()));

class AppTheme {
  //! text styles
  static const _titleTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const _subtitleTextStyle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static const _textTheme =
      TextTheme(titleLarge: _titleTextStyle, titleMedium: _subtitleTextStyle);

  static ThemeData lightTheme(Color primaryColor) {
    return ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(primary: primaryColor),
      appBarTheme: AppBarTheme(color: primaryColor),
      textTheme: _textTheme,
    );
  }

  static ThemeData darkTheme(Color primaryColorLight) {
    return ThemeData.dark(useMaterial3: true).copyWith(
      primaryColor: primaryColorLight,
      colorScheme: ColorScheme.dark(primary: primaryColorLight),
      scaffoldBackgroundColor: const Color.fromARGB(136, 58, 58, 58),
      textTheme: _textTheme,
      cardTheme: const CardTheme(color: Colors.white30),
    );
  }
}
