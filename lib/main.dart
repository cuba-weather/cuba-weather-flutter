import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuba_weather/src/app.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/utils/app_state_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String _initialMunicipality;
  bool _darkMode;
  try {
    var prefs = await SharedPreferences.getInstance();
    _initialMunicipality = prefs.getString(Constants.municipality);
    try {
      _darkMode = prefs.getBool(Constants.darkMode) ?? false;
      print("_darkMode = " + _darkMode.toString());
    } catch (e) {
      log(e.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(isDarkModeOn: _darkMode),
      child: App(
        initialMunicipality: _initialMunicipality,
        appName: Constants.appName,
        darkMode: _darkMode,
      ),
    ),
  );
}
