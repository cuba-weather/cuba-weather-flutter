import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SatelliteState extends Equatable {
  const SatelliteState();

  @override
  List<Object> get props => [];
}

class SatelliteInitial extends SatelliteState {}

class SatelliteLoading extends SatelliteState {
  final bool showAnimation;

  const SatelliteLoading({
    this.showAnimation = true,
  });

  @override
  List<Object> get props => [showAnimation];
}

class SatelliteLoaded extends SatelliteState {
  final InsmetSatelliteModel satellite;
  final bool showImage;
  final bool showAnimation;

  const SatelliteLoaded({
    @required this.satellite,
    @required this.showImage,
    this.showAnimation = true,
  }) : assert(satellite != null, showImage != null);

  @override
  List<Object> get props => [satellite, showImage, showAnimation];
}

class SatelliteError extends SatelliteState {
  final String errorMessage;

  const SatelliteError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
