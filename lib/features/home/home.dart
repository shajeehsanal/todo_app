import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('User Email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Todo List'),
        elevation: 10,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
