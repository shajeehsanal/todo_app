import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/global/global_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DropdownMenuItem> dropdownItems = [];
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    dropdownItems = [
      const DropdownMenuItem(value: 'System', child: Icon(Icons.computer)),
      const DropdownMenuItem(value: 'Light', child: Icon(Icons.light_mode)),
      const DropdownMenuItem(value: 'Dark', child: Icon(Icons.dark_mode)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('User Email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Todo List'),
        elevation: 10,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeModeProvider);
              String theme = themeMode == ThemeMode.system
                  ? 'System'
                  : themeMode == ThemeMode.light
                      ? 'Light'
                      : 'Dark';

              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: dropdownItems,
                    value: theme,
                    onChanged: (value) async {
                      preferences = await SharedPreferences.getInstance();
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
              );
            },
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
