import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _locations = List<String>();
  for (var item in locations) {
    _locations.add(item);
  }
  _locations.sort();
  runApp(App(api: CubaWeather(), locations: _locations));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
