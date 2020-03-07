import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/app_state_notifier.dart';
import 'package:cuba_weather/src/utils/app_theme.dart';

class App extends StatelessWidget {
  final String initialMunicipality;
  final String appName;

  App({
    Key key,
    @required this.initialMunicipality,
    @required this.appName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<AppStateNotifier>(context).isDarkModeOn;
    if (darkMode) {
      SystemChrome.setSystemUIOverlayStyle(AppTheme.darkOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlayStyle);
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          initialRoute: 'splash',
          routes: {
            'splash': (BuildContext context) => SplashScreen(
                  initialMunicipality: initialMunicipality,
                ),
          },
        );
      },
    );
  }
}
