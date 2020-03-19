import 'package:equatable/equatable.dart';

abstract class MunicipalityListEvent extends Equatable {
  const MunicipalityListEvent();

  @override
  List<Object> get props => [];
}

class InitialMunicipalityListEvent extends MunicipalityListEvent {
  const InitialMunicipalityListEvent();
}

class FetchMunicipalityListEvent extends MunicipalityListEvent {
  const FetchMunicipalityListEvent();
}
