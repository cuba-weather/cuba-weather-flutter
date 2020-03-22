import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:preferences/preference_service.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/radar/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final CubaWeather api;

  RadarBloc({@required this.api}) : assert(api != null);

  @override
  RadarState get initialState => RadarInitial();

  @override
  Stream<RadarState> mapEventToState(RadarEvent event) async* {
    if (event is FetchRadar) {
      yield RadarLoading();
      //var keyPref = Constants.showImageForecastPage;
      //var showImage = PrefService.getBool(keyPref) ?? false;
      try {
        // InsmetRadarModel radar;
        // switch (event.radarType) {
        //   case 'latest_eastir.jpg':
        //     radar = await api.getRadarWisconsinMadisonLatestEastir();
        //     break;
        //   default://www.intellicast.com.jpg
        //     radar = await api.getRadarWeatherUndergroundIntellicast();
        //     break;
        // }
        // yield RadarLoaded(radar: radar, showImage: showImage);
      } on BadRequestException catch (e) {
        log(e.toString());
        yield RadarError(
          errorMessage: Constants.errorMessageBadRequestException,
        );
      } catch (e) {
        log(e.toString());
        yield RadarError(errorMessage: e.toString());
      }
    }
    if (event is SetShowImageRadar) {
      PrefService.setBool(Constants.showImageForecastPage, event.showImage);
      yield RadarLoading(showAnimation: false);
      yield RadarLoaded(
        radar: event.radar,
        showImage: event.showImage,
        showAnimation: false,
      );
    }
  }
}
