import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(primaryColor: Colors.blue);

  static final darkTheme = ThemeData.dark().copyWith(accentColor: Colors.white);

  static final lightOverlayStyle = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.blue[700],
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.blue[300],
  );

  static final darkOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  );
}
