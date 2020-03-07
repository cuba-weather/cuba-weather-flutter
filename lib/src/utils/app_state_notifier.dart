import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDarkModeOn;

  AppStateNotifier({
    @required this.isDarkModeOn,
  });

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}
