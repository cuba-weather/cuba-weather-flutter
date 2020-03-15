import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/utils.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Configuración'),
        centerTitle: true,
      ),
      body: PreferencePage([
        PreferenceTitle(
          'Tema',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
    Provider.of<AppStateNotifier>(context, listen: false)
        .updateTheme(themeMode);
  }
}
