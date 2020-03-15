import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class FetchForecast extends ForecastEvent {
  final String forecastType;

  const FetchForecast(this.forecastType);

  @override
  List<Object> get props => [forecastType];
}

class SetShowImageForecast extends ForecastEvent {
  final bool showImage;
  final InsmetForecastModel forecast;

  const SetShowImageForecast({
    @required this.forecast,
    @required this.showImage,
  });

  @override
  List<Object> get props => [forecast, showImage];
}
