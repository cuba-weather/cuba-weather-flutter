import 'dart:developer';

import 'package:cuba_weather_municipality_dart/cuba_weather_municipality_dart.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _municipalities = List<String>();
  for (var item in municipalities) {
    _municipalities.add(item.name);
  }
  _municipalities.sort();
  String _initialMunicipality;
  try {
    var prefs = await SharedPreferences.getInstance();
    _initialMunicipality = prefs.getString('municipality');
  } catch (e) {
    log(e.toString());
  }
  runApp(App(
      api: CubaWeather(),
      municipalities: _municipalities,
      initialMunicipality: _initialMunicipality,
      appName: 'Cuba Weather'));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
