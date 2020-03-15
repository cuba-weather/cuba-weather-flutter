import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {
  final bool showAnimation;

  const ForecastLoading({
    this.showAnimation = true,
  });

  @override
  List<Object> get props => [showAnimation];
}

class ForecastLoaded extends ForecastState {
  final InsmetForecastModel forecast;
  final bool showImage;
  final bool showAnimation;

  const ForecastLoaded({
    @required this.forecast,
    @required this.showImage,
    this.showAnimation = true,
  }) : assert(forecast != null, showImage != null);

  @override
  List<Object> get props => [forecast, showImage, showAnimation];
}

class ForecastError extends ForecastState {
  final String errorMessage;

  const ForecastError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
