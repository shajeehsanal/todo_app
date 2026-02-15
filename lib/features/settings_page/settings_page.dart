import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/theme/palette.dart';
import 'package:todo_app/core/theme/theme.dart';
import 'package:todo_app/global/global_providers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences preferences;
  List<DropdownMenuItem> dropdownItems = [
    const DropdownMenuItem(value: 'System', child: Icon(Icons.computer)),
    const DropdownMenuItem(value: 'Light', child: Icon(Icons.light_mode)),
    const DropdownMenuItem(value: 'Dark', child: Icon(Icons.dark_mode)),
  ];

  Future<void> initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: theme.scaffoldBackgroundColor),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final themeMode = ref.watch(themeModeProvider);
            final themeType = themeMode == ThemeMode.system
                ? 'System'
                : themeMode == ThemeMode.light
                    ? 'Light'
                    : 'Dark';

            return Column(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  preferences.setString(
                                    'colorTheme',
                                    'default',
                                  );
                                  ref.read(lightThemeProvider.notifier).update(
                                      (state) => AppTheme.lightTheme(Palette
                                          .defaultPrimaryColor
                                          .toColor()));
                                  ref.read(darkThemeProvider.notifier).update(
                                      (state) => AppTheme.darkTheme(Palette
                                          .defaultPrimaryColorLight
                                          .toColor()));
                                  Navigator.pop(context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 76, 16, 187),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  preferences.setString(
                                    'colorTheme',
                                    'red',
                                  );
                                  ref.read(lightThemeProvider.notifier).update(
                                      (state) => AppTheme.lightTheme(
                                          Palette.redPrimaryColor.toColor()));
                                  ref.read(darkThemeProvider.notifier).update(
                                      (state) => AppTheme.darkTheme(Palette
                                          .redPrimaryColorLight
                                          .toColor()));
                                  Navigator.pop(context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  preferences.setString(
                                    'colorTheme',
                                    'lightBlue',
                                  );
                                  ref.read(lightThemeProvider.notifier).update(
                                      (state) => AppTheme.lightTheme(Palette
                                          .lightBluePrimaryColor
                                          .toColor()));
                                  ref.read(darkThemeProvider.notifier).update(
                                      (state) => AppTheme.darkTheme(Palette
                                          .lightBluePrimaryColorLight
                                          .toColor()));
                                  Navigator.pop(context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.lightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Change Theme'),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: dropdownItems,
                    value: themeType,
                    onChanged: (value) {
                      preferences.setString(
                        'themeMode',
                        value.toString().trim(),
                      );
                      if (value == 'System') {
                        ref
                            .read(themeModeProvider.notifier)
                            .update((state) => ThemeMode.system);
                      } else if (value == 'Light') {
                        ref
                            .read(themeModeProvider.notifier)
                            .update((state) => ThemeMode.light);
                      } else {
                        ref
                            .read(themeModeProvider.notifier)
                            .update((state) => ThemeMode.dark);
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
