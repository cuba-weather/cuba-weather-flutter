import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MunicipalityRecordState extends Equatable {
  const MunicipalityRecordState();

  @override
  List<Object> get props => [];
}

class MunicipalityRecordInitial extends MunicipalityRecordState {}

class MunicipalityRecordLoading extends MunicipalityRecordState {}

class MunicipalityRecordLoaded extends MunicipalityRecordState {
  final List<String> municipalities;

  const MunicipalityRecordLoaded({@required this.municipalities})
      : assert(municipalities != null);

  @override
  List<Object> get props => [municipalities];
}

class MunicipalityRecordError extends MunicipalityRecordState {
  final String errorMessage;

  const MunicipalityRecordError({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage];
}
