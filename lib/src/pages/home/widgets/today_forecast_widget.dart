import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:cuba_weather_dart/cuba_weather_dart.dart' as cwd;

import 'package:cuba_weather/src/pages/home/models/models.dart';

class TodayForecastWidget extends StatelessWidget {
  final WeatherModel weather;

  const TodayForecastWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIconCode = _weatherIconCodeByState(
      weather.getTodayForecast().state,
      weather.dateTime,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Pronóstico para Hoy',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Máxima',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${weather.getTodayForecast().temperatureMax.round()}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '°C',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          BoxedIcon(
                            WeatherIcons.thermometer,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BoxedIcon(
              WeatherIcons.fromString(weatherIconCode,
                  fallback: WeatherIcons.na),
              size: 100,
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Mínima',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${weather.getTodayForecast().temperatureMin.round()}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '°C',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          BoxedIcon(
                            WeatherIcons.thermometer,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Center(
          child: Text(
            weather.getTodayForecast().stateDescription,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String _weatherIconCodeByState(cwd.InsmetState state, DateTime dateTime) {
    bool itsDay = dateTime.hour > 6 && dateTime.hour < 19;
    String result = '';
    switch (state) {
      case cwd.InsmetState.OccasionalShowers:
        result = itsDay ? 'wi-day-rain' : 'wi-night-alt-rain';
        break;
      case cwd.InsmetState.ScatteredShowers:
        result = itsDay ? 'wi-rain' : 'wi-rain';
        break;
      case cwd.InsmetState.IsolatedShowers:
        result = itsDay ? 'wi-day-rain' : 'wi-night-alt-rain';
        break;
      case cwd.InsmetState.AfternoonShowers:
        result = itsDay ? 'wi-showers' : 'wi-showers';
        break;
      case cwd.InsmetState.RainShowers:
        result = itsDay ? 'wi-showers' : 'wi-night-alt-showers';
        break;
      case cwd.InsmetState.PartlyCloudy:
        result = itsDay ? 'wi-day-cloudy' : 'wi-night-alt-cloudy';
        break;
      case cwd.InsmetState.Cloudy:
        result = 'wi-cloudy';
        break;
      case cwd.InsmetState.Sunny:
        result = 'wi-day-sunny';
        break;
      case cwd.InsmetState.Storms:
        result = itsDay ? 'wi-day-thunderstorm' : 'wi-night-alt-thunderstorm';
        break;
      case cwd.InsmetState.AfternoonStorms:
        result = 'wi-thunderstorm';
        break;
      case cwd.InsmetState.MorningScatteredShowers:
        result = 'wi-rain';
        break;
      case cwd.InsmetState.Winds:
        result = 'wi-strong-wind';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }
}
