import 'package:disenos/screens/slideshow_screen.dart';
import 'package:flutter/material.dart';

class LayoutModel extends ChangeNotifier {
  Widget _currentPage = const SlideShowScreen();

  Widget get currentPage => _currentPage;

  set currentPage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }
}
