import 'dart:async';

import 'package:meta/meta.dart';

import 'package:cuba_weather/models/models.dart';
import 'package:cuba_weather/repositories/data_providers/data_providers.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String location) async {
    return await weatherApiClient.fetchWeather(location);
  }
}
