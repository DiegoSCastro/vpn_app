import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/settings/app_preferences.dart';

import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free VPN',
      themeMode: AppPreferences.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 3,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 3,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightTextColor => AppPreferences.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNavigationBarTheme =>
      AppPreferences.isDarkMode ? Colors.white12 : Colors.redAccent;
}
