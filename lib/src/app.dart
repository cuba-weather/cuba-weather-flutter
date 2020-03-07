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
  final bool darkMode;

  App({
    Key key,
    @required this.initialMunicipality,
    @required this.appName,
    @required this.darkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (darkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.blue[700],
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.blue[700],
        ),
      );
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
                  darkMode: darkMode,
                ),
          },
        );
      },
    );
  }
}
