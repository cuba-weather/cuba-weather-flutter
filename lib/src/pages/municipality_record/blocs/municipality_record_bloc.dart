import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:preferences/preferences.dart';

import 'package:cuba_weather/src/utils/utils.dart';
import 'package:cuba_weather/src/pages/municipality_record/blocs/blocs.dart';

class MunicipalityRecordBloc
    extends Bloc<MunicipalityRecordEvent, MunicipalityRecordState> {

  @override
  MunicipalityRecordState get initialState => MunicipalityRecordInitial();

  @override
  Stream<MunicipalityRecordState> mapEventToState(
      MunicipalityRecordEvent event) async* {
    if (event is FetchMunicipalityRecordEvent) {
      yield MunicipalityRecordLoading();
      try {
        List<String> municipalities = PrefService.getStringList(Constants.municipalityRecord)??List<String>();
        yield MunicipalityRecordLoaded(municipalities: municipalities);
      } catch (e) {
        log(e.toString());
        yield MunicipalityRecordError(errorMessage: e.toString());
      }
    }
  }
}
