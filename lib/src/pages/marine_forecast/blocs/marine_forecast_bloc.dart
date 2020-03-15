import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart';

import 'package:cuba_weather/src/pages/marine_forecast/blocs/blocs.dart';
import 'package:cuba_weather/src/utils/utils.dart';

class MarineForecastBloc extends Bloc<MarineForecastEvent, MarineForecastState> {
  final CubaWeather api;

  MarineForecastBloc({@required this.api}) : assert(api != null);

  @override
  MarineForecastState get initialState => MarineForecastInitial();

  @override
  Stream<MarineForecastState> mapEventToState(MarineForecastEvent event) async* {
    if (event is FetchMarineForecast) {
      yield MarineForecastLoading();
      try {
        InsmetMarineForecastModel forecast;
        switch (event.forecastType) {
          case 'marine':
            forecast = await api.getInsmetMarineForecast();
            break;
          default:
            forecast = await api.getInsmetMarineForecast();
            break;
        }
        yield MarineForecastLoaded(forecast: forecast);
      } on BadRequestException catch (e) {
        log(e.toString());
        yield MarineForecastError(
          errorMessage: Constants.errorMessageBadRequestException,
        );
      } catch (e) {
        log(e.toString());
        yield MarineForecastError(errorMessage: e.toString());
      }
    }
  }
}
