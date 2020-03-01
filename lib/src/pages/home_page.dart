import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cuba_weather/src/blocs/blocs.dart';
import 'package:cuba_weather/src/widgets/weather_widget.dart';
import 'package:cuba_weather_municipality_dart/cuba_weather_municipality_dart.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';

class HomePage extends StatefulWidget {
  final String initialMunicipality;
  HomePage({
    Key key,
    @required this.initialMunicipality,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final _municipalities = List<String>();
    for (var item in municipalities) {
      _municipalities.add(item.name);
    }
    _municipalities.sort();

    return BlocProvider(
      create: (context) => WeatherBloc(api: CubaWeather()),
      child: WeatherWidget(
        municipalities: _municipalities,
        initialMunicipality: widget.initialMunicipality,
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
