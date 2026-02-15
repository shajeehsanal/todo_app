import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/theme/palette.dart';
import 'package:todo_app/core/theme/theme.dart';
import 'package:todo_app/features/navbar/screens/navbar.dart';
import 'package:todo_app/global/global_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final sharedPreferencesProvider =
    Provider.autoDispose<SharedPreferences>((ref) {
  throw UnimplementedError();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final preferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final loadedProvider = StateProvider.autoDispose<bool>((ref) => false);
  late ThemeData lightThemeData;
  late ThemeData darkThemeData;
  late ThemeMode currentThemeMode;

  @override
  void initState() {
    super.initState();
    final preferences = ref.read(sharedPreferencesProvider);
    final currentTheme = preferences.getString('themeMode') ?? '';
    final colorTheme = preferences.getString('colorTheme') ?? '';
    if (colorTheme == 'red') {
      lightThemeData = AppTheme.lightTheme(Palette.redPrimaryColor.toColor());
      darkThemeData =
          AppTheme.darkTheme(Palette.redPrimaryColorLight.toColor());
    } else if (colorTheme == 'lightBlue') {
      lightThemeData =
          AppTheme.lightTheme(Palette.lightBluePrimaryColor.toColor());
      darkThemeData =
          AppTheme.darkTheme(Palette.lightBluePrimaryColorLight.toColor());
    } else {
      lightThemeData =
          AppTheme.lightTheme(Palette.defaultPrimaryColor.toColor());
      darkThemeData =
          AppTheme.darkTheme(Palette.defaultPrimaryColorLight.toColor());
    }
    if (currentTheme == 'Light') {
      currentThemeMode = ThemeMode.light;
    } else if (currentTheme == 'Dark') {
      currentThemeMode = ThemeMode.dark;
    } else {
      currentThemeMode = ThemeMode.system;
    }
    // Update providers based on SharedPreferences values
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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

      ref.read(lightThemeProvider.notifier).update((state) {
        ThemeData themeData = state;
        if (colorTheme == 'red') {
          themeData = AppTheme.lightTheme(Palette.redPrimaryColor.toColor());
        } else if (colorTheme == 'lightBlue') {
          themeData =
              AppTheme.lightTheme(Palette.lightBluePrimaryColor.toColor());
        } else {
          themeData =
              AppTheme.lightTheme(Palette.defaultPrimaryColor.toColor());
        }
        return themeData;
      });

      ref.read(darkThemeProvider.notifier).update((state) {
        ThemeData themeData = state;
        if (colorTheme == 'red') {
          themeData =
              AppTheme.darkTheme(Palette.redPrimaryColorLight.toColor());
        } else if (colorTheme == 'lightBlue') {
          themeData =
              AppTheme.darkTheme(Palette.lightBluePrimaryColorLight.toColor());
        } else {
          themeData =
              AppTheme.darkTheme(Palette.defaultPrimaryColorLight.toColor());
        }
        return themeData;
      });
      ref.read(loadedProvider.notifier).update((state) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loaded = ref.watch(loadedProvider);
    final ThemeData lightTheme;
    final ThemeData darkTheme;
    final ThemeMode themeMode;
    if (loaded) {
      lightTheme = ref.watch(lightThemeProvider);
      darkTheme = ref.watch(darkThemeProvider);
      themeMode = ref.watch(themeModeProvider);
    } else {
      lightTheme = lightThemeData;
      darkTheme = darkThemeData;
      themeMode = currentThemeMode;
    }

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const NavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
