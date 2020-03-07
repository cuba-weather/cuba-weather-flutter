import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/utils.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({Key key}) : super(key: key);

  @override
  State<PreferencesPage> createState() => PreferencesPageState();
}

class PreferencesPageState extends State<PreferencesPage> {
  PreferencesPageState();

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<AppStateNotifier>(context).isDarkModeOn;
    if (darkMode) {
      SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlayStyle);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: PreferencePage([
        PreferenceTitle('Tema'),
        RadioPreference(
          'Claro',
          'light',
          Constants.themeMode,
          onSelect: () {
            updateTheme("light");
          },
        ),
        RadioPreference(
          'Oscuro',
          'dark',
          Constants.themeMode,
          onSelect: () {
            updateTheme("dark");
          },
        ),
        RadioPreference(
          'Sistema',
          'system',
          Constants.themeMode,
          onSelect: () {
            updateTheme("system");
          },
        ),
      ]),
    );
  }

  void updateTheme(String themeMode) {
    var window = WidgetsBinding.instance.window;
    var isDarkSystem = window.platformBrightness == Brightness.dark;
    var _new = themeMode == 'system' ? isDarkSystem : themeMode == 'dark';
    Provider.of<AppStateNotifier>(context, listen: false).updateTheme(_new);
  }
}
