import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/app.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:cuba_weather/src/utils/app_state_notifier.dart';
import 'package:preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialMunicipality;
  bool darkMode = false;
  var prefs = await SharedPreferences.getInstance();
  try {
    initialMunicipality = prefs.getString(Constants.municipality);
    darkMode = prefs.getBool(Constants.darkMode) ?? false;
  } catch (e) {
    log(e.toString());
    darkMode = false;
  }
  await PrefService.init();
  var window = WidgetsBinding.instance.window;
  bool isDarkSystem = window.platformBrightness == Brightness.dark;
  darkMode = darkMode || isDarkSystem;
  prefs.setBool(Constants.darkMode, darkMode);
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(isDarkModeOn: darkMode),
      child: App(
          initialMunicipality: initialMunicipality,
          appName: Constants.appName,
          darkMode: darkMode),
    ),
  );
}
