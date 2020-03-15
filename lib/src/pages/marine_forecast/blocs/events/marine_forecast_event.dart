import 'package:equatable/equatable.dart';

abstract class MarineForecastEvent extends Equatable {
  const MarineForecastEvent();

  @override
  List<Object> get props => [];
}

class FetchMarineForecast extends MarineForecastEvent {
  final String forecastType;

  const FetchMarineForecast(this.forecastType);

  @override
  List<Object> get props => [forecastType];
}
