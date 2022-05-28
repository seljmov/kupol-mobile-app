import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsRepository {
  static const _themeModeKey = "theme_mode";

  /// Сохранить тему
  Future<void> saveThemeMode(ThemeMode mode) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: _themeModeKey);
    await storage.write(key: _themeModeKey, value: mode.toString());
  }

  /// Получить тему
  Future<ThemeMode> getThemeMode() async {
    final storage = FlutterSecureStorage();
    var savedTheme = await storage.containsKey(key: _themeModeKey);
    if (!savedTheme) return ThemeMode.light;
    var themeName = await storage.read(key: _themeModeKey);
    if (themeName == null) return ThemeMode.light;
    var theme = ThemeMode.values.firstWhere((e) => e.toString() == themeName);
    return theme;
  }
}
