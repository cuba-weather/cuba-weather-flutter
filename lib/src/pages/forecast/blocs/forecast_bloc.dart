import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:preferences/preference_service.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/forecast/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final CubaWeather api;

  ForecastBloc({@required this.api}) : assert(api != null);

  @override
  ForecastState get initialState => ForecastInitial();

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    if (event is FetchForecast) {
      yield ForecastLoading();
      var keyPref = Constants.showImageForecastPage;
      var showImage = PrefService.getBool(keyPref) ?? false;
      try {
        InsmetForecastModel forecast;
        switch (event.forecastType) {
          case 'today':
            forecast = await api.getInsmetTodayForecast();
            break;
          case 'tomorrow':
            forecast = await api.getInsmetTomorrowForecast();
            break;
          case 'perspectives':
            forecast = await api.getInsmetPerspectiveForecast();
            break;
          default:
            forecast = await api.getInsmetTodayForecast();
            break;
        }
        yield ForecastLoaded(forecast: forecast, showImage: showImage);
      } on BadRequestException catch (e) {
        log(e.toString());
        yield ForecastError(
          errorMessage: Constants.errorMessageBadRequestException,
        );
      } catch (e) {
        log(e.toString());
        yield ForecastError(errorMessage: e.toString());
      }
    }
    if (event is SetShowImageForecast) {
      PrefService.setBool(Constants.showImageForecastPage, event.showImage);
      yield ForecastLoading(showAnimation: false);
      yield ForecastLoaded(
        forecast: event.forecast,
        showImage: event.showImage,
        showAnimation: false,
      );
    }
  }
}
