import 'dart:developer';
import 'dart:io';

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
        await prefs.setString('municipality', event.municipality);
      } catch (e) {
        log(e.toString());
      }
      try {
        final weather = await api.get(event.municipality);
        yield WeatherLoaded(weather: weather);
      } on SocketException catch (e) {
        log(e.toString());
        yield WeatherError(
          errorMessage: 'No se ha podido establecer conexión con la red '
              'nacional. Por favor, revise su conexión y vuelva a intentarlo.',
        );
      } catch (e) {
        log(e.toString());
        yield WeatherError(errorMessage: e.toString());
      }
    }
    if (event is RefreshWeather) {
      try {
        final weather = await api.get(event.municipality);
        yield WeatherLoaded(weather: weather);
      } on SocketException catch (e) {
        log(e.toString());
        yield WeatherError(
          errorMessage: 'No se ha podido establecer conexión con la red '
              'nacional. Por favor, revise su conexión y vuelva a intentarlo.',
        );
      } catch (e) {
        log(e.toString());
        yield WeatherError(errorMessage: e.toString());
      }
    }
  }
}
