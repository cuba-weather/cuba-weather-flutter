import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:preferences/preference_service.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/satellite/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class SatelliteBloc extends Bloc<SatelliteEvent, SatelliteState> {
  final CubaWeather api;

  SatelliteBloc({@required this.api}) : assert(api != null);

  @override
  SatelliteState get initialState => SatelliteInitial();

  @override
  Stream<SatelliteState> mapEventToState(SatelliteEvent event) async* {
    if (event is FetchSatellite) {
      yield SatelliteLoading();
      var keyPref = Constants.showImageForecastPage;
      var showImage = PrefService.getBool(keyPref) ?? false;
      try {
        InsmetSatelliteModel satellite;
        switch (event.satelliteType) {
          case 'latest_eastir.jpg':
            satellite = await api.getSatelliteWisconsinMadisonLatestEastir();
            break;
          case 'latest_eastvis.jpg':
            satellite = await api.getSatelliteWisconsinMadisonLatestEastvis();
            break;
          case 'goes.gsfc.nasa.gov.jpg':
            satellite = await api.getSatelliteWisconsinMadisonGOESGSFC();
            break;
          case 'cuba-g16.jpg':
            satellite = await api.getSatelliteMarshallSpaceFlightCenterGOESMSFC();
            break;
          default://www.intellicast.com.jpg
            satellite = await api.getSatelliteWeatherUndergroundIntellicast();
            break;
        }
        yield SatelliteLoaded(satellite: satellite, showImage: showImage);
      } on BadRequestException catch (e) {
        log(e.toString());
        yield SatelliteError(
          errorMessage: Constants.errorMessageBadRequestException,
        );
      } catch (e) {
        log(e.toString());
        yield SatelliteError(errorMessage: e.toString());
      }
    }
    if (event is SetShowImageSatellite) {
      PrefService.setBool(Constants.showImageForecastPage, event.showImage);
      yield SatelliteLoading(showAnimation: false);
      yield SatelliteLoaded(
        satellite: event.satellite,
        showImage: event.showImage,
        showAnimation: false,
      );
    }
  }
}
