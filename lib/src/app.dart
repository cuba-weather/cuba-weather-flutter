import 'package:cuba_weather/src/pages/pages.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.blue[700],
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blue[300],
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: Constants.fontFamily),
      initialRoute: 'splash',
      routes: {
        'splash': (BuildContext context) =>
            SplashScreen(initialMunicipality: initialMunicipality),
      },
    );
  }
}
