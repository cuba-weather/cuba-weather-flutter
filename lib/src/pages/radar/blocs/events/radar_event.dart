import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class RadarEvent extends Equatable {
  const RadarEvent();

  @override
  List<Object> get props => [];
}

class FetchRadar extends RadarEvent {
  final String radarType;

  const FetchRadar(this.radarType);

  @override
  List<Object> get props => [radarType];
}

class SetShowImageRadar extends RadarEvent {
  final bool showImage;
  final dynamic radar;

  const SetShowImageRadar({
    @required this.radar,
    @required this.showImage,
  });

  @override
  List<Object> get props => [radar, showImage];
}
