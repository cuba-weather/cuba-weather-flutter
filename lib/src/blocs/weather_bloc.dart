import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

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
        final weather = await api.get(event.location, suggestion: true);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
    if (event is RefreshWeather) {
      try {
        final weather = await api.get(event.location);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }
}
