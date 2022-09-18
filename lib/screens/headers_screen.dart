import 'package:disenos/theme/theme.dart';
import 'package:disenos/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final secondary = Provider.of<ThemeChanger>(context).currentTheme.colorScheme.secondary;

    return Scaffold(
      // Hay mas headers en el archivo headers.dart
      body: HeaderWaves(color: secondary),
    );
  }
}
