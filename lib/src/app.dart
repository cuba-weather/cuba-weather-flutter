import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: Constants.appName,
      home: SplashScreen(),
    );
  }
}
