import 'package:flutter/material.dart';

class ChangeThemeNotifier with ChangeNotifier {
  late ThemeMode themeMode;

  ChangeThemeNotifier(ThemeMode mode) {
    themeMode = mode;
  }

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}
