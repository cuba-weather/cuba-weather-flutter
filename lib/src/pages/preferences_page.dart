import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/constants.dart';

import '../utils/app_state_notifier.dart';

class PreferencesPage extends StatelessWidget {
  final bool darkMode;

  PreferencesPage({
    Key key,
    @required this.darkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (darkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.grey[800],
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.blue[700],
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.blue[300],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: PreferencePage([
        PreferenceTitle('Personalización'),
        SwitchPreference(
          'Tema oscuro',
          Constants.darkMode,
          defaultVal: Provider.of<AppStateNotifier>(context).isDarkModeOn,
          onEnable: () {
            Provider.of<AppStateNotifier>(context, listen: false)
                .updateTheme(true);
          },
          onDisable: () {
            Provider.of<AppStateNotifier>(context, listen: false)
                .updateTheme(false);
          },
        ),
      ]),
    );
  }
}
