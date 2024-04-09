import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/global/global_variables.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  MainAxisAlignment dropdownRowAlignment = MainAxisAlignment.spaceBetween;
  List<DropdownMenuItem> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    dropdownItems = [
      DropdownMenuItem(
        value: 'System',
        child: Row(
          mainAxisAlignment: dropdownRowAlignment,
          children: const [Text('System'), Icon(Icons.computer)],
        ),
      ),
      DropdownMenuItem(
          value: 'Light',
          child: Row(
            mainAxisAlignment: dropdownRowAlignment,
            children: const [Text('Light'), Icon(Icons.light_mode)],
          )),
      DropdownMenuItem(
          value: 'Dark',
          child: Row(
            mainAxisAlignment: dropdownRowAlignment,
            children: const [Text('Dark'), Icon(Icons.dark_mode)],
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    String theme = themeMode == ThemeMode.system
        ? 'System'
        : themeMode == ThemeMode.light
            ? 'Light'
            : 'Dark';
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: dropdownItems,
            value: theme,
            onChanged: (value) {
              if (value == 'System') {
                themeMode = ThemeMode.system;
                setState(() {});
              } else if (value == 'Light') {
                themeMode = ThemeMode.light;
                setState(() {});
              } else {
                themeMode = ThemeMode.dark;
                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }
}
