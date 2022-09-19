import 'package:disenos/models/layout_model.dart';
import 'package:disenos/screens/launcher_screen.dart';
import 'package:disenos/screens/launcher_tablet_screen.dart';
import 'package:disenos/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChanger(2)),
          ChangeNotifierProvider(create: (_) => LayoutModel()),
        ],
        child: const MyApp(),
      ),
    );

// void main() => runApp(
//   ChangeNotifierProvider(
//     create: (_) => ThemeChanger(1),
//     child: const MyApp(),
//   ),
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final screenSize = MediaQuery.of(context).size;

          if (screenSize.width > 500) {
            return const LauncherTabletScreen();
          } else {
            return const LauncherScreen();
          }
        },
      ),
    );
  }
}
