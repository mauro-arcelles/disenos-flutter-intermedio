import 'package:flutter/material.dart';

final ThemeData customThemeData = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: const Color(0xff48A0EB),
  ),
  primaryColorLight: Colors.white,
  scaffoldBackgroundColor: const Color(0xff16202B),
);

class ThemeChanger extends ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;

  ThemeData _currentTheme = ThemeData.light();

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            secondary: Colors.pink,
          ),
        );
        break;
      case 2:
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark();
        break;
      case 3:
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = customThemeData;
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    _customTheme = false;
    if (value) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          secondary: Colors.pink,
        ),
      );
    }
    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;
    if (value) {
      _currentTheme = customThemeData;
    } else {
      _currentTheme = ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          secondary: Colors.pink,
        ),
      );
    }
    notifyListeners();
  }
}
