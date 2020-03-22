import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RadarState extends Equatable {
  const RadarState();

  @override
  List<Object> get props => [];
}

class RadarInitial extends RadarState {}

class RadarLoading extends RadarState {
  final bool showAnimation;

  const RadarLoading({
    this.showAnimation = true,
  });

  @override
  List<Object> get props => [showAnimation];
}

class RadarLoaded extends RadarState {
  final dynamic radar;
  final bool showImage;
  final bool showAnimation;

  const RadarLoaded({
    @required this.radar,
    @required this.showImage,
    this.showAnimation = true,
  }) : assert(radar != null, showImage != null);

  @override
  List<Object> get props => [radar, showImage, showAnimation];
}

class RadarError extends RadarState {
  final String errorMessage;

  const RadarError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
