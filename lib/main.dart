import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/home/home.dart';
import 'package:todo_app/global/global_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        preferences = await SharedPreferences.getInstance();
        final currentTheme = preferences.getString('themeMode') ?? '';
        ref.read(themeModeProvider.notifier).update(
          (state) {
            ThemeMode themeMode = state;
            if (currentTheme == 'Light') {
              themeMode = ThemeMode.light;
            } else if (currentTheme == 'Dark') {
              themeMode = ThemeMode.dark;
            }
            return themeMode;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

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
