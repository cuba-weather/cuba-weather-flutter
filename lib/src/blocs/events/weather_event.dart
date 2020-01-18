import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String location;

  const FetchWeather({@required this.location}) : assert(location != null);

  @override
  List<Object> get props => [location];
}
