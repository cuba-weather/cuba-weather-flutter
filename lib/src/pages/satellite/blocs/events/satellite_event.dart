import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

abstract class SatelliteEvent extends Equatable {
  const SatelliteEvent();

  @override
  List<Object> get props => [];
}

class FetchSatellite extends SatelliteEvent {
  final String satelliteType;

  const FetchSatellite(this.satelliteType);

  @override
  List<Object> get props => [satelliteType];
}

class SetShowImageSatellite extends SatelliteEvent {
  final bool showImage;
  final InsmetSatelliteModel satellite;

  const SetShowImageSatellite({
    @required this.satellite,
    @required this.showImage,
  });

  @override
  List<Object> get props => [satellite, showImage];
}
