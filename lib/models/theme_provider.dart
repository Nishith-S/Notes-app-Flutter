import 'package:flutter/material.dart';
import '../themes/theme_of_note_app.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;
  bool get isDark => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if(_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}