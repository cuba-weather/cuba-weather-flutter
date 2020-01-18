import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/widgets.dart';

class App extends StatelessWidget {
  final CubaWeather api;

  App({Key key, @required this.api})
      : assert(api != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuba Weather',
      theme: ThemeData(primaryColor: Colors.blue),
      home: BlocProvider(
        create: (context) => WeatherBloc(api: api),
        child: WeatherWidget(),
      ),
    );
  }
}
