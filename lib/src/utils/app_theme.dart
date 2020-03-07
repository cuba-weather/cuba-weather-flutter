import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(primaryColor: Colors.blue);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(accentColor: Colors.white);
}
