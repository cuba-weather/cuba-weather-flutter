import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:cuba_weather/src/pages/home/models/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherInitial extends WeatherState {
  final String municipality;

  const WeatherInitial({@required this.municipality})
      : assert(municipality != null);

  @override
  List<Object> get props => [municipality];
}

class WeatherFindingLocation extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String errorMessage;

  const WeatherError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
