import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart';

import 'package:cuba_weather/models/models.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.redcuba.cu/api/weather_get_summary/';
  final Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<Weather> fetchWeather(String location) async {
    final url = baseUrl + location;
    final resp = await this.httpClient.get(url);
    if (resp.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final json = jsonDecode(resp.body);
    return Weather.fromJson(json);
  }
}
