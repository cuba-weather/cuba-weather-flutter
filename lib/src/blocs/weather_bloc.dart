import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuba_weather/src/blocs/blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final CubaWeather api;

  WeatherBloc({@required this.api}) : assert(api != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('location', event.location);
      } catch (e) {
        log(e.toString());
      }
      try {
        final weather = await api.get(event.location);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        log(e.toString());
        yield WeatherError(errorMessage: e.toString());
      }
    }
    if (event is RefreshWeather) {
      try {
        final weather = await api.get(event.location);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        log(e.toString());
        yield state;
      }
    }
  }
}
