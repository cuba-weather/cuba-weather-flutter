import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.blue,
    primaryColor: Colors.blue,
    accentColor: Colors.white,
  );

  static final darkTheme = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    primaryColor: Colors.black,
    accentColor: Colors.white,
  );
}
