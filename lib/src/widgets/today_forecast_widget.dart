import 'package:cuba_weather_dart/cuba_weather_dart.dart';
import 'package:cuba_weather_insmet_dart/cuba_weather_insmet_dart.dart' as aux;
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class TodayForecastWidget extends StatelessWidget {
  final WeatherModel weather;

  TodayForecastWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIconCode = _weatherIconCodeByState(
      weather.state,
      weather.dateTime,
    );
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

  String _weatherIconCodeByState(aux.State state, DateTime dateTime) {
    bool itsDay = dateTime.hour > 6 && dateTime.hour < 19;
    String result = '';
    switch (state) {
      case aux.State.OccasionalShowers:
        result = itsDay ? 'wi-day-rain': 'wi-night-alt-rain';
        break;
      case aux.State.ScatteredShowers:
        result = itsDay ? 'wi-rain': 'wi-rain';
        break;
      case aux.State.IsolatedShowers:
        result = itsDay ? 'wi-day-rain' : 'wi-night-alt-rain';
        break;
      case aux.State.AfternoonShowers:
        result = itsDay ? 'wi-showers' : 'wi-showers';
        break;
      case aux.State.RainShowers:
        result = itsDay ? 'wi-showers' : 'wi-night-alt-showers';
        break;
      case aux.State.PartlyCloudy:
        result = itsDay ? 'wi-day-cloudy' : 'wi-night-alt-cloudy';
        break;
      case aux.State.Cloudy:
        result = 'wi-cloudy';
        break;
      case aux.State.Sunny:
        result = 'wi-day-sunny';
        break;
      case aux.State.Storms:
        result = itsDay ? 'wi-day-thunderstorm' : 'wi-night-alt-thunderstorm';
        break;
      case aux.State.AfternoonStorms:
        result = 'wi-thunderstorm';
        break;
      default:
        result = 'wi-na';
    }
    return result;
  }
}
