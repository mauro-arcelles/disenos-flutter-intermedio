import 'package:disenos/screens/launcher_screen.dart';
import 'package:disenos/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeChanger(3),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: const LauncherScreen(),
    );
  }
}
