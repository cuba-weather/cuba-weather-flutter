import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class App extends StatelessWidget {
  final CubaWeather api;
  final String initialMunicipality;
  final List<String> municipalities;
  final String appName;

  App({
    Key key,
    @required this.api,
    @required this.municipalities,
    @required this.initialMunicipality,
    @required this.appName,
  })  : assert(api != null),
        assert(municipalities != null),
        super(key: key);

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
      theme: ThemeData(primaryColor: Colors.blue),
      home: BlocProvider(
        create: (context) => WeatherBloc(api: api),
        child: WeatherWidget(
          municipalities: this.municipalities,
          initialMunicipality: this.initialMunicipality,
        ),
      ),
    );
  }
}
