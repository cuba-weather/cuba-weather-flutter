import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/app.dart';
import 'package:cuba_weather/src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialMunicipality;
  String themeMode = "light";
  var prefs = await SharedPreferences.getInstance();
  try {
    initialMunicipality = prefs.getString(Constants.municipality);
    themeMode = prefs.getString(Constants.themeMode) ?? "light";
  } catch (e) {
    log(e.toString());
    themeMode = "light";
  }

  await PrefService.init();

  var window = WidgetsBinding.instance.window;
  var isDarkSystem = window.platformBrightness == Brightness.dark;
  var darkMode = themeMode == 'system' ? isDarkSystem : themeMode == 'dark';

  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(isDarkModeOn: darkMode),
      child: App(
        initialMunicipality: initialMunicipality,
        appName: Constants.appName,
      ),
    ),
  );
}
