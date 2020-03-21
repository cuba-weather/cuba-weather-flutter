import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart' as cwd;

import 'package:cuba_weather/src/pages/municipality_list/blocs/blocs.dart';

class MunicipalityListBloc
    extends Bloc<MunicipalityListEvent, MunicipalityListState> {

  @override
  MunicipalityListState get initialState => MunicipalityListInitial();

  @override
  Stream<MunicipalityListState> mapEventToState(
      MunicipalityListEvent event) async* {
    if (event is FetchMunicipalityListEvent) {
      yield MunicipalityListLoading();
      try {
        List<cwd.MunicipalityModel> municipalities = cwd.municipalities;
        yield MunicipalityListLoaded(municipalities: municipalities);
      } catch (e) {
        log(e.toString());
        yield MunicipalityListError(errorMessage: e.toString());
      }
    }
  }
}
