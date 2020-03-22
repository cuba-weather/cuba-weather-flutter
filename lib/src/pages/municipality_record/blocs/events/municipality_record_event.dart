import 'package:equatable/equatable.dart';

abstract class MunicipalityRecordEvent extends Equatable {
  const MunicipalityRecordEvent();

  @override
  List<Object> get props => [];
}

class InitialMunicipalityRecordEvent extends MunicipalityRecordEvent {
  const InitialMunicipalityRecordEvent();
}

class FetchMunicipalityRecordEvent extends MunicipalityRecordEvent {
  const FetchMunicipalityRecordEvent();
}
