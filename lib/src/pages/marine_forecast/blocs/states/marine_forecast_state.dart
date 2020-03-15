import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MarineForecastState extends Equatable {
  const MarineForecastState();

  @override
  List<Object> get props => [];
}

class MarineForecastInitial extends MarineForecastState {}

class MarineForecastLoading extends MarineForecastState {}

class MarineForecastLoaded extends MarineForecastState {
  final InsmetMarineForecastModel forecast;

  const MarineForecastLoaded({@required this.forecast})
      : assert(forecast != null);

  @override
  List<Object> get props => [forecast];
}

class MarineForecastError extends MarineForecastState {
  final String errorMessage;

  const MarineForecastError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
