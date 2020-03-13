import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SettingsPageState();

  @override
  Widget build(BuildContext context) {
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
    // var window = WidgetsBinding.instance.window;
    // var isDarkSystem = window.platformBrightness == Brightness.dark;
    // var _new = themeMode == 'system' ? isDarkSystem : themeMode == 'dark';
    // Provider.of<AppStateNotifier>(context, listen: false).updateTheme(_new);
  }
}
