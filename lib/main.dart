import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(api: CubaWeather()));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
