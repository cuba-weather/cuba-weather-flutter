import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _locations = List<String>();
  for (var item in locations) {
    _locations.add(item);
  }
  _locations.sort();
  String _initialLocation;
  try {
    var prefs = await SharedPreferences.getInstance();
    _initialLocation = prefs.getString('location');
  } catch (e) {
    log(e.toString());
  }
  runApp(App(
    api: CubaWeather(),
    locations: _locations,
    initialLocation: _initialLocation,
    appName: 'Cuba Weather'
  ));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
