import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cuba_weather/src/app.dart';
import 'package:cuba_weather/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String _initialMunicipality;
  try {
    var prefs = await SharedPreferences.getInstance();
    _initialMunicipality = prefs.getString(Constants.municipality);
  } catch (e) {
    log(e.toString());
  }
  runApp(
    App(
      initialMunicipality: _initialMunicipality,
      appName: Constants.appName,
    ),
  );
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}
