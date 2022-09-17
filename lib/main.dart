// import 'package:disenos/labs/circular_progress_screen.dart';
// import 'package:disenos/screens/graficas_circulares_screen.dart';
// import 'package:disenos/screens/headers_screen.dart';
// import 'package:disenos/screens/emergency_screen.dart';
import 'package:disenos/screens/sliver_list_screen.dart';
// import 'package:disenos/screens/pinterest_screen.dart';
// import 'package:disenos/screens/slideshow_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: SliverListScreen(),
    );
  }
}
