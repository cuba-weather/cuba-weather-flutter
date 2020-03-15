import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/utils.dart';

class AppStateNotifier extends ChangeNotifier {
  String themeMode = 'system';

  AppStateNotifier() {
    themeMode = PrefService.getString(Constants.themeMode) ?? 'system';
  }

  void updateTheme(String themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }

  ThemeMode getTheme() {
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
