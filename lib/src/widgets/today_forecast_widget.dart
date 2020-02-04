import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class TodayForecastWidget extends StatelessWidget {
  final WeatherModel weather;

  TodayForecastWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIconCode =
    _weatherIconCodeByState(weather.state.toString(), weather.dateTime);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Pronóstico para hoy:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
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
                      '${weather.temperatureMin.round()}',
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
                      '${weather.temperatureMax.round()}',
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
            weather.stateDescription,
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

  String _weatherIconCodeByState(String state, DateTime dateTime) {
    bool itsDay = true;

    if (dateTime.hour >= 19 || dateTime.hour <= 6) {
      itsDay = false;
    }

    String result = '';
    switch (state) {
      case 'State.OccasionalShowers':
        if (itsDay) {
          result = 'wi-day-rain';
        } else {
          result = 'wi-night-alt-rain';
        }
        break;
      case 'State.ScatteredShowers':
        if (itsDay) {
          result = 'wi-rain';
        } else {
          result = 'wi-rain';
        }
        break;
      case 'State.IsolatedShowers':
        if (itsDay) {
          result = 'wi-day-rain';
        } else {
          result = 'wi-night-alt-rain';
        }
        break;
      case 'State.AfternoonShowers':
        if (itsDay) {
          result = 'wi-showers';
        } else {
          result = 'wi-showers';
        }
        break;
      case 'State.RainShowers':
        if (itsDay) {
          result = 'wi-showers';
        } else {
          result = 'wi-night-alt-showers';
        }
        break;
      case 'State.PartlyCloudy':
        if (itsDay) {
          result = 'wi-day-cloudy';
        } else {
          result = 'wi-night-alt-cloudy';
        }
        break;
      case 'State.Cloudy':
        result = 'wi-cloudy';
        break;
      case 'State.Sunny':
        result = 'wi-day-sunny';
        break;
      case 'State.Storms':
        if (itsDay) {
          result = 'wi-day-thunderstorm';
        } else {
          result = 'wi-night-alt-thunderstorm';
        }
        break;
      case 'State.AfternoonStorms':
        result = 'wi-thunderstorm';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }
}
