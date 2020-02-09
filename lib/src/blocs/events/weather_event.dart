import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String municipality;

  const FetchWeather({@required this.municipality})
      : assert(municipality != null);

  @override
  List<Object> get props => [municipality];
}

class RefreshWeather extends WeatherEvent {
  final String municipality;

  const RefreshWeather({@required this.municipality})
      : assert(municipality != null);

  @override
  List<Object> get props => [municipality];
}

class FindLocationWeather extends WeatherEvent {
  List<Object> get props => [];
}
