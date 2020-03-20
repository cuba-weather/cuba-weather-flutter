import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MunicipalityListState extends Equatable {
  const MunicipalityListState();

  @override
  List<Object> get props => [];
}

class MunicipalityListInitial extends MunicipalityListState {}

class MunicipalityListLoading extends MunicipalityListState {}

class MunicipalityListLoaded extends MunicipalityListState {
  final List<MunicipalityModel> municipalities;

  const MunicipalityListLoaded({@required this.municipalities})
      : assert(municipalities != null);

  @override
  List<Object> get props => [municipalities];
}

class MunicipalityListError extends MunicipalityListState {
  final String errorMessage;

  const MunicipalityListError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
